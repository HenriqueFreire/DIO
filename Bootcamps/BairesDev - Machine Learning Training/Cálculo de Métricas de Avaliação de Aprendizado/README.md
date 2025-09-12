# Desafio: Cálculo de Métricas de Avaliação de Aprendizado

Este projeto demonstra como calcular e monitorar um conjunto detalhado de métricas de avaliação para um modelo de classificação binária. As métricas são aplicadas a um modelo de *Transfer Learning* que classifica imagens de cães e gatos.

O projeto está disponível em duas versões:
1.  **Scripts Python:** Uma coleção de scripts Python (`.py`) para execução em um ambiente local, utilizando CPU.
2.  **Jupyter Notebook:** Um notebook (`.ipynb`) otimizado para execução em ambientes como o Google Colab, com suporte para **CPU, GPU e TPU**.

## Métricas Calculadas

Para cada época de treinamento, são calculadas e exibidas as seguintes métricas com base na performance do modelo no conjunto de validação:

-   **Acurácia:** A proporção de previsões corretas.
-   **Sensibilidade (Recall):** A capacidade do modelo de identificar corretamente os casos positivos.
-   **Especificidade:** A capacidade do modelo de identificar corretamente os casos negativos.
-   **Precisão:** A proporção de previsões positivas que estavam corretas.
-   **F-score:** A média harmônica entre precisão e sensibilidade.

## Estrutura do Projeto

-   `analise_de_metricas.ipynb`: Notebook Jupyter contendo todo o código, ideal para execução no Google Colab.
-   `metricas.py`: Módulo com as funções para calcular as métricas de avaliação.
-   `custom_callbacks.py`: Define o Callback do Keras para calcular e exibir as métricas a cada época.
-   `transfer_learning.py`: Script principal para o treinamento do modelo (versão local).
-   `requirements.txt`: Lista as dependências Python.
-   `shell.nix`: Arquivo de configuração para o ambiente de desenvolvimento Nix.

## Suporte a TPU

O notebook `analise_de_metricas.ipynb` já vem com o código necessário para detectar e utilizar TPUs (Tensor Processing Units) automaticamente. Ao executar no Google Colab com o ambiente de execução configurado para TPU, o script irá:
1. Detectar a presença de uma TPU.
2. Inicializar o sistema de TPU.
3. Criar uma `tf.distribute.TPUStrategy` para distribuir o treinamento entre os núcleos da TPU.

Isso acelera significativamente o processo de treinamento do modelo.

## Executando no Google Colab (Recomendado)

A maneira mais simples de executar o projeto é usando o notebook no Google Colab, que oferece acesso gratuito a aceleradores de hardware.

1.  **Acesse o Google Colab:** [https://colab.research.google.com/](https://colab.research.google.com/)
2.  **Carregue o Notebook:**
    -   Vá em `File > Upload notebook`.
    -   Selecione o arquivo `analise_de_metricas.ipynb` deste projeto.
3.  **Ative o Acelerador de Hardware (TPU):**
    -   No menu, vá em `Runtime > Change runtime type`.
    -   Selecione `TPU` como `Hardware accelerator` e clique em `Save`. O código se adaptará automaticamente.
4.  **Execute o Código:**
    -   Execute as células do notebook em ordem. A primeira célula de código instalará as dependências e a segunda configurará a estratégia de treinamento para o hardware selecionado.

## Executando Localmente (com Nix)

Esta opção é para usuários familiarizados com o ambiente Nix.

1.  **Acessar o Ambiente Nix:**
    ```bash
    nix-shell
    ```
2.  **Instalar as Dependências:**
    Dentro do `nix-shell`, crie e ative um ambiente virtual Python:
    ```bash
    python -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
    ```
3.  **Executar o Treinamento:**
    ```bash
    python transfer_learning.py
    ```

## Saída Esperada

Ao final de cada época de treinamento, você verá um relatório detalhado com a matriz de confusão e todas as métricas calculadas. Ao final, será exibida a acurácia do modelo no conjunto de teste e um gráfico com o histórico de treinamento.
