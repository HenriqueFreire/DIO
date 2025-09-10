# Desafio: Cálculo de Métricas de Avaliação de Aprendizado

Este projeto demonstra como calcular e monitorar um conjunto detalhado de métricas de avaliação para um modelo de classificação binária durante seu treinamento. As métricas são aplicadas a um modelo de *Transfer Learning* que classifica imagens de cães e gatos.

## Métricas Calculadas

Para cada época de treinamento, o script calcula e exibe as seguintes métricas com base na performance do modelo no conjunto de validação:

-   **Acurácia:** A proporção de previsões corretas.
-   **Sensibilidade (Recall):** A capacidade do modelo de identificar corretamente os casos positivos.
-   **Especificidade:** A capacidade do modelo de identificar corretamente os casos negativos.
-   **Precisão:** A proporção de previsões positivas que estavam corretas.
-   **F-score:** A média harmônica entre precisão e sensibilidade.

## Estrutura do Projeto

O projeto é composto pelos seguintes arquivos:

-   `metricas.py`: Um módulo contendo as funções matemáticas puras para calcular cada uma das métricas de avaliação (Acurácia, Precisão, etc.).
-   `custom_callbacks.py`: Define uma classe `MetricsCallback` que herda de `tf.keras.callbacks.Callback`. Este callback é responsável por, ao final de cada época, calcular a matriz de confusão (VP, VN, FP, FN) e usar as funções de `metricas.py` para exibir um relatório detalhado.
-   `transfer_learning.py`: O script principal que carrega o dataset `cats_vs_dogs`, constrói um modelo usando MobileNetV2 (Transfer Learning), e o treina. Ele utiliza o `MetricsCallback` para avaliar o modelo a cada época.
-   `requirements.txt`: Lista as dependências Python necessárias para o projeto (TensorFlow, etc.).
-   `shell.nix`: Arquivo de configuração para o Nix, que define um ambiente de desenvolvimento consistente com as dependências necessárias.

## Como Executar

1.  **Acessar o Ambiente Nix:**
    Abra seu terminal na raiz deste diretório e execute o comando para iniciar o ambiente definido no `shell.nix`:
    ```bash
    nix-shell
    ```

2.  **Instalar as Dependências:**
    É uma boa prática usar um ambiente virtual Python. Dentro do `nix-shell`, crie e ative o ambiente:
    ```bash
    python -m venv .venv
    source .venv/bin/activate
    ```
    Em seguida, instale as bibliotecas necessárias:
    ```bash
    pip install -r requirements.txt
    ```

3.  **Executar o Treinamento:**
    Execute o script principal de treinamento. O TensorFlow irá baixar o dataset e os pesos do modelo pré-treinado na primeira execução.
    ```bash
    python transfer_learning.py
    ```

## Saída Esperada

Ao executar o script, você observará:

-   O log de treinamento padrão do Keras para cada época.
-   Ao final de cada época, um **relatório detalhado** com a matriz de confusão e todas as métricas calculadas (Acurácia, Sensibilidade, Especificidade, Precisão e F-score).
-   Ao final do treinamento, a acurácia final do modelo no conjunto de teste.
-   Um arquivo de imagem chamado `training_history.png` será salvo no diretório, contendo gráficos da acurácia e da perda durante o treinamento.
