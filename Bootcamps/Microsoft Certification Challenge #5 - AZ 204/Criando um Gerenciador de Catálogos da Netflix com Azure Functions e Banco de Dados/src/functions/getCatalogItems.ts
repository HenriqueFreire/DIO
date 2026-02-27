import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { CosmosClient } from "@azure/cosmos";
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
const REDIS_CACHE_EXPIRATION_SECONDS = 60; // Cache for 60 seconds

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

    // Ensure database and container exist - partitionKey for this container is '/id'
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

export async function getCatalogItems(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);

    if (!cosmosClient) {
        return {
            status: 500,
            body: "Cosmos DB client not initialized."
        };
    }

    try {
        if (redisClient) {
            const cachedItems = await redisClient.get('allCatalogItems');
            if (cachedItems) {
                context.log('Returning items from Redis cache.');
                return {
                    status: 200,
                    jsonBody: JSON.parse(cachedItems)
                };
            }
        }

        // Query all items from the container
        const { resources: items } = await container.items.query("SELECT * FROM c").fetchAll();

        if (redisClient) {
            // Store items in Redis cache with an expiration time
            await redisClient.setex('allCatalogItems', REDIS_CACHE_EXPIRATION_SECONDS, JSON.stringify(items));
            context.log(`Stored ${items.length} items in Redis cache.`);
        }

        return {
            status: 200,
            jsonBody: items
        };
    } catch (error) {
        context.error("Error retrieving catalog items:", error);
        return {
            status: 500,
            body: "Error retrieving catalog items."
        };
    }
};

app.http('getCatalogItems', {
    methods: ['GET'],
    authLevel: 'anonymous',
    handler: getCatalogItems
});
