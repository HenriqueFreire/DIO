# Gerador de QR Code e Senhas

Este projeto é uma ferramenta de linha de comando (CLI) desenvolvida em Node.js que permite aos usuários gerar QR codes a partir de links e também criar senhas seguras.

## Funcionalidades

- **Gerador de QR Code:** Pede um link ao usuário e gera um QR code que é exibido diretamente no terminal.
- **Gerador de Senha:** Cria uma senha segura (a funcionalidade exata de senha não está detalhada nos arquivos lidos, mas a opção existe no menu).
- Interface de linha de comando interativa para fácil utilização.

## Tecnologias Utilizadas

- [Node.js](https://nodejs.org/)
- [qrcode-terminal](https://www.npmjs.com/package/qrcode-terminal): Para gerar o QR Code no terminal.
- [prompt](https://www.npmjs.com/package/prompt): Para criar os prompts interativos para o usuário.
- [chalk](https://www.npmjs.com/package/chalk): Para estilizar o texto no terminal.

## Instalação

1. Clone o repositório:
   ```bash
   git clone <URL_DO_REPOSITORIO>
   ```
2. Navegue até o diretório do projeto:
   ```bash
   cd "Criando um Gerador de QR Codes para E-commerces com Node.js"
   ```
3. Instale as dependências do projeto:
   ```bash
   npm install
   ```

## Como Usar

Para iniciar a aplicação, execute o seguinte comando no seu terminal:

```bash
npm run dev
```

Você será apresentado a um menu interativo onde poderá escolher entre gerar um QR Code (opção 1) ou uma senha (opção 2).
