# Sistema de Recomendação por Imagens

Este projeto implementa um sistema de recomendação de produtos baseado em similaridade visual. Utilizando Deep Learning com Keras/TensorFlow, o modelo aprende a extrair características visuais de imagens e as utiliza para recomendar itens com aparência semelhante.

## Como Usar

Existem duas formas de executar este projeto: localmente com Nix ou online com Google Colab.

### 1. Execução com Google Colab (Recomendado)

A maneira mais fácil de testar o projeto é através do Google Colab. O notebook já está configurado para forçar a execução em CPU, garantindo a consistência dos resultados.

1.  Faça o upload do arquivo `recomendacao_de_imagens.ipynb` para o seu Google Drive.
2.  Abra o notebook no Google Colab.
3.  Execute as células em ordem, de cima para baixo. O notebook cuidará da instalação de dependências, download de dados e execução do processo.

### 2. Execução Local (Avançado)

Esta abordagem requer que você tenha o [Nix](https://nixos.org/) instalado em um sistema Linux ou macOS.

1.  **Setup do Ambiente:**
    Abra seu terminal na raiz do projeto e execute:
    ```bash
    nix-shell
    ```
    Este comando irá baixar e configurar todas as dependências de sistema e Python necessárias, criando um ambiente de desenvolvimento reprodutível.

2.  **Executar a Recomendação:**
    Uma vez dentro do `nix-shell`, execute o script principal:
    ```bash
    python src/main.py
    ```
    O script irá automaticamente treinar o modelo (se não existir), extrair as features das imagens e, por fim, imprimir uma imagem de consulta aleatória e suas 5 recomendações mais similares.

## Estrutura do Projeto

-   `/data`: Diretório para armazenar as imagens do dataset (gerenciado pelos scripts).
-   `/src`: Código-fonte principal do sistema.
    -   `main.py`: Ponto de entrada que orquestra o treinamento e a recomendação.
    -   `train.py`: Script para treinar o modelo de classificação.
    -   `feature_extractor.py`: Classe para extrair vetores de features das imagens.
    -   `recommender.py`: Classe que calcula e retorna as recomendações.
-   `recomendacao_de_imagens.ipynb`: Notebook Jupyter para execução fácil no Google Colab.
-   `shell.nix`: Definição do ambiente de desenvolvimento com Nix.
-   `requirements.txt`: Lista de dependências Python (usada pelo Colab).
