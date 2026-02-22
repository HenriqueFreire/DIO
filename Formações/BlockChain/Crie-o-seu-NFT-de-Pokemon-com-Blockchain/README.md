# NFT Pokémon Battle Game

Este projeto visa criar um jogo de batalhas de Pokémon utilizando tecnologia NFT (Non-Fungible Token). O jogo permite aos usuários possuir Pokémon como NFTs, batalhar entre si e gerenciar seus ativos digitais em uma blockchain.

## Tecnologias Utilizadas

*   **Nix/shell.nix**: Para um ambiente de desenvolvimento reprodutível e gerenciamento de dependências.
*   **Solidity**: Linguagem de programação para os contratos inteligentes na blockchain.
*   **Ganache**: Blockchain pessoal para desenvolvimento e testes locais.
*   **Metamask**: Extensão de navegador para interação com a blockchain e gerenciamento de carteira.
*   **JavaScript (Frontend)**: Para a interface do usuário da aplicação descentralizada (DApp).
*   **IPFS (InterPlanetary File System)**: Para armazenamento descentralizado de metadados e imagens dos Pokémon.
*   **OpenZeppelin Contracts**: Bibliotecas de contratos inteligentes seguras e auditadas para padrões ERC-721 e outras utilidades.

## Funcionalidades

*   Criação e gerenciamento de Pokémon como NFTs ERC-721.
*   Mecanismo básico de batalha entre Pokémon, com cálculo de dano baseado em atributos.
*   Conexão com Metamask para interação do usuário com a blockchain.
*   Interface web para visualizar Pokémon e iniciar batalhas (funcionalidade básica).

## Primeiros Passos

### Configuração do Ambiente de Desenvolvimento

Este projeto utiliza `shell.nix` para garantir um ambiente de desenvolvimento consistente.

