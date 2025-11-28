# Análise de Redes Sociais com Grafos - Sistema de Recomendação

Este projeto demonstra como utilizar o banco de dados de grafos **Neo4j** para modelar uma simples rede social e construir um sistema de recomendação de usuários.

O sistema de recomendação sugere novas conexões com base em:
- Amigos em comum.
- Locais em comum (cidade, empresa, instituição de ensino).

O ambiente de desenvolvimento é totalmente gerenciado pelo **Nix**, garantindo uma configuração rápida e reproduzível.

## Pré-requisitos

Para executar este projeto, você precisa ter o [Nix](https://nixos.org/download.html) instalado no seu sistema. Nenhuma outra dependência, como Java ou Neo4j, precisa ser instalada manualmente.

## Configuração do Ambiente

O `shell.nix` cuidará de tudo. Para entrar no ambiente de desenvolvimento, execute o seguinte comando na raiz do projeto:

```bash
nix-shell
```

Este comando irá baixar e configurar o Neo4j e o JDK automaticamente, deixando o ambiente pronto para uso.

## Como Usar

Após entrar no ambiente com `nix-shell`, você pode controlar o servidor Neo4j e executar as consultas.

### 1. Iniciar o Servidor Neo4j

```bash
neo4j start
```

O servidor estará disponível em `http://localhost:7474` (Neo4j Browser) e `bolt://localhost:7687` (Bolt).

### 2. Importar os Dados

O arquivo `data/import_data.cypher` contém os dados de exemplo. Para populá-los no banco de dados, execute:

```bash
cypher-shell < data/import_data.cypher
```

> **Nota:** A autenticação foi desabilitada no arquivo `neo4j.conf` para simplificar o desenvolvimento.

### 3. Executar Consultas de Recomendação

Os scripts de recomendação estão no diretório `data/`. Você pode executá-los usando o `cypher-shell`.

**Exemplo (executando a consulta de ranking simples):**

```bash
cypher-shell < data/recommend_final_ranking_simple.cypher
```

### 4. Parar o Servidor Neo4j

Quando terminar, pare o servidor com:

```bash
neo4j stop
```

### Execução de Teste Automatizado

Para verificar rapidamente o funcionamento de todo o fluxo (iniciar, importar, consultar e parar), você pode usar o comando abaixo, que automatiza todos os passos:

```bash
nix-shell --run "neo4j start && sleep 20 && neo4j status && cypher-shell < data/import_data.cypher && cypher-shell < data/recommend_final_ranking_simple.cypher && neo4j stop"
```

## Estrutura do Projeto

-   `shell.nix`: Arquivo de configuração do Nix que define o ambiente de desenvolvimento (Neo4j, JDK).
-   `neo4j.conf`: Arquivo de configuração principal do Neo4j.
-   `data/`: Contém todos os scripts Cypher.
    -   `import_data.cypher`: Cria o esquema do grafo e popula com dados de exemplo.
    -   `recommend_friends_of_friends.cypher`: Consulta para sugerir amigos de amigos.
    -   `recommend_by_common_places.cypher`: Consulta para sugerir usuários com base em locais em comum.
    -   `recommend_final_ranking_weighted.cypher`: Consulta final com pontuação ponderada.
    -   `recommend_final_ranking_simple.cypher`: Consulta final com pontuação simplificada (1 ponto por conexão).
-   `neo4j-work/`: Diretório de trabalho do Neo4j, criado em tempo de execução pelo `shell.nix`.
-   `logs/`: Contém os logs do Neo4j, criado em tempo de execução.
