# Projeto de Banco de Dados para E-commerce

Este projeto consiste na criação de um esquema de banco de dados para um sistema de e-commerce, desenvolvido como parte de um desafio de projeto. O script SQL (`Ecommerce - Scripts.sql`) inclui a criação das tabelas (DDL), a inserção de dados de exemplo (DML) e uma série de consultas (queries) para extrair informações relevantes do negócio.

## Descrição do Projeto Lógico

O modelo de dados foi projetado para suportar as operações fundamentais de uma plataforma de e-commerce, incluindo o gerenciamento de clientes, produtos, pedidos, pagamentos, estoque, fornecedores e vendedores.

As principais entidades são:

*   **Cliente (`client`):** Armazena informações sobre os clientes. O modelo foi refinado para suportar tanto Pessoas Físicas (PF), identificadas por CPF, quanto Pessoas Jurídicas (PJ), identificadas por CNPJ.
*   **Produto (`product`):** Contém detalhes sobre os produtos à venda, como nome, categoria e avaliação.
*   **Pedido (`orders`):** Registra os pedidos feitos pelos clientes, incluindo status da entrega e código de rastreio.
*   **Pagamento (`payment`):** Permite que um cliente tenha múltiplas formas de pagamento cadastradas.
*   **Fornecedor (`supplier`):** Armazena dados dos fornecedores de produtos.
*   **Vendedor (`seller`):** Gerencia os vendedores da plataforma, que podem ser tanto pessoas físicas (CPF) quanto jurídicas (CNPJ).
*   **Estoque (`productSeller`):** Controla a quantidade de cada produto por vendedor, servindo como a tabela central para a gestão de estoque.

## Esquema Entidade-Relacionamento (EER)

O diagrama abaixo representa a estrutura lógica e os relacionamentos entre as tabelas do banco de dados.

<details>
<summary>Clique para expandir o diagrama EER</summary>

```mermaid
erDiagram
    client {
        int idClient PK
        varchar Fname
        char Minit
        varchar Lname
        char CPF "unique"
        char CNPJ "unique"
        varchar Address
        enum ClientType
    }

    product {
        int idProduct PK
        varchar Pname
        boolean classification_kids
        enum category
        decimal rating
        varchar size
    }

    payment {
        int idPayment PK
        int idClient FK
        enum typePayment
        decimal limitAvailable
    }

    orders {
        int idOrder PK
        int idClient FK
        int idPayment FK
        enum orderStatus
        varchar orderDescription
        decimal sendValue
        boolean paymentCash
        varchar trackingCode
    }

    supplier {
        int idSupplier PK
        varchar SocialName
        char CNPJ "unique"
        char contact
    }

    seller {
        int idSeller PK
        varchar SocialName
        varchar AbstName
        char CNPJ "unique"
        char CPF "unique"
        varchar location
        char contact
    }

    productSeller {
        int idPseller PK, FK
        int idProduct PK, FK
        int prodQuantity
    }

    productOrder {
        int idPoProduct PK, FK
        int idPorder PK, FK
        int poQuantity
    }

    client ||--o{ payment : "has"
    client ||--o{ orders : "places"
    payment ||--o{ orders : "is for"
    
    orders }o--o{ productOrder : "contains"
    productOrder o--o{ product : "references"

    seller }o--o{ productSeller : "sells"
    productSeller o--o{ product : "is"
```

</details>


## Como Executar o Projeto Localmente

Estas instruções detalham como configurar e executar o banco de dados MariaDB para este projeto usando o ambiente Nix, que garante uma configuração consistente e reproduzível.

### Pré-requisitos

