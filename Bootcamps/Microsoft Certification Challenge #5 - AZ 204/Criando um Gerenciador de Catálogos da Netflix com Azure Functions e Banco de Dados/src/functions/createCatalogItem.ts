import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { CosmosClient } from "@azure/cosmos";
import { v4 as uuidv4 } from "uuid";
import Redis from "ioredis";

interface CatalogItem {
    id?: string;
    title: string;
    description: string;
    genre: string;
    releaseYear: number;
    director: string;
    actors: string[];
    rating: number;
    thumbnailUrl: string;
}

const COSMOS_DB_CONNECTION = process.env.CosmosDbConnection;
const COSMOS_DB_DATABASE_NAME = process.env.CosmosDbDatabaseName || "NetflixCatalogDb";
const COSMOS_DB_CONTAINER_NAME = process.env.CosmosDbContainerName || "Items";
const REDIS_CONNECTION_STRING = process.env.RedisConnection;

let cosmosClient: CosmosClient;
let database: any;
let container: any;
let redisClient: Redis;

async function initializeCosmosDb() {
    if (!COSMOS_DB_CONNECTION) {
        throw new Error("CosmosDbConnection environment variable is not set.");
    }
    cosmosClient = new CosmosClient(COSMOS_DB_CONNECTION);
    database = cosmosClient.database(COSMOS_DB_DATABASE_NAME);
    container = database.container(COSMOS_DB_CONTAINER_NAME);

    // Ensure database and container exist
    await cosmosClient.databases.createIfNotExists({ id: COSMOS_DB_DATABASE_NAME });
    await database.containers.createIfNotExists({ id: COSMOS_DB_CONTAINER_NAME, partitionKey: "/id" });
}

function initializeRedis() {
    if (!REDIS_CONNECTION_STRING) {
        console.warn("RedisConnection environment variable is not set. Caching will be disabled.");
        return;
    }
    redisClient = new Redis(REDIS_CONNECTION_STRING);
    redisClient.on('error', (err) => console.error('Redis Client Error', err));
    console.log("Redis client initialized.");
}

// Initialize Cosmos DB and Redis clients once
initializeCosmosDb().catch(error => {
    console.error("Failed to initialize Cosmos DB:", error);
});
initializeRedis();

export async function createCatalogItem(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);

    if (!cosmosClient) {
        return {
            status: 500,
            body: "Cosmos DB client not initialized."
        };
    }

    let catalogItem: CatalogItem;
    try {
        catalogItem = await request.json() as CatalogItem;
    } catch (error) {
        return {
            status: 400,
            body: "Please pass a valid JSON object in the request body."
        };
    }

    // Basic validation
    if (!catalogItem.title || !catalogItem.description || !catalogItem.genre || !catalogItem.releaseYear || !catalogItem.director || !catalogItem.actors || !catalogItem.rating || !catalogItem.thumbnailUrl) {
        return {
            status: 400,
            body: "Please provide all required fields: title, description, genre, releaseYear, director, actors, rating, thumbnailUrl."
        };
    }

    // Ensure actors is an array
    if (!Array.isArray(catalogItem.actors)) {
        return {
            status: 400,
            body: "Actors must be an array."
        };
    }

    if (typeof catalogItem.rating !== 'number' || catalogItem.rating < 0 || catalogItem.rating > 10) {
        return {
            status: 400,
            body: "Rating must be a number between 0 and 10."
        };
    }

    if (typeof catalogItem.releaseYear !== 'number' || catalogItem.releaseYear < 1800 || catalogItem.releaseYear > new Date().getFullYear() + 5) {
        return {
            status: 400,
            body: `Release year must be a number between 1800 and ${new Date().getFullYear() + 5}.`
        };
    }

    catalogItem.id = catalogItem.id || uuidv4(); // Generate ID if not provided

    try {
        const { resource: createdItem } = await container.items.upsert(catalogItem);

        if (redisClient) {
            // Invalidate the cache for all catalog items
            await redisClient.del('allCatalogItems');
            context.log('Invalidated allCatalogItems cache.');
        }

        return {
            status: 201,
            jsonBody: createdItem
        };
    } catch (error) {
        context.error("Error creating catalog item:", error);
        return {
            status: 500,
            body: "Error creating the catalog item."
        };
    }
};

app.http('createCatalogItem', {
    methods: ['POST'],
    authLevel: 'anonymous',
    handler: createCatalogItem
});
