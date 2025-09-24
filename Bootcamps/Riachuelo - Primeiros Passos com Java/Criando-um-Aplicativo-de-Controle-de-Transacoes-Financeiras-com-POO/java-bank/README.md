# DIO Bank - Aplicativo de Controle de Transações Financeiras

## Descrição do Projeto

Este é um aplicativo de linha de comando para controle de transações financeiras, desenvolvido como parte do bootcamp "Primeiros Passos com Java" da DIO. Ele permite aos usuários gerenciar contas bancárias, realizar depósitos, saques, transferências e gerenciar investimentos. O projeto foi estruturado para demonstrar conceitos de Programação Orientada a Objetos (POO) e manipulação de exceções em Java.

Funcionalidades principais:
- Criação de contas bancárias com chaves PIX.
- Realização de depósitos e saques.
- Transferências entre contas.
- Criação e gestão de investimentos.
- Histórico de transações.

## Como Utilizar

Para utilizar este aplicativo, siga os passos abaixo:

### Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas em seu sistema:
- **JDK (Java Development Kit) 21 ou superior:** Para compilar e executar o código Java.
- **Gradle:** Para gerenciar as dependências e o processo de build do projeto.

### Compilação e Execução

1.  **Navegue até o diretório do projeto:**
    Abra seu terminal e navegue até a pasta `java-bank` dentro do diretório principal do projeto.
    ```bash
    cd /caminho/para/seu/projeto/java-bank
    ```
    (Substitua `/caminho/para/seu/projeto` pelo caminho real onde você clonou ou baixou o projeto.)

2.  **Compile o projeto:**
    Utilize o Gradle para compilar o projeto e gerar o arquivo JAR executável.
    ```bash
    ./gradlew build
    ```
    Este comando irá baixar as dependências, compilar o código e criar o JAR em `build/libs/java-bank-1.0-SNAPSHOT.jar`.

3.  **Execute a aplicação:**
    Após a compilação, você pode executar a aplicação diretamente usando o comando `java -jar`:
    ```bash
    java -jar build/libs/java-bank-1.0-SNAPSHOT.jar
    ```
    A aplicação será iniciada e apresentará um menu de opções no terminal.

### Interagindo com a Aplicação

A aplicação é interativa e funciona através de um menu de opções. Digite o número correspondente à operação desejada e pressione Enter. Siga as instruções na tela para fornecer os dados necessários para cada operação (chaves PIX, valores, etc.).

## Tecnologias Utilizadas

-   **Java 21:** Linguagem de programação principal.
-   **Gradle (Kotlin DSL):** Ferramenta de automação de build e gerenciamento de dependências.
-   **Lombok:** Biblioteca para reduzir o código boilerplate em classes Java (geração automática de getters, setters, construtores, etc.).
-   **JUnit 5:** Framework de testes para garantir a qualidade do código.
-   **Nix-shell:** Ambiente de desenvolvimento isolado e reprodutível.
-   **Programação Orientada a Objetos (POO):** Princípios de design e implementação aplicados na estrutura do projeto.
-   **Manipulação de Exceções:** Tratamento de erros e situações inesperadas de forma robusta.
