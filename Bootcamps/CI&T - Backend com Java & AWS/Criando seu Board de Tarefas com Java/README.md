# Board de Tarefas com Java (CLI)

Este é um aplicativo de linha de comando (CLI) desenvolvido em Java para gerenciar um quadro de tarefas simples. Ele permite criar boards, adicionar e mover cartões, além de bloquear e desbloquear tarefas. O projeto foi refatorado para utilizar o JDBI como camada de persistência e implementar melhores práticas de desenvolvimento, como externalização de credenciais e tratamento de erros centralizado.

## Funcionalidades

*   Criação e exclusão de quadros (boards).
*   Criação de cartões (cards) em um quadro.
*   Movimentação de cartões entre colunas.
*   Bloqueio e desbloqueio de cartões com motivo.
*   Cancelamento de cartões.
*   Visualização de detalhes do quadro, colunas e cartões.

## Tecnologias Utilizadas

*   **Java 17+**
*   **Gradle (com Kotlin DSL)**: Sistema de automação de build.
*   **JDBI 3**: Biblioteca de abstração JDBC leve para acesso ao banco de dados.
*   **Lombok**: Para reduzir boilerplate de código (getters, setters, construtores).
*   **Liquibase**: Para gerenciamento de migrações de esquema de banco de dados.
*   **MySQL**: Banco de dados relacional.
*   **H2 Database**: Banco de dados em memória utilizado para testes unitários.
*   **JUnit 5**: Framework de testes unitários.
*   **Nix / NixOS**: Ambiente de desenvolvimento declarado (`shell.nix`).

## Configuração do Ambiente de Desenvolvimento (NixOS)

Para configurar o ambiente de desenvolvimento usando NixOS, entre no `nix-shell` no diretório raiz do projeto:

```bash
nix-shell
```

Isso instalará automaticamente o JDK e o Gradle necessários, conforme definido no `shell.nix`.

## Configuração do Banco de Dados

O projeto utiliza **MySQL** para persistência em produção/desenvolvimento e **H2 Database** em memória para testes unitários.

### Migrações do Banco de Dados (MySQL)

As migrações do banco de dados são gerenciadas pelo Liquibase. O aplicativo executará as migrações automaticamente ao iniciar. Certifique-se de que seu servidor MySQL esteja em execução e que um banco de dados com as credenciais configuradas esteja acessível.

**Cuidado:** Os scripts de migração (`.sql`) foram adaptados para serem compatíveis tanto com MySQL quanto com H2, removendo a cláusula `ENGINE=InnoDB;` específica do MySQL.

### Credenciais do Banco de Dados

As credenciais do banco de dados são lidas a partir de variáveis de ambiente. Para executar a aplicação conectando-se ao MySQL, você deve definir as seguintes variáveis de ambiente:

*   `DB_URL`: URL de conexão JDBC para o MySQL (ex: `jdbc:mysql://localhost:3306/board`).
*   `DB_USER`: Nome de usuário do banco de dados.
*   `DB_PASSWORD`: Senha do banco de dados.

**Exemplo (antes de iniciar a aplicação):**

```bash
export DB_URL="jdbc:mysql://localhost:3306/board"
export DB_USER="your_mysql_user"
export DB_PASSWORD="your_mysql_password"
```

**Valores Padrão:** Se as variáveis de ambiente não forem definidas, o `ConnectionConfig` usará os seguintes valores padrão para desenvolvimento local:
*   `DB_URL`: `jdbc:mysql://localhost/board`
*   `DB_USER`: `board`
*   `DB_PASSWORD`: `board`

## Como Compilar e Executar

1.  **Entre no ambiente Nix:**
    ```bash
    nix-shell
    ```
2.  **Compile o projeto:**
    ```bash
    gradle build
    ```
3.  **Execute a aplicação (após configurar as variáveis de ambiente, se necessário):**
    ```bash
    gradle run
    ```

## Como Rodar os Testes

1.  **Entre no ambiente Nix:**
    ```bash
    nix-shell
    ```
2.  **Execute os testes:**
    ```bash
    gradle test
    ```

Os testes unitários utilizam um banco de dados H2 em memória e criam o esquema necessário diretamente, sem depender do Liquibase para essa etapa.

## Estrutura do Projeto

*   `src/main/java/br/com/dio/`: Pacote raiz do código-fonte.
    *   `dto/`: Objetos de Transferência de Dados (DTOs).
    *   `exception/`: Classes de exceção customizadas.
    *   `persistence/`: Camada de persistência.
        *   `config/`: `ConnectionConfig` para configuração do JDBI.
        *   `converter/`: Conversores de tipo (ex: `OffsetDateTimeConverter`).
        *   `dao/`: Interfaces DAO baseadas em JDBI `SqlObject`.
        *   `entity/`: Entidades de domínio mapeadas para o banco de dados.
        *   `migration/`: `MigrationStrategy` para execução do Liquibase.
    *   `service/`: Camada de serviços com a lógica de negócios.
    *   `ui/`: Interface de usuário de linha de comando (`MainMenu`, `BoardMenu`).
*   `src/main/resources/`: Recursos da aplicação.
    *   `db/changelog/`: Scripts de migração do Liquibase.
*   `build.gradle.kts`: Arquivo de build do Gradle.
*   `shell.nix`: Definição do ambiente de desenvolvimento Nix.

## Boas Práticas e Otimizações Implementadas

*   **Abstração de Persistência (JDBI):** Substituição do JDBC puro por JDBI, reduzindo boilerplate e melhorando a segurança transacional.
*   **Externalização de Credenciais:** Movido o gerenciamento de credenciais do banco de dados para variáveis de ambiente, aumentando a segurança e flexibilidade.
*   **Tratamento de Erros Centralizado:** Implementação de um mecanismo de tratamento de exceções nos pontos de entrada da UI (menus), garantindo uma experiência mais robusta para o usuário.
*   **Testes Unitários:** Adição de testes unitários para a camada de serviço (`BoardService`), garantindo a estabilidade e corrigindo bugs de forma antecipada.
*   **Ambiente de Desenvolvimento Declarativo (Nix):** Uso de `shell.nix` para garantir um ambiente de desenvolvimento consistente e reproduzível.
