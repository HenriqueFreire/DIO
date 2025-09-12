# Projeto de Transfer Learning com Python

Este projeto demonstra a aplicação de Transfer Learning para treinar uma rede neural de Deep Learning para classificação de imagens.

## Objetivo

O objetivo é classificar imagens de duas classes distintas: cães e gatos. Para isso, utilizamos um modelo pré-treinado (MobileNetV2) e o adaptamos para a nossa tarefa específica, uma técnica conhecida como Transfer Learning.

## Dataset

O dataset utilizado é o `cats_vs_dogs`, disponibilizado pelo TensorFlow Datasets. Ele contém milhares de imagens de gatos e cachorros.

- **Descrição:** [https://www.tensorflow.org/datasets/catalog/cats_vs_dogs](https://www.tensorflow.org/datasets/catalog/cats_vs_dogs)
- **Fonte Original:** [https://www.microsoft.com/en-us/download/details.aspx?id=54765](https://www.microsoft.com/en-us/download/details.aspx?id=54765)

## Ferramentas

- Python
- TensorFlow / Keras
- TensorFlow Datasets
- Matplotlib

## Como Executar Localmente

1. Clone o repositório.
2. Instale as dependências: `pip install -r requirements.txt`
3. Execute o script de treinamento: `python transfer_learning.py`

## Suporte a TPU e Aceleração por Hardware

O notebook `transfer_learning_colab.ipynb` foi otimizado para tirar proveito de aceleradores de hardware como GPUs e TPUs, disponíveis gratuitamente no Google Colab.

- **Detecção Automática:** O notebook detecta automaticamente a presença de uma GPU ou TPU e a utiliza para acelerar o treinamento e a inferência.
- **Treinamento com TPU:** Para usar uma TPU, basta selecionar `TPU` como acelerador de hardware no ambiente de execução do Colab. O código se encarregará de distribuir o trabalho para a TPU.

## Como Executar no Google Colab

Você pode executar este projeto diretamente no Google Colab.

1.  **Acesse o Google Colab:** [https://colab.research.google.com/](https://colab.research.google.com/)
2.  **Carregue o Notebook:**
    -   Vá em `File > Upload notebook`.
    -   Selecione o arquivo `transfer_learning_colab.ipynb` deste projeto.
3.  **Ative o Acelerador de Hardware (TPU):**
    -   No menu, vá em `Runtime > Change runtime type`.
    -   Selecione `TPU` como `Hardware accelerator` e clique em `Save`.
4.  **Execute as Células:** Execute as células do notebook em ordem para treinar e avaliar o modelo.

## Escolhendo Outro Modelo

Este projeto utiliza o `MobileNetV2` como modelo base, que é uma excelente escolha para um equilíbrio entre performance e eficiência. No entanto, você pode facilmente trocá-lo por outros modelos pré-treinados disponíveis no Keras, como o `VGG16`, `ResNet`, `InceptionV3`, etc.

### Por que trocar de modelo?

*   **Performance:** Modelos maiores como o `VGG16` ou `ResNet` podem oferecer uma acurácia ligeiramente superior, ao custo de um treinamento mais lento e um modelo final maior.
*   **Eficiência:** Modelos como o `MobileNetV2` são ideais para aplicações em tempo real ou em dispositivos com recursos limitados.

### Como trocar o modelo no código

1.  **Importe o novo modelo:**
    Adicione la linha de importação para o modelo desejado no início do arquivo `transfer_learning.py`. Por exemplo, para usar o `VGG16`:

    ```python
    from tensorflow.keras.applications import VGG16
    ```

2.  **Altere a instanciação do modelo base:**
    Na seção `# 2. Criar o Modelo com Transfer Learning`, substitua a linha que carrega o `MobileNetV2` pela do novo modelo:

    ```python
    # Exemplo para VGG16
    base_model = VGG16(input_shape=IMG_SHAPE,
                       include_top=False,
                       weights='imagenet')
    ```

3.  **Ajuste a função de pré-processamento (se necessário):**
    Cada modelo pré-treinado espera que as imagens de entrada sejam normalizadas de uma maneira específica. O `MobileNetV2` espera valores de pixel no intervalo `[-1, 1]`. Outros modelos, como o `VGG16`, podem esperar um pré-processamento diferente (por exemplo, a subtração da média de pixels do ImageNet).

    Para o `VGG16`, você precisará importar e usar a função `preprocess_input` específica do VGG16. A função `format_example` ficaria assim:

    ```python
    from tensorflow.keras.applications.vgg16 import preprocess_input

    def format_example(image, label):
        image = tf.cast(image, tf.float32)
        image = tf.image.resize(image, (IMG_SIZE, IMG_SIZE))
        image = preprocess_input(image) # Usa a função específica do VGG16
        return image, label
    ```

Lembre-se de que, ao trocar de modelo, pode ser necessário ajustar outros hiperparâmetros, como a `learning_rate`, para obter os melhores resultados.