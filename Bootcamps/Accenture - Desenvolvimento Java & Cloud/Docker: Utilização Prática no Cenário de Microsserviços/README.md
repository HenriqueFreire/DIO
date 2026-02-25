# E-commerce Microservices Migration & C++20 Upgrade

Este projeto demonstra a decomposição de um backend monolítico em três microserviços utilizando C++20, o framework Drogon, Nix para builds reproduzíveis e Terraform para infraestrutura como código.

## 🚀 Arquitetura e Mudanças

### 1. Reestruturação em Microserviços
O backend foi dividido em três serviços distintos:
- **User Service**: Responsável por login, registro e perfis (`/api/v1/users/`).
- **Product Service**: Gerenciamento de catálogo e estoque (`/api/v1/products/`).
- **Order Service**: Processamento de pedidos e carrinho (`/api/v1/orders/`).

### 2. Modern C++ (C++20)
- Build configurado com `set(CMAKE_CXX_STANDARD 20)`.
- Uso do operador "spaceship" (`<=>`) nos modelos de dados.
- Ambiente Docker baseado em `debian:bullseye-slim` para suporte ao GCC 10+.

### 3. Infraestrutura e Roteamento
- **Nginx**: Atua como proxy reverso roteando as requisições para os serviços corretos.
- **Docker Compose**: Orquestra os serviços, o banco de dados PostgreSQL e o Nginx.
- **Nix Flakes**: Gerenciamento unificado de dependências e builds herméticos.
- **Terraform**: Localizado em `ops/infra/` para gerenciamento programático da infraestrutura.

## 📡 Endpoints dos Serviços

| Serviço | Health Check | Exemplo de Endpoint | DB Conectado |
| :--- | :--- | :--- | :--- |
| **User** | `/api/v1/users/health` | `/api/v1/users/login` | Sim |
| **Product** | `/api/v1/products/health` | `/api/v1/products/products` | Sim |
| **Order** | `/api/v1/orders/health` | `/api/v1/orders/my-orders` | Sim |

## 🛡️ Pipeline de CI/CD Seguro

O projeto utiliza um pipeline baseado em **Nix** que garante a segurança do código antes da geração das imagens:

1.  **Análise Estática**: Integração com `cppcheck` no processo de build. Erros de memória ou segurança barram a geração da imagem.
2.  **Testes Unitários**: Suite de testes com `Google Test` (Gtest) executada automaticamente via `ctest`.
3.  **Imagens Herméticas**: As imagens Docker geradas via Nix são mínimas, contendo apenas o binário e suas dependências exatas, reduzindo a superfície de ataque.

## 🛠️ Como Executar

### Via Docker Compose (Legado/Rápido)
```bash
docker-compose up --build
```

### Via Nix (Recomendado para CI)
```bash
nix build .#docker-user-service
docker load < result
```

---

*Este projeto faz parte do Bootcamp Accenture na DIO.*
