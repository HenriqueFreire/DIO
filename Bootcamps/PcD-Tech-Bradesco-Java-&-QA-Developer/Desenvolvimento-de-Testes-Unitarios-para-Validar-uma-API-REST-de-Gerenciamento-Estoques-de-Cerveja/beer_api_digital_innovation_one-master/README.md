# Beer Stock API

Uma API REST para gerenciamento de estoque de cervejas, desenvolvida com Spring Boot. Este projeto foi originalmente criado para uma aula de desenvolvimento de testes e desde então foi atualizado e aprimorado com uma suíte de testes completa (unitários, integração e E2E).

## Recursos

- Criar, listar, buscar por nome e deletar cervejas.
- Incrementar e decrementar o estoque de uma cerveja.
- Documentação da API gerada automaticamente com Swagger UI.

## Tecnologias Utilizadas

- **Backend:** Java 17, Spring Boot 2.7.17
- **Build:** Maven
- **Ambiente:** Nix
- **Banco de Dados:** H2 (em memória)
- **Utilitários:** Lombok, MapStruct
- **Testes:** JUnit 5, Mockito, Hamcrest, REST Assured
- **Documentação da API:** Springdoc-openapi

## Como Executar a Aplicação

### Pré-requisitos

- [Nix Package Manager](https://nixos.org/download.html) instalado.
- Git.

### Passos

1.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_REPOSITORIO>
    cd beer_api_digital_innovation_one-master
    ```

2.  **Inicie o ambiente de desenvolvimento:**
    Este comando irá baixar o Java 17 e o Maven, configurando o ambiente para você.
    ```bash
    nix-shell
    ```

3.  **Execute a aplicação:**
    Dentro do `nix-shell`, execute o seguinte comando:
    ```bash
    ./mvnw spring-boot:run
    ```
    A API estará disponível em `http://localhost:8080`.

## Como Executar os Testes

1.  **Inicie o ambiente de desenvolvimento:**
    ```bash
    nix-shell
    ```

2.  **Execute a suíte de testes:**
    Dentro do `nix-shell`, execute o comando:
    ```bash
    ./mvnw clean test
    ```

## Documentação da API (Swagger UI)

Com a aplicação em execução, a documentação interativa da API (gerada pelo Springdoc) pode ser acessada no seu navegador através do seguinte endereço:

[**http://localhost:8080/swagger-ui.html**](http://localhost:8080/swagger-ui.html)

## Endpoints da API

| Verbo  | Endpoint                               | Descrição                        |
|--------|----------------------------------------|----------------------------------|
| `GET`  | `/api/v1/beers`                        | Lista todas as cervejas.         |
| `POST` | `/api/v1/beers`                        | Cria uma nova cerveja.           |
| `GET`  | `/api/v1/beers/{name}`                 | Busca uma cerveja pelo nome.     |
| `DELETE`| `/api/v1/beers/{id}`                  | Deleta uma cerveja pelo ID.      |
| `PATCH`| `/api/v1/beers/{id}/increment`         | Incrementa o estoque da cerveja. |
| `PATCH`| `/api/v1/beers/{id}/decrement`         | Decrementa o estoque da cerveja. |