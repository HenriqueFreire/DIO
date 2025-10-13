# Arquitetura do Projeto Micro-Services-E-commerce

Este documento descreve a arquitetura do projeto de e-commerce baseado em microsserviços, com foco na integração de serviços AWS para relatórios e logs.

## Descrição da Arquitetura:

Esta arquitetura representa uma aplicação de e-commerce baseada em microsserviços, com os seguintes componentes principais:

*   **Serviços Core:**
    *   **StoreFront Service:** Responsável pelas interações com o cliente, listagem de produtos e funcionalidades do carrinho de compras.
    *   **WareHouse Service:** Gerencia o inventário de produtos, níveis de estoque e informações detalhadas dos produtos.
*   **Armazenamento de Dados:**
    *   **PostgreSQL DB:** Um banco de dados relacional utilizado pelos serviços StoreFront e WareHouse para armazenamento persistente de dados.
*   **Mensageria:**
    *   **RabbitMQ:** Um message broker que facilita a comunicação assíncrona entre os serviços.
*   **Integração AWS (Relatórios/Logs):**
    *   **AWS S3 (Reports/Logs):** Um bucket S3 utilizado para armazenar relatórios gerados pelo serviço WareHouse e, potencialmente, para logs.
    *   **AWS Lambda (Report Processor):** Uma função Lambda acionada por eventos do S3 (por exemplo, upload de um novo relatório) para processar esses relatórios.

## Link do Projeto Original:

[Micro-Services-E-commerce no GitHub](https://github.com/HenriqueFreire/DIO/tree/main/Bootcamps/Riachuelo%20-%20Primeiros%20Passos%20com%20Java/Micro-Services-E-commerce)
