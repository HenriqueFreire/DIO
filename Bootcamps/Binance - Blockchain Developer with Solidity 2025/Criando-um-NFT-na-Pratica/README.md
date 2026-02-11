# 🎨 Criando um NFT na Prática

Bem-vindo ao projeto **Criando um NFT na Prática**! Este repositório contém um contrato inteligente completo para a criação (minting) de NFTs seguindo o padrão **ERC-721**, desenvolvido com as tecnologias mais modernas do ecossistema Ethereum.

---

## 🚀 Tecnologias Utilizadas

- **Solidity (^0.8.20)**: Linguagem para contratos inteligentes.
- **Hardhat**: Ambiente de desenvolvimento profissional para Ethereum.
- **TypeScript**: Para scripts de deploy e configuração com tipagem estática.
- **OpenZeppelin**: Contratos auditados e seguros.
- **Nix**: Ambiente determinístico para garantir que o projeto funcione em qualquer máquina.

---

## 🛠️ Configuração do Ambiente

Este projeto utiliza o **Nix** para gerenciar dependências de forma segura e consistente.

1.  **Entrar no Ambiente**:
    ```bash
    nix-shell
    ```
    *Isso ativará o Node.js e o npm na versão correta.*

2.  **Instalar Dependências**:
    ```bash
    npm install
    ```

---

## 📂 Estrutura do Projeto

- `contracts/`: Onde mora o nosso contrato inteligente `MyNFT.sol`.
- `scripts/`: Scripts de deploy e interação (TypeScript).
- `shell.nix`: Configuração do ambiente de desenvolvimento.
- `hardhat.config.ts`: Configurações globais do Hardhat.

---

## 📖 Como Usar

### Compilando o Contrato
```bash
npx hardhat compile
```

### Deploy e Minting Local
Para subir o contrato na rede local do Hardhat e cunhar o primeiro NFT automaticamente:
```bash
npx hardhat run scripts/deploy.ts
```

---

## 💡 Customização

Para cunhar seu próprio NFT com metadados personalizados:
1.  Abra o arquivo `scripts/deploy.ts`.
2.  Altere a constante `tokenURI` para o link do seu JSON (hospedado no IPFS/Pinata).

---

## 📄 Licença

Este projeto está sob a licença **MIT**. Sinta-se à vontade para clonar e evoluir!

---
*Desenvolvido durante o Bootcamp da DIO - Blockchain Developer with Solidity.*
