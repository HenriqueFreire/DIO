# Mahou Technologies DAO

Este projeto é uma **Organização Autônoma Descentralizada (DAO)** focada em governança e distribuição de lucros, desenvolvida como parte do Bootcamp Binance - Blockchain Developer with Solidity 2025 (DIO).

A plataforma permite que investidores possuam tokens de participação (`MAHOU`), participem da governança e recebam dividendos de forma transparente via Smart Contracts.

## 🚀 Estrutura do Projeto

O repositório está dividido em duas partes principais:

- **`/contracts`**: Contratos inteligentes escritos em Solidity.
  - `MahouToken.sol`: Token ERC20 com suporte a Direito de Preferência (ROFR).
  - `MahouTreasury.sol`: Tesouraria que gerencia ciclos de lucro e distribuições baseadas em posse de tokens.
- **`/frontend`**: Dashboard moderno construído com React, Vite e Ethers.js.
  - Integração Web3 completa com MetaMask.
  - Visualização em tempo real de saldos e lucros acumulados.
  - Design premium com estética "Glassmorphism".

## 🛠️ Tecnologias Utilizadas

- **Blockchain**: Solidity, OpenZeppelin, Ethers.js.
- **Frontend**: React.js, Vite, Vanilla CSS.
- **Ambiente**: Nix Shell (Node.js 20).

## 📦 Como Executar

### Pré-requisitos

- [Node.js](https://nodejs.org/) (recomendado v20+) ou o gerenciador de pacotes [Nix](https://nixos.org/).
- Extensão [MetaMask](https://metamask.io/) no navegador.

### Passo a Passo

1. **Entrar no Ambiente (Opcional - via Nix)**:
   ```bash
   nix-shell
   ```

2. **Instalar Dependências**:
   ```bash
   npm install
   ```

3. **Executar o Frontend**:
   ```bash
   npm run dev
   ```
   Acesse `http://localhost:3000` no seu navegador.

## 🔗 Integração Web3

O dashboard está preparado para interagir com os contratos na rede. Para conectar sua carteira:
1. Clique em **"Conectar Carteira Web3"** no rodapé.
2. Aprove a conexão na MetaMask.
3. Seu saldo de tokens `MAHOU` e as opções de saque de lucros ficarão disponíveis.

## 📝 Licença

Este projeto está sob a licença [MIT](LICENSE).
