# Microsserviços de E-commerce

Este projeto implementa uma arquitetura de microsserviços para uma aplicação de e-commerce de exemplo, consistindo em um serviço de `StoreFront` (vitrine) e um de `WareHouse` (almoxarifado).

O projeto é construído e empacotado utilizando Nix para garantir um ambiente de desenvolvimento e build totalmente reproduzível.

## Tecnologias Utilizadas

- **Backend:** Java 21, Spring Boot 3.3
- **Build:** Gradle 8.14
- **Ambiente e Empacotamento:** Nix, Docker
- **Banco de Dados:** PostgreSQL
- **Mensageria:** RabbitMQ (implícito pela configuração AMQP)

## Arquitetura

O projeto é dividido em dois microsserviços principais:

- **`StoreFront`**: Responsável pela interface com o cliente, listagem de produtos e interação com o carrinho de compras.
- **`WareHouse`**: Gerencia o inventário de produtos, incluindo estoque e informações detalhadas.

## Pré-requisitos

Para construir e executar este projeto, você precisará ter os seguintes softwares instalados:

1.  **Nix:** O gerenciador de pacotes e builds. Siga o [guia de instalação oficial](https://nixos.org/download.html).
2.  **Docker:** Para executar os contêineres dos serviços. Siga o [guia de instalação oficial](https://docs.docker.com/engine/install/).

## Construindo os Serviços com Nix

Cada serviço (`StoreFront` e `WareHouse`) contém um `flake.nix` que define como construir a imagem Docker do serviço de forma isolada e reproduzível.

### 1. Construindo o `StoreFront`

Navegue até o diretório do serviço e execute o comando de build do Nix:

```bash
cd Micro-Services-E-commerce/StoreFront
nix build .#
```

Após a conclusão, um link simbólico chamado `result` será criado no diretório, apontando para a imagem Docker compactada.

### 2. Construindo o `WareHouse`

O processo é idêntico para o serviço de `WareHouse`:

```bash
cd Micro-Services-E-commerce/WareHouse
nix build .#
```

## Carregando e Executando as Imagens Docker

Depois de construir cada serviço, você precisa carregar a imagem gerada no seu daemon Docker.

### 1. Carregando as Imagens

Execute o seguinte comando no diretório de cada serviço correspondente:

**Para o StoreFront:**
```bash
# Dentro de Micro-Services-E-commerce/StoreFront
docker load < result
```

**Para o WareHouse:**
```bash
# Dentro de Micro-Services-E-commerce/WareHouse
docker load < result
```

Isso tornará as imagens `storefront:latest` e `warehouse:latest` disponíveis no seu ambiente Docker.

### 2. Executando os Contêineres

Cada serviço possui um arquivo `docker-compose.yml` pré-configurado para facilitar a execução, incluindo as dependências como o banco de dados PostgreSQL e RabbitMQ.

Para iniciar um dos serviços, navegue até o seu diretório e use o Docker Compose:

```bash
# Exemplo para o StoreFront
cd Micro-Services-E-commerce/StoreFront
docker-compose up -d
```

Faça o mesmo para o serviço `WareHouse` em seu respectivo diretório.

## Documentação da API

Cada microsserviço expõe sua documentação de API utilizando SpringDoc (OpenAPI/Swagger).

Após iniciar um serviço, você pode acessar a interface do Swagger em:

`http://localhost:8080/swagger-ui.html`

(Assumindo que o serviço está rodando na porta padrão `8080`).