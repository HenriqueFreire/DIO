# ZeDaManga (ZDM) Token

Este repositório contém o código-fonte e scripts para o token **ZeDaManga** (ZDM), um token ERC-20 desenvolvido com **Nix**, **Hardhat**, **TypeScript** e otimizado com **Yul (Assembly)**.

## 🚀 Como Rodar o Projeto

Este projeto utiliza **Nix** para gerenciar o ambiente de desenvolvimento de forma reprodutível.

### Pré-requisitos
- **Nix** instalado no sistema.

### Configuração do Ambiente
Utilizamos um `shell.nix` que provisiona automaticamente:
- **Node.js v20**
- **NPM**
- **Git** e **Curl**

Para entrar no ambiente isolado:
```bash
nix-shell
```
*Todas as dependências do projeto (Hardhat, TypeScript, etc.) serão instaladas/verificadas automaticamente via `npm` ao entrar.*

### Comandos Disponíveis

Dentro do `nix-shell`:

**Compilar os contratos:**
```bash
npx hardhat compile
```

**Fazer Deploy na rede local do Hardhat:**
```bash
npx hardhat run scripts/deploy.ts
```
*Saída esperada:*
```
Fazendo deploy do contrato com a conta: 0xf39...
ZeDaManga implantado em: 0x5Fb...
```

**Rodar Testes:**
```bash
npx hardhat test
```

---

## ⚡ Otimização: Yul (Assembly)

Para atingir máxima eficiência de gás, o contrato `ZeDaManga` foi reescrito utilizando **Yul (Inline Assembly)**.

Embora o arquivo tenha extensão `.sol`, o corpo do contrato [contracts/ZeDaManga.sol](contracts/ZeDaManga.sol) utiliza blocos `assembly { ... }` para manipular diretamente a memória e o armazenamento da EVM, ignorando grande parte do overhead do Solidity padrão. Isso demonstra um conhecimento avançado da máquina virtual Ethereum (EVM).

---

## 📖 Funcionalidades do Token

O token segue o padrão **ERC-20** e possui as seguintes características:

### Informações Básicas
- **Nome**: `ZeDaManga`
- **Símbolo**: `ZDM`
- **Decimais**: `18`
- **Supply Total**: `1,000,000` (Fixo)

### Funções (Padrão ERC-20)
- **`balanceOf(address)`**: Consulta saldo.
- **`transfer(to, amount)`**: Transfere tokens.
- **`approve(spender, amount)`**: Autoriza gasto por terceiros.
- **`transferFrom(from, to, amount)`**: Transfere tokens autorizados.
- **`allowance(owner, spender)`**: Consulta autorização restante.

### Curiosidade Técnica
O contrato não herda de nenhuma biblioteca (como OpenZeppelin) na versão final. Ele implementa a lógica ERC-20 "na unha" usando Assembly para ser o mais leve possível.

---

## 🛠️ Tecnologias Utilizadas
- **Nix**: Gerenciamento de pacotes do sistema
- **Hardhat**: Ambiente de desenvolvimento Ethereum
- **TypeScript**: Scripts tipados
- **Yul/Assembly**: Otimização de contratos inteligentes