1.  **Instale o Nix (se ainda não o fez):** Siga as instruções em [nixos.org](https://nixos.org/download.html).
2.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    cd Crie-o-seu-NFT-de-Pokemon-com-Blockchain
    ```
3.  **Entre no ambiente de desenvolvimento:**
    ```bash
    nix-shell
    ```
    Isso configurará automaticamente todas as dependências do sistema e do Node.js (incluindo `solc`, `npm`, `http-server`, `kubo` - o cliente IPFS).

4.  **Instale as dependências do Node.js:**
    ```bash
    npm init -y
    npm install @openzeppelin/contracts ethers
    ```

### Compilação do Contrato Inteligente

Devido a potenciais problemas de resolução de caminho em ambientes Nix com `solc` e importações do OpenZeppelin, a compilação pode precisar de ajustes específicos.

1.  **Certifique-se de estar no ambiente `nix-shell`.**
2.  **Compile o contrato `PokemonNFT.sol`:**
    ```bash
    solc --abi --bin contracts/PokemonNFT.sol -o . --overwrite --base-path . --include-path node_modules
    ```
    Este comando deve gerar os arquivos `PokemonNFT.abi` e `PokemonNFT.bin` na raiz do seu projeto. Se encontrar erros de importação, pode ser necessário verificar a documentação específica do `solc` para seu ambiente Nix ou considerar o uso de um framework como Hardhat/Truffle (com as devidas configurações).

### Implantação do Contrato

1.  **Inicie o Ganache:** Em um **primeiro terminal** (dentro do `nix-shell`), inicie o Ganache:
    ```bash
    ganache
    ```
    Mantenha este terminal em execução, pois o DApp e o script de implantação interagirão com ele.

2.  **Execute o script de implantação:** Em um **segundo terminal** (dentro do `nix-shell` e após o Ganache estar rodando):
    ```bash
    node deploy/deploy.js
    ```
    Este script implantará o contrato `PokemonNFT` no seu Ganache local e salvará o endereço do contrato implantado em `deploy/contract-address.json`.

### Aplicação Frontend

1.  **Sirva a aplicação frontend:** No **segundo terminal** (após a implantação do contrato), navegue até o diretório `frontend` e inicie um servidor HTTP:
    ```bash
    cd frontend
    http-server
    ```
    O servidor geralmente será acessível em `http://localhost:8080`.

2.  **Acesse o DApp no navegador:**
    *   Certifique-se de ter a extensão Metamask instalada e configurada em seu navegador.
    *   Conecte sua carteira Metamask à sua rede Ganache local (geralmente `http://127.0.0.1:8545`).
    *   Abra `http://localhost:8080` (ou o endereço fornecido pelo `http-server`) no seu navegador.
    *   Clique em "Connect Metamask" para conectar sua carteira ao DApp.

### Integração com IPFS

O IPFS é usado para armazenar as imagens e metadados dos Pokémon de forma descentralizada.

1.  **Instale o Kubo (cliente IPFS):** O `kubo` está disponível no seu ambiente `nix-shell`.
2.  **Inicialize o repositório IPFS:** Em um terminal (dentro do `nix-shell`):
    ```bash
    kubo init
    ```
3.  **Inicie o daemon IPFS:** Em um terminal **separado** (dentro do `nix-shell`):
    ```bash
    kubo daemon
    ```
    Isso iniciará seu nó IPFS local.

4.  **Carregue imagens e metadados de Pokémon para o IPFS:**
    *   **Imagens:** Crie um diretório para suas imagens (ex: `assets/images`) e adicione-as:
        ```bash
        kubo add -r assets/images
        # Anote os CIDs (Content Identifiers) resultantes
        ```
    *   **Metadados:** Crie arquivos JSON para cada Pokémon (ex: `pikachu.json`) seguindo o esquema de metadados ERC-721, incluindo o CID da imagem:
        ```json
        {
          "name": "Pikachu",
          "description": "Um Pokémon tipo elétrico.",
          "image": "ipfs://<CID_DA_IMAGEM_PIKACHU>"
        }
        ```
        Crie um diretório para seus metadados (ex: `assets/metadata`) e adicione-os:
        ```bash
        kubo add -r assets/metadata
        # Anote os CIDs resultantes. O CID do arquivo JSON de metadados será o `_imageUrl` no `safeMint`.
        ```
5.  **Atualize o Frontend (`app.js`):** A função `displayOwnedPokemon` em `frontend/app.js` já inclui a lógica para buscar metadados e imagens do IPFS, usando gateways públicos como `https://ipfs.io/ipfs/`.

## Testes

### Testes de Contrato Inteligente

É altamente recomendável usar um framework de teste como Hardhat ou Truffle para testar seus contratos Solidity.

1.  **Escolha um Framework:** Instale e configure Hardhat ou Truffle (`npm install --save-dev hardhat` ou `npm install --save-dev truffle`).
2.  **Escreva os Testes:** Crie arquivos de teste (ex: `test/PokemonNFT.js`) para:
    *   Implantar o contrato `PokemonNFT`.
    *   Testar a cunhagem de novos NFTs de Pokémon.
    *   Verificar a propriedade e os detalhes do token.
    *   Testar as mecânicas de batalha (iniciar batalha, atacar, condições de vitória/derrota).
3.  **Execute os Testes:** Utilize o comando do framework escolhido (ex: `npx hardhat test` ou `truffle test`).

### Testes de Frontend

Para a interface JavaScript, você pode usar frameworks de teste como Jest ou Cypress.

1.  **Escolha um Framework:** Instale e configure Jest ou Cypress (`npm install --save-dev jest` ou `npm install --save-dev cypress`).
2.  **Escreva os Testes:** Crie arquivos de teste (ex: `frontend/test/app.test.js`) para:
    *   Simular a conexão com o Metamask.
    *   Simular interações com o contrato.
    *   Verificar atualizações da UI com base nos dados do contrato.
    *   Testar cliques de botão e fluxos de usuário.
3.  **Execute os Testes:** Utilize o comando do framework escolhido (ex: `jest` ou `cypress run`).

## Próximos Passos / Melhorias Futuras

*   Implementar um mecanismo de viradas (turn-based) mais robusto para batalhas.
*   Adicionar mais atributos e habilidades aos Pokémon.
*   Desenvolver uma UI mais rica e interativa para as batalhas.
*   Implementar um marketplace para troca de Pokémon.
*   Adicionar eventos e recompensas on-chain para batalhas.
*   Refinar a gestão de erros e feedback do usuário no frontend.
