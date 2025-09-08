# Processador de Imagens em Python

Este projeto consiste em um conjunto de scripts Python que demonstram a manipulação de imagens (conversão para escala de cinza e binarização) sem o uso de bibliotecas de processamento de imagem na lógica principal. Um script orquestrador utiliza a biblioteca Pillow para facilitar a conversão de e para formatos de imagem populares como PNG e JPG.

## Funcionalidades

- **Conversão para Escala de Cinza**: Gera uma versão da imagem em tons de cinza.
- **Conversão para Binarizado**: Gera uma versão da imagem em preto e branco absoluto, com base em um limiar.
- **Lógica Pura**: O processamento central (cinza/binarizado) é feito em Python puro, manipulando os pixels diretamente.
- **Fluxo Automatizado**: Um script principal (`orchestrator.py`) gerencia todo o processo de conversão e limpeza de arquivos temporários.
- **Ambiente Reproduzível**: Utiliza um arquivo `shell.nix` para definir um ambiente de desenvolvimento consistente com todas as dependências necessárias.

## Pré-requisitos

- **Nix**: O [gerenciador de pacotes Nix](https://nixos.org/) deve estar instalado no seu sistema.
- **Uma imagem**: Qualquer arquivo de imagem em um formato comum (PNG, JPG, etc.).

## Instalação e Configuração

O ambiente de desenvolvimento é gerenciado pelo Nix. Para ativá-lo, basta navegar até o diretório do projeto e executar:

```bash
nix-shell
```

Ao entrar no shell pela primeira vez, o `shellHook` definido no arquivo `shell.nix` irá automaticamente:
1. Criar um ambiente virtual Python no diretório `.venv` (se não existir).
2. Ativar o ambiente virtual.
3. Instalar as dependências listadas no `requirements.txt` (a biblioteca `Pillow`).

O seu terminal estará pronto para executar os scripts.

## Como Usar

Para processar uma imagem, utilize o script `orchestrator.py` passando o caminho da sua imagem como argumento.

**Exemplo:**

```bash
python orchestrator.py images/minha_foto.png
```

Após a execução, dois novos arquivos serão criados no diretório `images`:
- `minha_foto_gray.png` (a versão em escala de cinza)
- `minha_foto_binarized.png` (a versão binarizada)

## Estrutura do Projeto

```
.
├── image_processor.py    # Script com a lógica de processamento de imagem em Python puro.
├── orchestrator.py       # Script principal que gerencia o fluxo de trabalho.
├── README.md             # Este arquivo.
├── requirements.txt      # Lista de dependências Python (Pillow).
└── shell.nix             # Definição do ambiente de desenvolvimento Nix.
```
