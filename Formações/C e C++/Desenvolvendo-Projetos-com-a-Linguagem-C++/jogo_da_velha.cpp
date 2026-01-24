#include <iostream> // Para entrada/saída (cout, cin)
#include <vector>   // Não estritamente necessário, mas útil para outras coisas
#include <string>   // Para strings

// --- 1. Função: Inicializar o Tabuleiro ---
// Preenche todas as células do tabuleiro com espaços vazios.
void inicializarTabuleiro(char tabuleiro[3][3]) {
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            tabuleiro[i][j] = ' ';
        }
    }
}

// --- 2. Função: Exibir o Tabuleiro ---
// Imprime o estado atual do tabuleiro no console.
void exibirTabuleiro(const char tabuleiro[3][3]) {
    std::cout << "\n";
    std::cout << "  1   2   3\n";
    std::cout << "1 " << tabuleiro[0][0] << " | " << tabuleiro[0][1] << " | " << tabuleiro[0][2] << "\n";
    std::cout << " ---" << "+" << "---" << "+" << "---\n";
    std::cout << "2 " << tabuleiro[1][0] << " | " << tabuleiro[1][1] << " | " << tabuleiro[1][2] << "\n";
    std::cout << " ---" << "+" << "---" << "+" << "---\n";
    std::cout << "3 " << tabuleiro[2][0] << " | " << tabuleiro[2][1] << " | " << tabuleiro[2][2] << "\n";
    std::cout << "\n";
}

// --- 3. Função: Verificar Vitória ---
// Verifica se o jogador atual venceu o jogo.
bool verificarVitoria(const char tabuleiro[3][3], char jogador) {
    // Verificar linhas
    for (int i = 0; i < 3; ++i) {
        if (tabuleiro[i][0] == jogador && tabuleiro[i][1] == jogador && tabuleiro[i][2] == jogador) {
            return true;
        }
    }
    // Verificar colunas
    for (int j = 0; j < 3; ++j) {
        if (tabuleiro[0][j] == jogador && tabuleiro[1][j] == jogador && tabuleiro[2][j] == jogador) {
            return true;
        }
    }
    // Verificar diagonais
    if (tabuleiro[0][0] == jogador && tabuleiro[1][1] == jogador && tabuleiro[2][2] == jogador) {
        return true;
    }
    if (tabuleiro[0][2] == jogador && tabuleiro[1][1] == jogador && tabuleiro[2][0] == jogador) {
        return true;
    }
    return false;
}

// --- 4. Função: Verificar Empate ---
// Verifica se o tabuleiro está cheio e não há vencedor.
bool verificarEmpate(const char tabuleiro[3][3]) {
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            if (tabuleiro[i][j] == ' ') {
                return false; // Ainda há espaços vazios, não é empate
            }
        }
    }
    return true; // Tabuleiro cheio, é empate
}

// --- 5. Função: Fazer Jogada ---
// Tenta fazer uma jogada no tabuleiro. Retorna true se a jogada for válida e feita, false caso contrário.
bool fazerJogada(char tabuleiro[3][3], char jogador, int linha, int coluna) {
    // Ajusta para índices 0-base
    linha--; 
    coluna--;

    if (linha >= 0 && linha < 3 && coluna >= 0 && coluna < 3 && tabuleiro[linha][coluna] == ' ') {
        tabuleiro[linha][coluna] = jogador;
        return true;
    }
    std::cout << "Jogada inválida! Tente novamente.\n";
    return false;
}

// --- 6. Função: Obter Jogada do Usuário ---
// Solicita ao jogador a linha e coluna e valida a entrada.
void obterJogada(char jogador, int& linha, int& coluna) {
    while (true) {
        std::cout << "Jogador " << jogador << ", digite sua jogada (linha coluna): ";
        std::cin >> linha >> coluna;
        if (std::cin.fail() || linha < 1 || linha > 3 || coluna < 1 || coluna > 3) {
            std::cout << "Entrada inválida. Use números de 1 a 3 para linha e coluna.\n";
            std::cin.clear(); // Limpa o estado de erro do cin
            std::cin.ignore(10000, '\n'); // Descarta o resto da linha de entrada
        } else {
            break;
        }
    }
}

int main() {
    char tabuleiro[3][3];
    char jogadorAtual = 'X';
    bool jogoTerminado = false;
    int linha, coluna;

    inicializarTabuleiro(tabuleiro);

    std::cout << "--- Bem-vindo ao Jogo da Velha! ---\n";

    while (!jogoTerminado) {
        exibirTabuleiro(tabuleiro);
        obterJogada(jogadorAtual, linha, coluna);

        if (fazerJogada(tabuleiro, jogadorAtual, linha, coluna)) {
            if (verificarVitoria(tabuleiro, jogadorAtual)) {
                exibirTabuleiro(tabuleiro);
                std::cout << "Parabéns! Jogador " << jogadorAtual << " venceu!\n";
                jogoTerminado = true;
            } else if (verificarEmpate(tabuleiro)) {
                exibirTabuleiro(tabuleiro);
                std::cout << "O jogo terminou em empate!\n";
                jogoTerminado = true;
            } else {
                // Troca de jogador
                jogadorAtual = (jogadorAtual == 'X') ? 'O' : 'X';
            }
        }
        // Se a jogada foi inválida, o loop continua e o mesmo jogador tenta novamente.
    }

    std::cout << "\n--- Fim do Jogo ---\n";

    return 0;
}
