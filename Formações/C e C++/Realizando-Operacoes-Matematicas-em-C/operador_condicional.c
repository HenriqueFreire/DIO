#include <stdio.h>
#include <stdlib.h>

/*
 * Este programa demonstra o uso do operador condicional, também conhecido como
 * operador ternário. Ele é uma forma concisa de escrever uma instrução if-else.
 *
 * A sintaxe é:
 * condicao ? expressao_se_verdadeiro : expressao_se_falso;
 *
 * 1. A 'condicao' é avaliada primeiro.
 * 2. Se a condição for verdadeira (não-zero), a 'expressao_se_verdadeiro' é executada.
 * 3. Se a condição for falsa (zero), a 'expressao_se_falso' é executada.
 * 4. O resultado de toda a expressão é o valor da expressão que foi executada.
 */
int main() {
    int a = 10, b = 20;
    int maior;
    char* paridade;

    printf("--- Operador Condicional (Ternário) em C ---\n\n");
    printf("Valores iniciais: a = %d, b = %d\n\n", a, b);

    // --- Exemplo 1: Encontrando o maior de dois números ---
    // Se 'a' for maior que 'b', 'maior' recebe 'a'. Senão, 'maior' recebe 'b'.
    maior = (a > b) ? a : b;
    printf("1. Encontrando o maior valor entre %d e %d:\n", a, b);
    printf("   O maior valor é: %d\n\n", maior);

    // --- Exemplo 2: Verificando se um número é par ou ímpar ---
    // Se o resto da divisão de 'a' por 2 for 0, o número é par. Senão, é ímpar.
    paridade = ((a % 2) == 0) ? "Par" : "Ímpar";
    printf("2. Verificando se o número %d é Par ou Ímpar:\n", a);
    printf("   O número é: %s\n\n", paridade);

    // --- Exemplo 3: Usando o operador diretamente em uma função ---
    // O resultado da expressão ternária é passado diretamente como argumento para printf.
    printf("3. Usando o operador diretamente dentro de um printf:\n");
    printf("   O valor de 'a' é %s que 15.\n\n", (a > 15) ? "maior" : "menor ou igual a");

    // --- Exemplo 4: Aninhando operadores ternários (usar com cautela) ---
    // Pode se tornar difícil de ler, mas é possível.
    int x = 0;
    char* sinal;

    sinal = (x > 0) ? "positivo" : ((x < 0) ? "negativo" : "zero");
    printf("4. Aninhando operadores para verificar o sinal de x = %d:\n", x);
    printf("   O número é: %s\n\n", sinal);


    return EXIT_SUCCESS;
}
