# include <stdio.h>

int main(){
    int int1, int2,soma; /* Declaração de variáveis */

    printf("Entre com o primeiro número: /n"); /* Prompt */
    scanf("%d", &int1); /* Lê um número inteiro */

    printf("Entre com o outro número: /n"); /* Prompt */
    scanf("%d", &int2); /* Lê um número inteiro */

    soma = int1 + int2; /* Atribui soma */

    printf("A soma é igual a %d/n", "soma"); /* Imprime a soma */

    return 0; /* Informa que o programa foi bem sucedido */
}