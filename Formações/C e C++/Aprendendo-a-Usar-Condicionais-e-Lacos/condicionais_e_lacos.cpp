#include <iostream>
#include <vector> // Usado para o exemplo de range-based for loop

/*
 * Este programa é um guia didático sobre as estruturas de controle em C++.
 * As estruturas são muito semelhantes às de C, mas a forma de interagir
 * com entrada e saída é diferente (usando iostream). C++ também adiciona
 * novas funcionalidades, como o laço 'for' baseado em intervalo.
 *
 * 1. Condicionais:
 *    - if, else if, else
 *    - switch
 *
 * 2. Laços (Loops):
 *    - for
 *    - while
 *    - do-while
 *    - range-based for (C++11 em diante)
 *
 * 3. Controle de Laços:
 *    - break
 *    - continue
 */
int main() {
    // std::cout é o objeto de saída padrão em C++ (equivalente ao printf)
    // std::endl insere uma nova linha e descarrega o buffer de saída
    std::cout << "--- Estruturas de Controle em C++ ---" << std::endl << std::endl;

    // ==================================================
    // 1. ESTRUTURAS CONDICIONAIS
    // ==================================================
    std::cout << "--- 1. Condicionais ---" << std::endl << std::endl;

    // --- if, else if, else ---
    int nota = 85;
    std::cout << "a) if-else if-else (Avaliando a nota " << nota << "):" << std::endl;
    if (nota >= 90) {
        std::cout << "   Conceito A: Excelente!" << std::endl;
    } else if (nota >= 80) {
        std::cout << "   Conceito B: Muito Bom!" << std::endl;
    } else if (nota >= 60) {
        std::cout << "   Conceito C: Satisfatório." << std::endl;
    } else {
        std::cout << "   Conceito D: Precisa melhorar." << std::endl;
    }
    std::cout << std::endl;

    // --- switch ---
    char opcao = 'C';
    std::cout << "b) switch (Avaliando a opção '" << opcao << "'):" << std::endl;
    switch (opcao) {
        case 'A':
            std::cout << "   Opção A selecionada." << std::endl;
            break;
        case 'B':
            std::cout << "   Opção B selecionada." << std::endl;
            break;
        case 'C':
            std::cout << "   Opção C selecionada." << std::endl;
            break;
        default:
            std::cout << "   Opção inválida." << std::endl;
            break;
    }
    std::cout << std::endl;


    // ==================================================
    // 2. LAÇOS (LOOPS)
    // ==================================================
    std::cout << "--- 2. Laços (Loops) ---" << std::endl << std::endl;

    // --- for ---
    std::cout << "a) Laço for (de 1 a 5):" << std::endl << "   ";
    for (int i = 1; i <= 5; i++) {
        std::cout << i << " ";
    }
    std::cout << std::endl << std::endl;

    // --- while ---
    std::cout << "b) Laço while (contagem regressiva de 3):" << std::endl;
    int contador = 3;
    while (contador > 0) {
        std::cout << "   Contador: " << contador << std::endl;
        contador--;
    }
    std::cout << std::endl;

    // --- do-while ---
    std::cout << "c) Laço do-while (executa pelo menos uma vez):" << std::endl;
    int j = 5;
    do {
        std::cout << "   O valor de j é " << j << ". O laço continuará se j < 3." << std::endl;
        j++;
    } while (j < 3);
    std::cout << "   Fim do laço do-while." << std::endl << std::endl;

    // --- Range-based for (C++11) ---
    // Itera sobre todos os elementos de uma coleção (array, vector, etc.).
    std::cout << "d) Range-based for (iterando sobre um vetor):" << std::endl;
    std::vector<int> numeros = {10, 20, 30, 40, 50};
    std::cout << "   ";
    for (int num : numeros) {
        std::cout << num << " ";
    }
    std::cout << std::endl << std::endl;


    // ==================================================
    // 3. CONTROLE DE LAÇOS
    // ==================================================
    std::cout << "--- 3. Controle de Laços ---" << std::endl << std::endl;

    // --- break ---
    std::cout << "a) break (interrompe o laço quando i == 3):" << std::endl << "   ";
    for (int i = 1; i <= 5; i++) {
        if (i == 3) {
            std::cout << "(break!) ";
            break;
        }
        std::cout << i << " ";
    }
    std::cout << std::endl << std::endl;

    // --- continue ---
    std::cout << "b) continue (pula a iteração quando i == 3):" << std::endl << "   ";
    for (int i = 1; i <= 5; i++) {
        if (i == 3) {
            std::cout << "(continue!) ";
            continue;
        }
        std::cout << i << " ";
    }
    std::cout << std::endl << std::endl;

    return 0; // Em C++, retornar 0 de main() indica sucesso.
}
