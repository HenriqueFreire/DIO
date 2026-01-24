#include <stdio.h>
#include <stdlib.h>

/*
 * Este programa é um guia didático sobre as estruturas de controle em C:
 * 1. Condicionais: Para tomar decisões no código.
 *    - if, else if, else
 *    - switch
 *
 * 2. Laços (Loops): Para repetir blocos de código.
 *    - for
 *    - while
 *    - do-while
 *
 * 3. Controle de Laços: Para alterar o fluxo de um laço.
 *    - break
 *    - continue
 */
int main() {
    printf("--- Estruturas de Controle em C ---\n\n");

    // ==================================================
    // 1. ESTRUTURAS CONDICIONAIS
    // ==================================================
    printf("--- 1. Condicionais ---\n\n");

    // --- if, else if, else ---
    // Usado para executar blocos de código baseados em uma série de condições.
    int nota = 75;
    printf("a) if-else if-else (Avaliando a nota %d):\n", nota);
    if (nota >= 90) {
        printf("   Conceito A: Excelente!\n");
    } else if (nota >= 70) {
        printf("   Conceito B: Muito Bom!\n");
    } else if (nota >= 50) {
        printf("   Conceito C: Satisfatório.\n");
    } else {
        printf("   Conceito D: Precisa melhorar.\n");
    }
    printf("\n");

    // --- switch ---
    // Usado para escolher um entre vários blocos de código para ser executado.
    // É uma alternativa ao if-else if quando a condição é baseada no valor de uma única variável.
    char opcao = 'B';
    printf("b) switch (Avaliando a opção '%c'):\n", opcao);
    switch (opcao) {
        case 'A':
            printf("   Opção A selecionada.\n");
            break; // 'break' impede a execução dos casos seguintes (fall-through).
        case 'B':
            printf("   Opção B selecionada.\n");
            break;
        case 'C':
            printf("   Opção C selecionada.\n");
            break;
        default: // 'default' é executado se nenhum dos casos corresponder.
            printf("   Opção inválida.\n");
            break;
    }
    printf("\n");


    // ==================================================
    // 2. LAÇOS (LOOPS)
    // ==================================================
    printf("--- 2. Laços (Loops) ---\n\n");

    // --- for ---
    // Ideal para quando se sabe o número de vezes que o laço deve ser executado.
    // Sintaxe: for (inicialização; condição; incremento)
    printf("a) Laço for (de 1 a 5):\n   ");
    for (int i = 1; i <= 5; i++) {
        printf("%d ", i);
    }
    printf("\n\n");

    // --- while ---
    // Executa um bloco de código ENQUANTO uma condição for verdadeira.
    // A condição é testada ANTES de cada iteração.
    printf("b) Laço while (contagem regressiva de 3):\n");
    int contador = 3;
    while (contador > 0) {
        printf("   Contador: %d\n", contador);
        contador--;
    }
    printf("\n");

    // --- do-while ---
    // Similar ao 'while', mas garante que o bloco de código seja executado PELO MENOS UMA VEZ.
    // A condição é testada DEPOIS de cada iteração.
    printf("c) Laço do-while (executa pelo menos uma vez):\n");
    int j = 5;
    do {
        printf("   O valor de j é %d. O laço continuará se j < 3.\n", j);
        j++;
    } while (j < 3);
    printf("   Fim do laço do-while.\n\n");


    // ==================================================
    // 3. CONTROLE DE LAÇOS
    // ==================================================
    printf("--- 3. Controle de Laços ---\n\n");

    // --- break ---
    // Interrompe a execução de um laço (for, while, do-while) ou switch.
    printf("a) break (interrompe o laço quando i == 3):\n   ");
    for (int i = 1; i <= 5; i++) {
        if (i == 3) {
            printf("(break!) ");
            break;
        }
        printf("%d ", i);
    }
    printf("\n\n");

    // --- continue ---
    // Pula a iteração atual e continua para a próxima iteração do laço.
    printf("b) continue (pula a iteração quando i == 3):\n   ");
    for (int i = 1; i <= 5; i++) {
        if (i == 3) {
            printf("(continue!) ");
            continue;
        }
        printf("%d ", i);
    }
    printf("\n\n");


    return EXIT_SUCCESS;
}