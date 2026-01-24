# Exemplo Didático: Jogo da Velha em C++

Este projeto demonstra a implementação de um clássico **Jogo da Velha (Tic-Tac-Toe)** utilizando a linguagem C++. É um excelente exemplo para praticar conceitos básicos de programação, como arrays 2D, funções, estruturas condicionais, loops e manipulação de entrada/saída.

## Conteúdo do Projeto:

*   `jogo_da_velha.cpp`: Contém o código-fonte completo do jogo.
*   `README.md`: Este arquivo, explicando o projeto.

## Conceitos de Programação Demonstrados:

### 1. Representação do Tabuleiro

*   O tabuleiro do jogo é representado por um **array 2D de caracteres** (`char tabuleiro[3][3]`). Cada célula pode conter 'X', 'O' ou um espaço (' ') para indicar uma célula vazia.

### 2. Funções Modulares

O código é organizado em funções, cada uma com uma responsabilidade específica, o que melhora a legibilidade e a manutenção:

*   **`inicializarTabuleiro(char tabuleiro[3][3])`:** Preenche o tabuleiro com espaços vazios no início do jogo.
*   **`exibirTabuleiro(const char tabuleiro[3][3])`:** Imprime o estado atual do tabuleiro no console, de forma clara para os jogadores. O uso de `const` indica que a função não modificará o tabuleiro.
*   **`verificarVitoria(const char tabuleiro[3][3], char jogador)`:** Verifica todas as combinações possíveis (linhas, colunas e diagonais) para determinar se o `jogador` atual venceu.
*   **`verificarEmpate(const char tabuleiro[3][3])`:** Percorre o tabuleiro para verificar se todas as células estão preenchidas e, se não houver vencedor, declara empate.
*   **`fazerJogada(char tabuleiro[3][3], char jogador, int linha, int coluna)`:** Tenta colocar a marca do `jogador` na `linha` e `coluna` especificadas. Inclui validação para garantir que a jogada seja dentro dos limites do tabuleiro e em uma célula vazia.
*   **`obterJogada(char jogador, int& linha, int& coluna)`:** Solicita ao `jogador` que insira sua jogada (linha e coluna) e valida a entrada.

### 3. Fluxo do Jogo (Loop Principal)

*   A função `main()` contém um **loop `while`** que controla o fluxo do jogo.
*   A cada iteração do loop, o tabuleiro é exibido, a jogada do jogador atual é obtida e validada, e então o jogo verifica se houve vitória ou empate.
*   O `jogadorAtual` é alternado entre 'X' e 'O' após cada jogada válida.
*   O loop continua até que um jogador vença ou o jogo termine em empate.

### 4. Manipulação de Entrada/Saída

*   **`std::cout`:** Usado para exibir mensagens e o tabuleiro no console.
*   **`std::cin`:** Usado para ler a entrada do usuário (linha e coluna da jogada).
*   **`std::cin.fail()`, `std::cin.clear()`, `std::cin.ignore()`:** Demonstração de como lidar com entradas inválidas do usuário para tornar o programa mais robusto.

## Como Compilar e Executar:

1.  **Navegue até a pasta:**
    ```bash
    cd Desenvolvendo-Projetos-com-a-Linguagem-C++
    ```
2.  **Compile o código:**
    ```bash
    g++ jogo_da_velha.cpp -o jogo_da_velha
    ```
    (Use `g++` para compilar código C++).
3.  **Execute o programa:**
    ```bash
    ./jogo_da_velha
    ```

O programa iniciará o jogo da velha, permitindo que dois jogadores se alternem para fazer suas jogadas no console.