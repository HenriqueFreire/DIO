# Assistente Virtual em Python

Este projeto é um assistente virtual simples criado em Python, capaz de entender comandos de voz para realizar tarefas como pesquisas na web, contar piadas e informar as horas.

## Estrutura do Projeto

O código é organizado em módulos para facilitar a manutenção e a legibilidade:

- `main.py`: O ponto de entrada da aplicação. Ele contém o loop principal que ouve os comandos e aciona as ações correspondentes.
- `speech.py`: Contém as funções relacionadas à fala, incluindo a conversão de texto para áudio (`speak`) e a captura de áudio do microfone para texto (`get_audio`).
- `commands.py`: Define as ações que o assistente pode executar, como `search_youtube`, `search_wikipedia`, `get_joke`, etc.
- `virtual_assistant_colab.ipynb`: Um notebook Jupyter com a versão do projeto adaptada para ser executada no ambiente do Google Colab.

## Comandos de Voz Disponíveis

O assistente responde aos seguintes comandos:

- **"Youtube"**: Pede um termo e abre uma pesquisa no YouTube.
- **"Pesquisar"**: Pede um termo e busca um resumo na Wikipedia.
- **"Piada"**: Conta uma piada.
- **"Que horas são"**: Informa a hora atual.
- **"Farmácia"**: Abre o Google Maps com as farmácias mais próximas.
- **"Sair"**: Encerra o assistente.

## Como Executar o Projeto

Existem três maneiras de configurar e executar este projeto:

### 1. Usando o Ambiente Nix (Recomendado para usuários de NixOS/Nix)

O projeto inclui um arquivo `shell.nix` que define um ambiente de desenvolvimento com todas as dependências necessárias.

1.  **Carregue o ambiente:**
    ```bash
    nix-shell
    ```
2.  **Execute o assistente:**
    ```bash
    python main.py
    ```

### 2. Usando um Ambiente Python Padrão

Você pode usar um ambiente virtual Python e instalar as dependências a partir do arquivo `requirements.txt`.

1.  **Crie e ative um ambiente virtual:**
    ```bash
    python -m venv .venv
    source .venv/bin/activate
    ```
2.  **Instale as dependências:**
    ```bash
    pip install -r requirements.txt
    ```
3.  **Execute o assistente:**
    ```bash
    python main.py
    ```

### 3. Usando o Google Colab

Para quem prefere um ambiente na nuvem sem a necessidade de instalações locais.

1.  Faça o upload do arquivo `virtual_assistant_colab.ipynb` para o seu Google Drive.
2.  Abra o notebook no Google Colab.
3.  Execute as células na ordem em que aparecem. A primeira célula instalará as dependências, e as células seguintes executarão o assistente.

