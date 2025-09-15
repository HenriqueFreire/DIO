# Criando um Sistema de Reconhecimento Facial do Zero

O objetivo principal deste projeto é demonstrar a criação de um sistema de detecção e reconhecimento facial. Embora a proposta original mencione TensorFlow, esta implementação foca em uma solução prática e local utilizando a biblioteca **OpenCV** em Python, com gerenciamento de ambiente via **Nix**.

O sistema é capaz de:
*   **Detectar faces** em imagens e fluxos de vídeo.
*   **Reconhecer faces** de pessoas específicas após um treinamento com suas imagens.

## Tecnologias Utilizadas

*   **Python:** Linguagem de programação principal.
*   **OpenCV:** Biblioteca para visão computacional, utilizada para:
    *   **Detecção Facial:** Usando classificadores **Haar Cascades**.
    *   **Reconhecimento Facial:** Usando o algoritmo **LBPH (Local Binary Patterns Histograms)**.
*   **Nix:** Gerenciador de pacotes e ambientes, garantindo um ambiente de desenvolvimento consistente.
*   **Pillow:** Biblioteca para processamento de imagens.

## Configuração do Ambiente (Nix)

Para configurar o ambiente de desenvolvimento, navegue até o diretório raiz do projeto e execute:

```bash
nix-shell
```

O arquivo `shell.nix` configurará automaticamente o Python com as bibliotecas necessárias (OpenCV com suporte a GTK, numpy, pillow) e outras ferramentas como `imagemagick`.

## Estrutura do Projeto

*   `data/`: Contém as subpastas (`person_1/`, `person_2/`, etc.) com as imagens de treino para cada pessoa.
*   `output/`: Diretório para salvar o modelo treinado (`trainer.yml`) e as imagens com reconhecimento.
*   `test_images/`: Contém imagens para testar o sistema de reconhecimento.
*   `detector.py`: Script básico para detecção facial via webcam.
*   `trainer.py`: Script para treinar o modelo de reconhecimento facial.
*   `recognizer_image.py`: Script para realizar o reconhecimento facial em imagens estáticas.

## Fluxo de Trabalho

### 1. Preparação dos Dados de Treino

Crie subpastas dentro de `data/` para cada pessoa que você deseja reconhecer. O nome da pasta deve seguir o padrão `person_X`, onde `X` é um número inteiro (ex: `person_1`, `person_2`). Coloque várias imagens de cada pessoa em sua respectiva pasta.

Exemplo:
```
data/
├───person_1/
│   ├───1.jpg
│   ├───2.jpg
│   └───...
└───person_2/
    ├───1.jpg
    ├───2.jpg
    └───...
```

### 2. Treinamento do Modelo de Reconhecimento

Após preencher as pastas `data/`, execute o script de treinamento. Ele irá processar as imagens, extrair as faces e treinar o modelo LBPH.

```bash
python trainer.py
```

O modelo treinado será salvo em `output/trainer.yml`.

### 3. Reconhecimento Facial em Imagens

Para testar o modelo treinado em imagens estáticas, use o script `recognizer_image.py`. Ele processará todas as imagens na pasta `test_images/` e salvará os resultados na pasta `output/`.

```bash
python recognizer_image.py
```

As imagens resultantes terão os rostos detectados e os nomes reconhecidos desenhados sobre eles.

### 4. Detecção Facial Básica (Webcam)

Para uma demonstração simples de detecção facial em tempo real (sem reconhecimento), você pode usar o script `detector.py`:

```bash
python detector.py
```

Pressione 'q' para sair da webcam.

## Conceitos Chave

*   **Detecção Facial:** O processo de identificar a presença e a localização de rostos humanos em uma imagem. Utiliza **Haar Cascades** para encontrar padrões característicos de rostos.
*   **Reconhecimento Facial:** O processo de identificar uma pessoa específica a partir de um rosto detectado. Utiliza o algoritmo **LBPH** para aprender as características únicas de cada indivíduo.