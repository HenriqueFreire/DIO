#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> // Incluir para usar os tipos 'bool', 'true' e 'false'

/*
 * Este programa demonstra o uso dos operadores RELACIONAIS e LÓGICOS em C.
 *
 * Operadores Relacionais: Comparam dois valores e retornam um resultado booleano (true/false).
 * == (Igual a)
 * != (Diferente de)
 * >  (Maior que)
 * <  (Menor que)
 * >= (Maior ou igual a)
 * <= (Menor ou igual a)
 *
 * Operadores Lógicos: Combinam ou invertem expressões booleanas.
 * && (E Lógico): Retorna 'true' se AMBAS as condições forem verdadeiras.
 * || (OU Lógico): Retorna 'true' se PELO MENOS UMA das condições for verdadeira.
 * !  (NÃO Lógico): Inverte o valor de uma condição.
 */
int main() {
    int a = 10, b = 10, c = 5;

    printf("--- Operadores Relacionais e Lógicos em C ---\n\n");
    printf("Valores iniciais: a = %d, b = %d, c = %d\n\n", a, b, c);

    // --- 1. Operadores Relacionais ---
    printf("--- 1. Operadores Relacionais ---\n");
    printf("   a == b  (%d == %d)  -> %s\n", a, b, (a == b) ? "true" : "false");
    printf("   a != c  (%d != %d)  -> %s\n", a, c, (a != c) ? "true" : "false");
    printf("   a > c   (%d > %d)   -> %s\n", a, c, (a > c) ? "true" : "false");
    printf("   c < b   (%d < %d)   -> %s\n", c, b, (c < b) ? "true" : "false");
    printf("   a >= b  (%d >= %d)  -> %s\n", a, b, (a >= b) ? "true" : "false");
    printf("   c <= a  (%d <= %d)  -> %s\n\n", c, a, (c <= a) ? "true" : "false");

    // --- 2. Operadores Lógicos ---
    bool condicao1 = (a == b); // true
    bool condicao2 = (c > a);  // false
    printf("--- 2. Operadores Lógicos ---\n");
    printf("   Usando condicao1 = (a == b) -> %s\n", condicao1 ? "true" : "false");
    printf("   Usando condicao2 = (c > a)  -> %s\n\n", condicao2 ? "true" : "false");

    printf("   E Lógico (&&):\n");
    printf("   condicao1 && condicao2 (true && false) -> %s\n\n", (condicao1 && condicao2) ? "true" : "false");

    printf("   OU Lógico (||):\n");
    printf("   condicao1 || condicao2 (true || false) -> %s\n\n", (condicao1 || condicao2) ? "true" : "false");

    printf("   NÃO Lógico (!):\n");
    printf("   !condicao2 (!false) -> %s\n\n", !condicao2 ? "true" : "false");

    // --- 3. Combinando Operadores ---
    printf("--- 3. Combinando Operadores ---\n");
    printf("   Avaliando a expressão: (a > c && b == a) || (c > 10)\n");
    printf("   1. (a > c) -> (%d > %d) -> true\n", a, c);
    printf("   2. (b == a) -> (%d == %d) -> true\n", b, a);
    printf("   3. (true && true) -> true\n");
    printf("   4. (c > 10) -> (%d > 10) -> false\n", c);
    printf("   5. (true || false) -> true\n");
    printf("   Resultado final: %s\n\n", ((a > c && b == a) || (c > 10)) ? "true" : "false");

    return EXIT_SUCCESS;
}