#include <stdio.h>
#include <stdlib.h>

/*
 * Este programa foca nos operadores de incremento (++) e decremento (--),
 * demonstrando a diferença crucial entre a forma pré-fixada e a pós-fixada.
 *
 * - Pós-fixado (ex: a++): O valor da variável é usado na expressão primeiro,
 *   e SÓ DEPOIS ele é incrementado.
 *
 * - Pré-fixado (ex: ++a): O valor da variável é incrementado primeiro,
 *   e o NOVO valor é então usado na expressão.
 */
int main() {
    int a, b;

    printf("--- Operadores de Incremento e Decremento ---\n\n");

    // --- Pós-incremento (a++) ---
    printf("1. Pós-incremento (a++):\n");
    a = 5;
    printf("   Valor inicial de 'a': %d\n", a);
    b = a++; // b recebe o valor de 'a' (5), DEPOIS 'a' é incrementado para 6.
    printf("   Executando 'b = a++':\n");
    printf("     - O valor de 'b' é: %d (valor de 'a' ANTES do incremento)\n", b);
    printf("     - O valor de 'a' agora é: %d (valor de 'a' DEPOIS do incremento)\n\n", a);

    // --- Pré-incremento (++a) ---
    printf("2. Pré-incremento (++a):\n");
    a = 5;
    printf("   Valor inicial de 'a': %d\n", a);
    b = ++a; // 'a' é incrementado para 6 PRIMEIRO, DEPOIS 'b' recebe o novo valor de 'a' (6).
    printf("   Executando 'b = ++a':\n");
    printf("     - O valor de 'a' agora é: %d (valor de 'a' DEPOIS do incremento)\n", a);
    printf("     - O valor de 'b' é: %d (valor de 'a' DEPOIS do incremento)\n\n", b);

    // --- Pós-decremento (a--) ---
    printf("3. Pós-decremento (a--):\n");
    a = 5;
    printf("   Valor inicial de 'a': %d\n", a);
    b = a--; // b recebe o valor de 'a' (5), DEPOIS 'a' é decrementado para 4.
    printf("   Executando 'b = a--':\n");
    printf("     - O valor de 'b' é: %d (valor de 'a' ANTES do decremento)\n", b);
    printf("     - O valor de 'a' agora é: %d (valor de 'a' DEPOIS do decremento)\n\n", a);

    // --- Pré-decremento (--a) ---
    printf("4. Pré-decremento (--a):\n");
    a = 5;
    printf("   Valor inicial de 'a': %d\n", a);
    b = --a; // 'a' é decrementado para 4 PRIMEIRO, DEPOIS 'b' recebe o novo valor de 'a' (4).
    printf("   Executando 'b = --a':\n");
    printf("     - O valor de 'a' agora é: %d (valor de 'a' DEPOIS do decremento)\n", a);
    printf("     - O valor de 'b' é: %d (valor de 'a' DEPOIS do decremento)\n\n", b);

    return EXIT_SUCCESS;
}
