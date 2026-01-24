#include <stdio.h>
#include <stdlib.h>

/*
 * Este programa demonstra o uso dos operadores matemáticos básicos em C.
 * Os operadores abordados são:
 * - Adição (+)
 * - Subtração (-)
 * - Multiplicação (*)
 * - Divisão (/)
 * - Módulo (%)
 * - Incremento (++)
 * - Decremento (--)
 */
int main() {
    // Declaração de variáveis que usaremos nos exemplos
    int a = 10, b = 3;
    float c = 10.0, d = 3.0;

    printf("--- Operadores Matemáticos em C ---\n\n");
    printf("Valores iniciais: a = %d, b = %d, c = %.1f, d = %.1f\n\n", a, b, c, d);

    // --- Adição (+) ---
    // Soma dois valores.
    int soma = a + b;
    printf("1. Adição:\n");
    printf("   %d + %d = %d\n\n", a, b, soma);

    // --- Subtração (-) ---
    // Subtrai o segundo valor do primeiro.
    int subtracao = a - b;
    printf("2. Subtração:\n");
    printf("   %d - %d = %d\n\n", a, b, subtracao);

    // --- Multiplicação (*) ---
    // Multiplica dois valores.
    int multiplicacao = a * b;
    printf("3. Multiplicação:\n");
    printf("   %d * %d = %d\n\n", a, b, multiplicacao);

    // --- Divisão (/) ---
    // Divide o primeiro valor pelo segundo.
    // O comportamento difere entre inteiros e pontos flutuantes.

    // Divisão de inteiros: a parte fracionária é descartada.
    int divisao_inteira = a / b;
    printf("4. Divisão:\n");
    printf("   Divisão de Inteiros: %d / %d = %d (a parte decimal é truncada)\n", a, b, divisao_inteira);

    // Divisão de pontos flutuantes: o resultado inclui a parte fracionária.
    float divisao_float = c / d;
    printf("   Divisão de Floats:   %.1f / %.1f = %.2f\n\n", c, d, divisao_float);

    // --- Módulo (%) ---
    // Retorna o resto da divisão de inteiros.
    // Não funciona com tipos float ou double.
    int modulo = a % b;
    printf("5. Módulo (Resto da Divisão):\n");
    printf("   O resto da divisão de %d por %d é %d\n\n", a, b, modulo);

    // --- Incremento (++) ---
    // Aumenta o valor de uma variável em 1.
    int x = 5;
    printf("6. Incremento:\n");
    printf("   Valor original de x: %d\n", x);
    x++; // O mesmo que x = x + 1;
    printf("   Valor de x após o incremento (x++): %d\n\n", x);

    // --- Decremento (--) ---
    // Diminui o valor de uma variável em 1.
    int y = 5;
    printf("7. Decremento:\n");
    printf("   Valor original de y: %d\n", y);
    y--; // O mesmo que y = y - 1;
    printf("   Valor de y após o decremento (y--): %d\n\n", y);
    
    // --- Precedência de Operadores ---
    // A ordem em que as operações são executadas.
    // 1º: *, /, %
    // 2º: +, -
    // Parênteses () podem ser usados para forçar uma ordem específica.
    int resultado_precedencia = a + b * 2; // Primeiro b * 2, depois a + resultado
    int resultado_com_parenteses = (a + b) * 2; // Primeiro a + b, depois resultado * 2
    printf("8. Precedência de Operadores:\n");
    printf("   %d + %d * 2 = %d\n", a, b, resultado_precedencia);
    printf("   (%d + %d) * 2 = %d\n\n", a, b, resultado_com_parenteses);


    return EXIT_SUCCESS; // Indica que o programa terminou com sucesso.
}
