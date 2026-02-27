# Gerenciador de Catálogos da Netflix com Azure Functions e CosmosDB

Este projeto implementa um gerenciador de catálogos simples para a Netflix utilizando Azure Functions (TypeScript), CosmosDB para persistência de dados e Redis para caching. O ambiente de desenvolvimento é configurado via `shell.nix` para NixOS.

## Estrutura do Projeto

-   `shell.nix`: Define o ambiente de desenvolvimento com Node.js, TypeScript, Azure Functions Core Tools e outras dependências.
-   `src/functions/createCatalogItem.ts`: Função HTTP POST para criar/atualizar itens no catálogo e invalidar o cache Redis.
-   `src/functions/getCatalogItems.ts`: Função HTTP GET para listar todos os itens do catálogo, utilizando cache Redis.
-   `local.settings.json`: Configurações locais para as Azure Functions, incluindo strings de conexão para CosmosDB e Redis.
-   `package.json`: Gerenciamento de dependências Node.js.
-   `host.json`: Configurações globais para o host das Azure Functions.
-   `tsconfig.json`: Configurações do TypeScript.

## Configuração

Para que as funções operem corretamente, você precisa configurar o CosmosDB e o Redis.

### 1. Configurar Azure Cosmos DB

1.  **Crie uma conta Azure Cosmos DB** no portal do Azure (se ainda não tiver uma).
2.  No portal do Azure, navegue até sua conta Cosmos DB e em "Settings" > "Keys", obtenha a **Primary Connection String**.
3.  **Atualize `local.settings.json`:**
    Substitua `"AccountEndpoint=YOUR_COSMOSDB_ENDPOINT;AccountKey=YOUR_COSMOSDB_KEY;"` (o valor da chave `CosmosDbConnection` dentro de `Values`) pela sua string de conexão real do CosmosDB.

    Exemplo:
    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "",
        "FUNCTIONS_WORKER_RUNTIME": "node",
        "CosmosDbConnection": "AccountEndpoint=https://your-cosmos-db.documents.azure.com:443/;AccountKey=YOUR_ACTUAL_KEY_HERE;",
        "CosmosDbDatabaseName": "NetflixCatalogDb",
        "CosmosDbContainerName": "Items",
        "RedisConnection": "YOUR_REDIS_CONNECTION_STRING"
      }
    }
    ```
    O projeto criará automaticamente o banco de dados `NetflixCatalogDb` e o contêiner `Items` com `id` como chave de partição.

### 2. Configurar Azure Cache for Redis

1.  **Crie uma instância do Azure Cache for Redis** no portal do Azure (ou configure um servidor Redis local/remoto).
2.  No portal do Azure, obtenha a **Connection String** ou as informações de host/porta/senha do seu Redis.
3.  **Atualize `local.settings.json`:**
    Substitua `"YOUR_REDIS_CONNECTION_STRING"` (o valor da chave `RedisConnection` dentro de `Values`) pela sua string de conexão Redis. Se você estiver usando um Redis local ou sem senha, pode ser algo como `localhost:6379`.

    Exemplo:
    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "",
        "FUNCTIONS_WORKER_RUNTIME": "node",
        "CosmosDbConnection": "AccountEndpoint=https://your-cosmos-db.documents.azure.com:443/;AccountKey=YOUR_ACTUAL_KEY_HERE;",
        "CosmosDbDatabaseName": "NetflixCatalogDb",
        "CosmosDbContainerName": "Items",
        "RedisConnection": "yourredis.redis.cache.windows.net:6380,password=YOUR_REDIS_KEY_HERE,ssl=True,abortConnect=False"
      }
    }
    ```

## Executando o Projeto Localmente

1.  Abra um terminal na pasta raiz do seu projeto.
2.  Entre no ambiente `nix-shell` que configuramos. Este comando carregará todas as ferramentas e dependências necessárias (Node.js, TypeScript, Azure Functions Core Tools, etc.):
    ```bash
    nix-shell
    ```
3.  Com o `nix-shell` ativo, inicie o host das Azure Functions:
    ```bash
    func start
    ```
    As funções serão iniciadas e você verá as URLs para `createCatalogItem` e `getCatalogItems` no console. Por padrão, elas serão algo como `http://localhost:7071/api/createCatalogItem` e `http://localhost:7071/api/getCatalogItems`.

## Testando as Funções

Você pode usar ferramentas como Postman, Insomnia ou `curl` para testar as APIs.

### 1. Criar um Item de Catálogo (POST)

Envie uma requisição `POST` para `http://localhost:7071/api/createCatalogItem`.
O `Content-Type` do cabeçalho deve ser `application/json`.
O corpo da requisição deve ser um JSON representando um `CatalogItem` com os seguintes campos:

```typescript
interface CatalogItem {
    id?: string; // Opcional, será gerado se não fornecido
    title: string;
    description: string;
    genre: string;
    releaseYear: number; // Ex: 2024
    director: string;
    actors: string[];    // Ex: ["Ator A", "Atriz B"]
    rating: number;      // Ex: 9.2 (entre 0 e 10)
    thumbnailUrl: string; // URL da imagem em miniatura
}
```

Exemplo de comando `curl`:

```bash
curl -X POST -H "Content-Type: application/json" -d '{
    "title": "Minha Série de Teste",
    "description": "Uma série excelente para testar o sistema de catálogos.",
    "genre": "Drama",
    "releaseYear": 2024,
    "director": "Fulano de Tal",
    "actors": ["Ator A", "Atriz B"],
    "rating": 9.2,
    "thumbnailUrl": "https://example.com/serie_teste.jpg"
}' http://localhost:7071/api/createCatalogItem
```

### 2. Listar Itens do Catálogo (GET)

Envie uma requisição `GET` para `http://localhost:7071/api/getCatalogItems`.

Exemplo de comando `curl`:

```bash
curl http://localhost:7071/api/getCatalogItems
```

A resposta será um array JSON contendo todos os itens do catálogo.

## Observações

-   A função `createCatalogItem` invalidará o cache de todos os itens (`allCatalogItems`) no Redis após uma criação/atualização bem-sucedida para garantir que a próxima requisição GET obtenha os dados mais recentes do CosmosDB.
-   A função `getCatalogItems` tentará buscar os itens do cache Redis primeiro. Se não encontrar, buscará no CosmosDB e armazenará o resultado no Redis por 60 segundos.
-   Se a variável de ambiente `RedisConnection` não for definida, o caching será desabilitado.
-   O projeto do Azure Functions configurará automaticamente o banco de dados e o contêiner no CosmosDB se eles não existirem.
