#include <stdio.h>

int main() {
    // Exemplo de loop: for
    // O loop 'for' é ideal para quando você sabe o número de iterações.
    printf("Exemplo de loop for (contagem de 1 a 5):\n");
    for (int i = 1; i <= 5; i++) {
        printf("%d ", i);
    }
    printf("\n\n");

    // Exemplo de loop: while
    // O loop 'while' executa enquanto uma condição for verdadeira.
    printf("Exemplo de loop while (contagem de 1 a 5):\n");
    int j = 1;
    while (j <= 5) {
        printf("%d ", j);
        j++;
    }
    printf("\n\n");

    // Exemplo de loop: do-while
    // O loop 'do-while' é semelhante ao 'while', mas garante que o bloco de código
    // seja executado pelo menos uma vez.
    printf("Exemplo de loop do-while (contagem de 1 a 5):\n");
    int k = 1;
    do {
        printf("%d ", k);
        k++;
    } while (k <= 5);
    printf("\n");

    return 0;
}
