# Forum API

This is a simple Forum API built with TypeScript, Node.js, Express, and managed with Nix. It provides basic CRUD (Create, Read, Update, Delete) operations for forum posts.

## Technologies Used

*   **TypeScript**: A typed superset of JavaScript that compiles to plain JavaScript.
*   **Node.js**: A JavaScript runtime built on Chrome's V8 JavaScript engine.
*   **Express.js**: A fast, unopinionated, minimalist web framework for Node.js.
*   **Nix/NixOS**: A purely functional package manager and operating system that ensures reproducible development environments.
*   **ts-node**: TypeScript execution environment and REPL for Node.js.
*   **nodemon**: A tool that helps develop Node.js based applications by automatically restarting the node application when file changes in the directory are detected.

## Setup

### Prerequisites

*   [Nix](https://nixos.org/download.html) installed on your system.

### Steps

1.  **Clone the repository** (if applicable, or navigate to the project directory):
    ```bash
    # If not already in the project directory
    # cd path/to/your/project
    cd forum-api
    ```

2.  **Enter the Nix development shell**:
    This command will use the `shell.nix` file to set up the correct Node.js and TypeScript environment.
    ```bash
    nix-shell
    ```
    You should see `[nix-shell:~.../forum-api]$` in your prompt, indicating you are in the Nix shell.

3.  **Install Node.js dependencies**:
    While in the `nix-shell`, install the project dependencies.
    ```bash
    npm install
    ```

## How to Run the API

While in the `nix-shell` (after running `nix-shell` and `npm install`), you can start the API in development mode using:

```bash
npm run dev
```

The server will start on `http://localhost:3000`. `nodemon` will watch for changes in the `src` directory and automatically restart the server.

## API Endpoints

The API provides the following endpoints for managing posts:

### Health Check

*   **GET `/health`**
    Checks the health of the API.
    Response:
    ```json
    {
      "status": "UP"
    }
    ```

    **Example:**
    ```bash
    curl http://localhost:3000/health
    ```

### Posts

#### Get All Posts

*   **GET `/posts`**
    Retrieves a list of all posts.

    **Example:**
    ```bash
    curl http://localhost:3000/posts
    ```

#### Get a Single Post by ID

*   **GET `/posts/:id`**
    Retrieves a single post by its ID.

    **Example:**
    ```bash
    curl http://localhost:3000/posts/1
    ```

#### Create a New Post

*   **POST `/posts`**
    Creates a new post.
    Request Body:
    ```json
    {
      "title": "My New Post",
      "content": "This is the content of my new post.",
      "author": "Jane Doe"
    }
    ```

    **Example:**
    ```bash
    curl -X POST -H "Content-Type: application/json" -d '{"title": "My New Post", "content": "This is the content of my new post.", "author": "Jane Doe"}' http://localhost:3000/posts
    ```

#### Update an Existing Post

*   **PUT `/posts/:id`**
    Updates an existing post by its ID.
    Request Body:
    ```json
    {
      "title": "Updated Title",
      "content": "Updated content of the post.",
      "author": "Jane Doe"
    }
    ```

    **Example:**
    ```bash
    curl -X PUT -H "Content-Type: application/json" -d '{"title": "Updated Title", "content": "Updated content of the post.", "author": "Jane Doe"}' http://localhost:3000/posts/1
    ```

#### Delete a Post

*   **DELETE `/posts/:id`**
    Deletes a post by its ID.

    **Example:**
    ```bash
    curl -X DELETE http://localhost:3000/posts/1
    ```
