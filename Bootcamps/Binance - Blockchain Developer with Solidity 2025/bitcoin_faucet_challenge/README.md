# Desafio de Projeto: Carteiras Bitcoin Testnet com C++

Este projeto é um desafio para criar e gerenciar carteiras Bitcoin na rede de teste (Testnet) usando ferramentas C++ para geração e derivação de chaves, e a carteira Electrum para importação e transações. O objetivo final é observar uma transação em um explorador de blocos.

## Conteúdo do Projeto

- `shell.nix`: Configuração do ambiente de desenvolvimento com Nix, incluindo compilador C++ (GCC) e bibliotecas necessárias (libsecp256k1, OpenSSL).
- `generate_keys.cpp`: Um programa C++ para gerar chaves privadas Bitcoin aleatórias em formato hexadecimal.
- `derive_bitcoin_keys.cpp`: Um programa C++ para derivar chaves privadas WIF (Wallet Import Format) e endereços Bitcoin Testnet a partir de chaves privadas hexadecimais.

## Pré-requisitos

- **Nix:** Para gerenciar o ambiente de desenvolvimento.
- **Compilador C++:** GCC (incluído no `shell.nix`).
- **Bibliotecas de Criptografia:** OpenSSL e libsecp256k1 (incluídas no `shell.nix`).
- **Electrum Wallet:** Para gerenciar as carteiras e realizar transações na Testnet.

## Configuração do Ambiente

1.  **Clone o repositório (se aplicável) ou navegue até a pasta do projeto:**
    ```bash
    cd /caminho/para/bitcoin_faucet_challenge
    ```

2.  **Entre no ambiente de desenvolvimento Nix:**
    ```bash
    nix-shell
    ```
    Na primeira vez, o Nix fará o download e a construção das dependências, o que pode levar um tempo. Seu prompt de comando mudará para indicar que você está no ambiente.

## Uso

### 1. Gerar Chaves Privadas Hexadecimais

Use o `generate_keys.cpp` para criar duas chaves privadas aleatórias em formato hexadecimal.

1.  **Compile:**
    ```bash
    g++ generate_keys.cpp -o generate_keys
    ```
2.  **Execute:**
    ```bash
    ./generate_keys
    ```
    O programa irá imprimir duas chaves privadas hexadecimais. Anote-as.

### 2. Derivar Chaves WIF e Endereços Testnet

Use o `derive_bitcoin_keys.cpp` para converter as chaves hexadecimais geradas em chaves WIF e endereços Bitcoin Testnet.

1.  **Compile:**
    ```bash
    g++ derive_bitcoin_keys.cpp -o derive_bitcoin_keys -lsecp256k1 -lcrypto
    ```
2.  **Execute:**
    Passe as chaves hexadecimais obtidas no passo anterior como argumentos.
    ```bash
    ./derive_bitcoin_keys <sua_chave_hex_1> <sua_chave_hex_2>
    ```
    O programa irá imprimir as chaves WIF e os endereços Testnet correspondentes. Anote-os.

### 3. Configurar e Importar Chaves no Electrum

1.  **Instale o Electrum:**
    Baixe o Electrum do site oficial: `https://electrum.org/#download`.
    Para Linux, o AppImage é geralmente a opção mais fácil.

2.  **Inicie o Electrum no modo Testnet:**
    *   **Linux (AppImage):** `chmod +x electrum-*.AppImage && ./electrum-*.AppImage --testnet`
    *   **Outros:** `electrum --testnet` (se instalado via pip) ou crie um atalho com o parâmetro `--testnet`.

3.  **Importe as Chaves WIF:**
    *   No Electrum (modo Testnet), crie uma "Standard wallet" e selecione "Import Bitcoin addresses or private keys".
    *   Cole as chaves WIF (uma por linha) que você derivou no passo 2.
    *   Defina uma senha para sua carteira.
    *   Aguarde a sincronização. Você verá os endereços importados na aba "Addresses" ou "Receive".

### 4. Obter Moedas Testnet de uma Faucet

Para realizar transações, você precisará de algumas moedas Testnet. Use uma das faucets abaixo para enviar moedas para um dos seus endereços Testnet (o primeiro, por exemplo):

-   [coinfaucet.eu/en/btc-testnet/](https://coinfaucet.eu/en/btc-testnet/)
-   [testnet-faucet.mempool.co/](https://testnet-faucet.mempool.co/)
-   [bitcoinfaucet.uo1.net/](https://bitcoinfaucet.uo1.net/)

Cole um dos seus endereços Testnet da Electrum na faucet e solicite as moedas. Pode levar alguns minutos para as moedas aparecerem na sua carteira Electrum.

### 5. Realizar uma Transação

1.  **Envie Moedas:** No Electrum, vá para a aba "Send" (Enviar).
2.  **De:** Selecione a carteira que recebeu as moedas da faucet.
3.  **Para:** Cole o outro endereço Testnet que você importou para o Electrum.
4.  **Quantia:** Envie uma pequena quantia de BTC Testnet.
5.  **Taxa:** Ajuste a taxa de transação se necessário.
6.  **Assine e Transmita:** Siga as instruções para assinar e transmitir a transação.

### 6. Visualizar a Transação em um Explorador de Blocos

Após transmitir a transação, o Electrum fornecerá um ID de Transação (TXID).

1.  **Copie o TXID.**
2.  **Abra um explorador de blocos Testnet:**
    -   [mempool.space/testnet](https://mempool.space/testnet)
    -   [blockstream.info/testnet](https://blockstream.info/testnet)
3.  **Cole o TXID na barra de pesquisa** do explorador de blocos para ver os detalhes da sua transação.

---

**Parabéns!** Você completou o desafio de criar carteiras, realizar uma transação e verificá-la na Testnet usando ferramentas C++ e Electrum.