- **Nix:** Você precisa ter o [Nix package manager](https://nixos.org/download.html) instalado no seu sistema (Linux, macOS, ou WSL2 no Windows).

### 1. Configuração Inicial (Apenas na primeira vez)

Estes passos preparam o diretório do banco de dados e configuram o usuário inicial. Se o processo falhar, apague a pasta `.mariadb_data` e tente novamente.

1.  **Inicie o ambiente Nix:**
    ```bash
    nix-shell
    ```

2.  **Crie o diretório de dados:**
    ```bash
    mkdir .mariadb_data
    ```

3.  **Inicialize o banco de dados:** O caminho precisa estar entre aspas para lidar com espaços no nome do diretório.
    ```bash
    mariadb-install-db --datadir="$PWD/.mariadb_data"
    ```

4.  **Inicie o servidor temporariamente** para configurar o usuário. Execute em segundo plano:
    ```bash
    mariadbd-safe --datadir="$PWD/.mariadb_data" --socket="/tmp/mysql.sock" --pid-file="$PWD/.mariadb_data/mysql.pid" &
    ```

5.  **Aguarde 5 segundos e defina a senha** para o seu usuário. A senha será `password`.
    ```bash
    sleep 5 && mysql --socket="/tmp/mysql.sock" -u henrique -e "ALTER USER CURRENT_USER() IDENTIFIED BY 'password';"
    ```

6.  **Pare o servidor temporário:**
    ```bash
    kill $(cat "$PWD/.mariadb_data/mysql.pid")
    ```

7.  Agora você pode sair do `nix-shell` com o comando `exit`.

### 2. Iniciando e Populando o Banco de Dados

Execute estes passos sempre que quiser iniciar o servidor e carregar os dados.

1.  **Inicie o ambiente Nix:**
    ```bash
    nix-shell
    ```

2.  **Inicie o servidor MariaDB** em segundo plano:
    ```bash
    mariadbd-safe --datadir="$PWD/.mariadb_data" --socket="/tmp/mysql.sock" --pid-file="$PWD/.mariadb_data/mysql.pid" &
    ```

3.  **Aguarde 5 segundos e execute o script SQL.** O script irá apagar o banco de dados `ecommerce` (se existir), recriá-lo e popular todas as tabelas.
    ```bash
    sleep 5 && mysql -u henrique -p'password' < "Ecommerce - Scripts.sql"
    ```

### 3. Conexão via Cliente SQL (DBeaver)

Após iniciar o servidor (passo 2), você pode se conectar com as seguintes credenciais:

-   **Tipo de Conexão:** `MariaDB` ou `MySQL`
-   **Host:** `localhost`
-   **Porta:** `3306`
-   **Banco de Dados:** `ecommerce`
-   **Usuário:** `henrique`
-   **Senha:** `password`

**Importante:** Não use nenhuma configuração especial de soquete (socket) ou edite a URL JDBC no DBeaver. A conexão é via TCP/IP padrão, que funcionará após o download dos drivers corretos no DBeaver.

## Otimizações e Refinamentos Aplicados

Com base no script inicial, foram aplicadas diversas melhorias para aumentar a robustez, consistência e eficiência do banco de dados, alinhando-o com as melhores práticas de engenharia de software.

### 1. Consistência e Clareza do Schema

*   **Precisão de Tipos de Dados:** O tipo `FLOAT` foi substituído por `DECIMAL` para colunas que armazenam valores monetários (`sendValue`, `limitAvailable`) e avaliações (`rating`). Isso evita problemas de arredondamento e garante a precisão financeira e de métricas.
*   **Flexibilidade de Colunas:** Os tamanhos de colunas `VARCHAR` como `Pname` e `Address` foram aumentados para acomodar dados mais realistas e evitar truncamento de informações.
*   **Consistência de Nomenclatura:** A chave estrangeira `idOrderClient` na tabela `orders` foi renomeada para `idClient`, padronizando o nome com a coluna que ela referencia na tabela `client`.

### 2. Validação e Integridade dos Dados

*   **Validação de Documentos:** O tamanho da coluna `CNPJ` foi corrigido de `CHAR(15)` para `CHAR(14)`, que é o padrão correto no Brasil.
*   **Regras de Negócio com `CHECK`:** Foi adicionada uma restrição (`CONSTRAINT CHECK`) na tabela `seller` para garantir que um vendedor seja obrigatoriamente cadastrado com um CPF ou um CNPJ, reforçando a integridade dos dados.

### 3. Otimização de Consultas (Queries)

*   **Consulta de Pedidos por Cliente:** A consulta foi aprimorada utilizando `LEFT JOIN` em vez de `JOIN`. Isso garante que todos os clientes sejam listados no resultado, mesmo aqueles que ainda não realizaram nenhum pedido, fornecendo uma visão mais completa.
*   **Consulta de Vendedor/Fornecedor:** A lógica para identificar se um vendedor também é um fornecedor foi tornada mais robusta. A junção agora compara apenas os campos `CNPJ`, que é um identificador único e confiável para pessoas jurídicas, em vez de uma frágil comparação entre CPF e telefone de contato.

## Queries e Análise de Dados

O script SQL contém uma seção dedicada a consultas que respondem a perguntas de negócio importantes, tais como:

*   Quantos pedidos foram feitos por cada cliente?
*   Quais vendedores também atuam como fornecedores?
*   Qual a relação entre produtos, fornecedores e estoques?
*   Qual a quantidade total de cada produto em estoque?

Essas queries demonstram o uso de cláusulas SQL avançadas como `JOIN`, `GROUP BY`, `HAVING` e `ORDER BY` para realizar análises complexas.

## Melhorias Propostas

Apesar de funcional, o esquema atual pode ser aprimorado com as seguintes sugestões:

1.  **Performance (Índices):** Adicionar índices em todas as colunas de Chave Estrangeira (FK) para acelerar drasticamente as consultas que utilizam `JOIN`.
    *   **Exemplo:** `CREATE INDEX idx_orders_client ON orders(idClient);`

2.  **Normalização do Endereço:** A coluna `Address` na tabela `client` poderia ser dividida em colunas estruturadas (`rua`, `cidade`, `estado`, `cep`), facilitando consultas e a padronização dos dados.

3.  **Consistência de Dados:** O campo `size` na tabela `product` poderia ser convertido para um `ENUM` para garantir que apenas valores padronizados ('Pequeno', 'Médio', 'Grande') sejam inseridos.

4.  **Clareza na Lógica de Negócio:**
    *   O campo `paymentCash` na tabela `orders` é potencialmente redundante, dado que a tabela `payment` já especifica o método de pagamento. Sua remoção poderia simplificar o esquema.
    *   A descrição do pedido na `Stored Procedure` poderia ser mais informativa, utilizando o nome do produto (`Pname`) em vez do seu ID.
