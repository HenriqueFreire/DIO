# Modelagem de Dados em Grafos de um Serviço de Streaming (Neo4j)

Este projeto demonstra a modelagem de um banco de dados de grafos para um serviço de streaming de filmes, utilizando Neo4j como banco de dados e uma imagem PNG para visualização do esquema.

## Visão Geral do Modelo de Dados

O modelo de dados representa as seguintes entidades e seus relacionamentos:

### Entidades (Nós)

*   **`Movie`**: Filmes com propriedades como `title`, `releaseYear`, `duration` e `synopsis`.
*   **`User`**: Usuários com `username`, `email` e `registrationDate`.
*   **`Actor`**: Atores com `name`, `birthDate` e `birthplace`.
*   **`Director`**: Diretores com `name`, `birthDate` e `birthplace`.
*   **`Genre`**: Gêneros de filmes com `name`.

### Relacionamentos (Arestas)

*   `(User)-[:WATCHED]->(Movie)`: Indica que um usuário assistiu a um filme.
*   `(User)-[:RATED {rating: <integer>}]->(Movie)`: Indica a avaliação de um usuário para um filme (com uma propriedade `rating` de 1 a 5).
*   `(User)-[:HAS_FAVORITE_GENRE]->(Genre)`: Indica o gênero favorito de um usuário.
*   `(Movie)-[:HAS_GENRE]->(Genre)`: Associa um filme a um gênero.
*   `(Movie)-[:DIRECTED_BY]->(Director)`: Associa um filme a um diretor.
*   `(Actor)-[:ACTED_IN]->(Movie)`: Associa um ator a um filme em que atuou.

## Diagrama do Modelo de Dados

O esquema do banco de dados pode ser visualizado no diagrama abaixo:

![Diagrama do Modelo de Dados](schema_representation.png)

## Configuração do Ambiente de Desenvolvimento (Nix-Shell)

Este projeto utiliza nix-shell para gerenciar o ambiente de desenvolvimento, garantindo que todas as dependências (Neo4j, Java) estejam disponíveis e configuradas corretamente.

1.  **Certifique-se de ter o Nix instalado:** Se você não tem o Nix instalado, siga as instruções em [nixos.org](https://nixos.org/download.html).

2.  **Entre no ambiente `nix-shell`:**
    ```bash
    nix-shell
    ```
    Na primeira vez, o Nix fará o download e a configuração das dependências. O `shellHook` configurará o ambiente do Neo4j para usar diretórios graváveis em `$HOME/neo4j-streaming-work`.

## Operações com o Neo4j

### Iniciar o Servidor Neo4j

Dentro do `nix-shell`, inicie o servidor Neo4j:

```bash
neo4j start
```
Você verá uma mensagem indicando que o Neo4j foi iniciado e está disponível em `http://0.0.0.0:7474`.

### Acessar o Neo4j Browser

Abra seu navegador web e vá para `http://0.0.0.0:7474` (ou `http://localhost:7474`).
Use o usuário `neo4j` e a senha `neo4j1234` para fazer login.

### Popular o Banco de Dados

O script `streaming_database.cypher` contém os comandos para criar as restrições, índices e popular o banco de dados com 10 filmes, 10 usuários, 10 diretores e mais de 10 atores.

Para popular o banco de dados:

```bash
/nix/store/566xiby1j8qb230hn8jqqgi3mwjk6jcq-neo4j-5.26.1/bin/cypher-shell -u neo4j -p neo4j1234 -f streaming_database.cypher
```

### Limpar o Banco de Dados

O script `cleanup_neo4j_database.cypher` contém os comandos para remover todas as restrições, índices e dados do banco de dados, deixando-o em um estado limpo.

Para limpar o banco de dados:

```bash
/nix/store/566xiby1j8qb230hn8jqqgi3mwjk6jcq-neo4j-5.26.1/bin/cypher-shell -u neo4j -p neo4j1234 -f cleanup_neo4j_database.cypher
```

### Parar o Servidor Neo4j

Dentro do `nix-shell`, pare o servidor Neo4j:

```bash
neo4j stop
```

## Consultas Cypher de Exemplo

Aqui estão algumas consultas Cypher que você pode executar no Neo4j Browser para explorar os dados:

*   **Contar todos os nós:**
    ```cypher
    MATCH (n) RETURN count(n);
    ```
*   **Listar todos os filmes com seus gêneros:**
    ```cypher
    MATCH (m:Movie)-[:HAS_GENRE]->(g:Genre) RETURN m.title, g.name;
    ```
*   **Encontrar filmes dirigidos por 'Christopher Nolan':**
    ```cypher
    MATCH (d:Director {name: 'Christopher Nolan'})-[:DIRECTED_BY]->(m:Movie) RETURN m.title;
    ```
*   **Encontrar usuários que assistiram 'Inception' e sua avaliação:**
    ```cypher
    MATCH (u:User)-[r:RATED]->(m:Movie {title: 'Inception'}) RETURN u.username, r.rating;
    ```
*   **Encontrar atores que atuaram em 'The Matrix':**
    ```cypher
    MATCH (a:Actor)-[:ACTED_IN]->(m:Movie {title: 'The Matrix'}) RETURN a.name;
    ```
