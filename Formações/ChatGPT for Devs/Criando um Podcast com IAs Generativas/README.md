# Criando um Podcast com IAs Generativas

Este projeto demonstra a criação de um podcast utilizando Inteligências Artificiais Generativas, como ChatGPT para geração de texto e DALL-E para geração de imagens. O ambiente de desenvolvimento é gerenciado com Nix, garantindo reprodutibilidade.

## Pré-requisitos

Para executar este projeto, você precisará ter o [Nix Package Manager](https://nixos.org/download/) instalado em seu sistema.

## Configuração do Ambiente

O ambiente de desenvolvimento é configurado usando `nix-shell`, que automaticamente cria e ativa um ambiente Python virtual e instala as dependências necessárias.

1.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    cd Criando-um-Podcast-com-IAs-Generativas
    ```
    (Substitua `<URL_DO_SEU_REPOSITORIO>` pelo link real do seu repositório.)

2.  **Entre no ambiente de desenvolvimento Nix:**
    ```bash
    nix-shell
    ```
    Ao executar este comando, o `shell.nix` fará o seguinte:
    *   Criará um ambiente virtual Python (`.venv`) se ele não existir.
    *   Ativará o ambiente virtual.
    *   Instalará ou atualizará as dependências listadas em `requirements.txt`.

3.  **Configuração de Variáveis de Ambiente:**
    Crie um arquivo `.env` na raiz do projeto para armazenar suas chaves de API e outras variáveis de ambiente sensíveis. Exemplo:
    ```
    OPENAI_API_KEY=sua_chave_api_openai
    GOOGLE_API_KEY=sua_chave_api_google
    # Outras variáveis necessárias
    ```
    Certifique-se de não commitar o arquivo `.env` para o controle de versão.

## Travando as Dependências (requirements.txt)

As dependências são travadas no `requirements.txt` com suas versões exatas para garantir a reprodutibilidade. Se você instalar novas bibliotecas ou atualizar as existentes:

1.  Certifique-se de estar dentro do `nix-shell`.
2.  Execute o comando:
    ```bash
    pip freeze > requirements.txt
    ```
    Isso irá atualizar o `requirements.txt` com as versões exatas de todas as bibliotecas instaladas no ambiente virtual.

## Estrutura do Projeto

*   `shell.nix`: Define o ambiente de desenvolvimento Nix, incluindo as dependências do sistema e do Python.
*   `requirements.txt`: Lista as dependências Python do projeto com suas versões travadas.
*   `chatgpt_api.py`: Provavelmente contém a lógica para interagir com a API do ChatGPT para geração de texto.
*   `dalle_image_generator.py`: Provavelmente contém a lógica para interagir com a API DALL-E para geração de imagens.
*   `.gitignore`: Define os arquivos e diretórios a serem ignorados pelo Git (ex: `.env`, `.venv`).

## Uso

(Detalhes sobre como executar os scripts Python e qual a ordem/processo para gerar o podcast.)
Exemplo:
```bash
python chatgpt_api.py
python dalle_image_generator.py
# etc.
```

## Contribuição

Contribuições são bem-vindas! Por favor, abra uma issue ou envie um Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT. (Ou outra licença de sua escolha)
