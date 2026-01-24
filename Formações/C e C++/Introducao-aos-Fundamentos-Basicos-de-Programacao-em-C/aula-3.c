#include <stdio.h>

int main() {
    // Exemplo de estrutura de controle: if-else
    int numero = 10;

    printf("Verificando o número %d...\n", numero);

    if (numero > 0) {
        printf("O número é positivo.\n");
    } else if (numero < 0) {
        printf("O número é negativo.\n");
    } else {
        printf("O número é zero.\n");
    }

    // Exemplo de estrutura de controle: loop for
    printf("\nIniciando contagem regressiva:\n");
    for (int i = 5; i > 0; i--) {
        printf("%d\n", i);
    }
    printf("Fogo!\n");

    // Exemplo de estrutura de controle: switch-case
    printf("\nExemplo de switch-case com a opção 2:\n");
    int opcao = 2;

    switch (opcao) {
        case 1:
            printf("Você escolheu a Opção 1.\n");
            break;
        case 2:
            printf("Você escolheu a Opção 2.\n");
            break;
        case 3:
            printf("Você escolheu a Opção 3.\n");
            break;
        default:
            printf("Opção inválida.\n");
            break;
    }

    return 0;
}
