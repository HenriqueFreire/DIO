# Projeto de Detecção de Objetos com YOLOv8

Este projeto consiste em treinar e utilizar um modelo de detecção de objetos YOLOv8 para identificar as classes 'carro' e 'moto' a partir do dataset COCO.

## Funcionalidades

- Treinamento de um modelo YOLOv8 com uma seleção customizada de classes.
- Detecção de objetos em imagens utilizando o modelo treinado.
- Menu interativo via linha de comando para facilitar a utilização.
- Notebook para o Google Colab para um ambiente baseado na nuvem.

## Começando

Siga estas instruções para configurar e executar o projeto localmente.

### Pré-requisitos

- Python 3.10+
- pip

### Instalação

1. Clone o repositório:
   ```sh
   git clone <URL_DO_SEU_REPOSITORIO>
   cd <NOME_DO_DIRETORIO>
   ```

2. Crie um ambiente virtual e instale as dependências:
   ```sh
   python -m venv .dev
   source .dev/bin/activate
   pip install -r requirements.txt
   ```

### Executando a Aplicação

Para iniciar o menu interativo, execute:

```sh
python src/main.py
```

## Uso

### Treinamento

1. No menu principal, selecione a opção **1. Treinar Modelo**.
2. O modelo será treinado utilizando as configurações definidas em `desafio-coco.yaml`.
3. Ao final, o caminho para os pesos do modelo treinado será exibido.

### Detecção

1. No menu principal, selecione a opção **2. Detectar Objetos em uma Imagem**.
2. Forneça o caminho para o modelo treinado (ex: `runs/detect/train/weights/best.pt`).
3. Forneça o caminho para a imagem que deseja analisar.
4. A imagem com as detecções será exibida e salva como `results.jpg`.



## Google Colab

Para uma alternativa que não requer instalação local, você pode usar o notebook do Google Colab.

1.  **Acesse o Google Colab:** [https://colab.research.google.com/](https://colab.research.google.com/)
2.  **Carregue o Notebook:**
    -   Vá em `File > Upload notebook`.
    -   Selecione o arquivo `notebooks/colab_notebook.ipynb` deste projeto.
3.  **Configurar o Ambiente de Execução:**
    -   No menu, vá em `Runtime > Change runtime type`.
    -   Selecione `None` como `Hardware accelerator` e clique em `Save`.
4.  **Execute as Células:** Siga as instruções contidas no notebook para instalar as dependências, treinar o modelo e realizar a detecção.

## Estrutura do Projeto

```
.
├── data/                     # Diretório para datasets
├── notebooks/                # Contém o notebook para o Google Colab
│   └── colab_notebook.ipynb
├── src/                      # Código fonte do projeto
│   ├── main.py               # Script principal com o menu interativo
│   ├── train.py              # Script para o treinamento do modelo
│   └── detect.py             # Script para a detecção de objetos
├── desafio-coco.yaml         # Arquivo de configuração do dataset
├── requirements.txt          # Dependências do projeto
└── yolov8n.pt                # Modelo YOLOv8 pré-treinado
```

## Versão Python (.py) vs. Versão Jupyter Notebook (.ipynb)

Este projeto oferece duas maneiras de interagir com o modelo YOLOv8, cada uma com suas próprias características:

### Versão Python (`src/`)

-   **Ambiente:** Projetado para ser executado localmente em seu próprio computador.
-   **Interação:** Utiliza um menu de linha de comando interativo (`main.py`) para guiar o usuário através do treinamento e detecção.
-   **Configuração:** Requer a configuração de um ambiente Python local com todas as dependências listadas em `requirements.txt`.
-   **Armazenamento:** Os resultados do treinamento (pesos do modelo, gráficos, etc.) são salvos permanentemente na pasta `data/training_results` dentro da estrutura do projeto.

### Versão Jupyter Notebook (`notebooks/colab_notebook.ipynb`)

-   **Ambiente:** Otimizado para o Google Colab, um ambiente de notebook baseado em nuvem.
-   **Interação:** O código é organizado em células que podem ser executadas sequencialmente. É ideal para experimentação e visualização passo a passo.
-   **Configuração:** Nenhuma instalação local é necessária. As dependências e os modelos pré-treinados são baixados e configurados automaticamente no ambiente do Colab.
-   **Armazenamento:** Os arquivos gerados (datasets, pesos, imagens de resultado) são salvos no armazenamento temporário do Colab e serão perdidos quando a sessão for encerrada. É necessário baixar os arquivos manualmente se você quiser mantê-los.
-   **Ideal para:** Testes rápidos, experimentação e para usuários que não possuem um ambiente de desenvolvimento Python configurado localmente.
