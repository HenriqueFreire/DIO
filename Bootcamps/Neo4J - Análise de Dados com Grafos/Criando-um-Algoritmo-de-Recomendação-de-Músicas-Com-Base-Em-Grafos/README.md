# Algoritmo de Recomendação de Músicas Baseado em Grafos

Este projeto implementa um algoritmo de recomendação de músicas utilizando o banco de dados de grafos Neo4j. Ele demonstra como modelar dados de usuários, músicas, artistas, álbuns e gêneros como um grafo e, em seguida, usar consultas Cypher para gerar recomendações personalizadas.

## Funcionalidades

*   **Modelagem de Grafo:** Representação rica de entidades musicais e usuários.
*   **Ambiente Nix:** Configuração automatizada do ambiente de desenvolvimento com Neo4j e Java via `shell.nix`.
*   **População de Dados:** Script Cypher para popular o grafo com dados de exemplo.
*   **Múltiplos Algoritmos de Recomendação:**
    *   Recomendação baseada em músicas ouvidas por usuários similares.
    *   Recomendação baseada em artistas em comum entre usuários.
    *   Recomendação baseada no gênero favorito do usuário.
    *   Um algoritmo combinado que pondera os resultados das três estratégias anteriores.

## Pré-requisitos

*   **Nix Package Manager:** Este projeto utiliza o Nix para gerenciar o ambiente de desenvolvimento. Certifique-se de tê-lo instalado.
    *   [Instalação do Nix](https://nixos.org/download.html)

## Configuração e Uso

Siga os passos abaixo para configurar e executar o projeto.

### 1. Entrar no Ambiente de Desenvolvimento

Navegue até o diretório raiz do projeto no seu terminal e entre no `nix-shell`:

```bash
nix-shell
```
O `shellHook` no `shell.nix` irá configurar automaticamente um diretório de trabalho para o Neo4j em `~/neo4j-music-rec-work` e copiar as configurações necessárias.

### 2. Iniciar o Servidor Neo4j

Dentro do `nix-shell`, inicie o servidor Neo4j:

```bash
neo4j start
```
Você deverá ver uma mensagem de sucesso indicando que o Neo4j foi iniciado e está disponível em `http://0.0.0.0:7474`.

### 3. Alterar a Senha Padrão e Popular o Banco de Dados

No primeiro acesso, o Neo4j exige a troca da senha padrão (`neo4j`). O script `setup_database.cypher` irá guiá-lo por este processo.

```bash
cypher-shell -f setup_database.cypher
```
Quando solicitado:
*   `username:` digite `neo4j`
*   `password:` digite `neo4j` (a senha padrão)
*   `Password change required`
*   `new password:` digite sua nova senha (ex: `12345678`)
*   `confirm password:` digite sua nova senha novamente

Após a troca de senha, o script `setup_database.cypher` será executado, populando o banco de dados com os nós e relacionamentos.

### 4. Executar os Algoritmos de Recomendação

Com o banco de dados populado, você pode executar os diferentes algoritmos de recomendação. Lembre-se de substituir `<sua-nova-senha>` pela senha que você definiu.

*   **Recomendação por Músicas Similares (`rec_by_song.cypher`)**
    ```bash
    cypher-shell -u neo4j -p <sua-nova-senha> -f rec_by_song.cypher
    ```

*   **Recomendação por Artistas Similares (`rec_by_artist.cypher`)**
    ```bash
    cypher-shell -u neo4j -p <sua-nova-senha> -f rec_by_artist.cypher
    ```

*   **Recomendação por Gênero Favorito (`rec_by_genre.cypher`)**
    ```bash
    cypher-shell -u neo4j -p <sua-nova-senha> -f rec_by_genre.cypher
    ```

*   **Recomendação Combinada (Mais Abrangente) (`rec_combined.cypher`)**
    ```bash
    cypher-shell -u neo4j -p <sua-nova-senha> -f rec_combined.cypher
    ```

### 5. Parar o Servidor Neo4j

Quando terminar de usar o Neo4j, pare o servidor:

```bash
neo4j stop
```

## Modelo de Dados

O grafo é composto pelos seguintes tipos de nós e relacionamentos:

*   **(User)**: Representa um usuário.
    *   Propriedades: `name`
*   **(Music)**: Representa uma música.
    *   Propriedades: `name`
*   **(Artist)**: Representa um artista ou banda.
    *   Propriedades: `name`
*   **(Album)**: Representa um álbum.
    *   Propriedades: `name`
*   **(Composer)**: Representa um compositor.
    *   Propriedades: `name`
*   **(Genre)**: Representa um gênero musical.
    *   Propriedades: `name`

**Relacionamentos:**

*   `(User)-[:LISTENED_TO]->(Music)`: Indica que um usuário ouviu uma música.
*   `(Music)-[:BELONGS_TO_GENRE]->(Genre)`: Associa uma música a um gênero.
*   `(Artist)-[:PERFORMED]->(Music)`: Indica que um artista performou uma música.
*   `(Music)-[:PART_OF]->(Album)`: Indica que uma música faz parte de um álbum.
*   `(Artist)-[:RELEASED]->(Album)`: Indica que um artista lançou um álbum.
*   `(Composer)-[:WROTE]->(Music)`: Indica que um compositor escreveu uma música.