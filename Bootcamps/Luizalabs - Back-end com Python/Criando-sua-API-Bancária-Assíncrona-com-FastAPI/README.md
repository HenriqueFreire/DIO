# Transactions API

A microservice for maintaining withdrawal and deposit operations from current accounts, built with FastAPI.

## Features

*   **Account Management**: Create and list user accounts.
*   **Transaction Management**: Create and list transactions for specific accounts.
*   **Authentication**: Secure endpoints using JWT.
*   **Optimized Pagination**: Uses keyset pagination for efficient data retrieval.

## Technologies Used

*   [Python 3.11+](https://www.python.org/)
*   [FastAPI](https://fastapi.tiangolo.com/) - A modern, fast (high-performance) web framework for building APIs.
*   [Uvicorn](https://www.uvicorn.org/) - An ASGI server.
*   [SQLAlchemy](https://www.sqlalchemy.org/) - The Python SQL Toolkit and Object Relational Mapper.
*   [Alembic](https://alembic.sqlalchemy.org/en/latest/) - A lightweight database migration tool for SQLAlchemy.
*   [Pydantic](https://docs.pydantic.dev/) - Data validation and settings management using Python type annotations.
*   [Poetry](https://python-poetry.org/) - For dependency management.

## Getting Started

### Prerequisites

*   Python 3.11 or higher
*   Poetry
*   A running PostgreSQL instance

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd Criando-sua-API-Bancária-Assíncrona-com-FastAPI
    ```

2.  **Install dependencies using Poetry:**
    ```bash
    poetry install
    ```

3.  **Set up the environment:**
    Create a `.env` file in the root of the project and add the required environment variables. You can use the `.env.example` as a template.

    ```env
    # .env
    DATABASE_URL="postgresql+asyncpg://user:password@host:port/database_name"
    ```

4.  **Run database migrations:**
    Apply the database migrations to create the necessary tables.
    ```bash
    alembic upgrade head
    ```

### Running the Application

To start the API server, run the following command from the project root:

```bash
uvicorn src.main:app --reload
```

The API will be available at `http://127.0.0.1:8000`.

## API Endpoints

The interactive API documentation (Swagger UI) is available at `http://127.0.0.1:8000/docs`.

### Auth

*   **`POST /auth/login`**: Authenticate to get an access token.
    *   **Body**:
        ```json
        {
          "user_id": 1
        }
        ```

### Accounts

*   **`POST /accounts/`**: Create a new account. (Authentication required)
*   **`GET /accounts/`**: List all accounts with pagination. (Authentication required)
    *   **Query Params**: `limit` (int), `last_id` (int, optional)
*   **`GET /accounts/{id}/transactions`**: List all transactions for a specific account. (Authentication required)
    *   **Query Params**: `limit` (int), `last_id` (int, optional)

### Transactions

*   **`POST /transactions/`**: Create a new transaction (DEPOSIT or WITHDRAWAL). (Authentication required)
    *   **Body**:
        ```json
        {
          "account_id": 1,
          "type": "DEPOSIT",
          "amount": 100.50
        }
        ```
