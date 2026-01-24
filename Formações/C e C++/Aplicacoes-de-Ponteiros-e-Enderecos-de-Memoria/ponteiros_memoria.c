#include <stdio.h>  // Para printf
#include <stdlib.h> // Para malloc, free, EXIT_SUCCESS, EXIT_FAILURE

// --- 1. Exemplo: Ponteiros como Parâmetros de Função (Passagem por Referência) ---
// Esta função usa um ponteiro para modificar o valor de uma variável na função chamadora.
void dobrarValor(int *ptr_numero) {
    // Verifica se o ponteiro não é NULL antes de desreferenciar (boa prática).
    if (ptr_numero != NULL) {
        *ptr_numero = *ptr_numero * 2; // Desreferencia o ponteiro para acessar e modificar o valor
        printf("  Dentro da funcao 'dobrarValor': Valor modificado para %d\n", *ptr_numero);
    } else {
        printf("  Erro: Ponteiro NULL passado para 'dobrarValor'.\n");
    }
}

int main() {
    printf("--- Demonstração de Ponteiros e Endereços de Memória em C ---\n\n");

    // --- 2. Declaração de Variáveis e Obtenção de Endereços ---
    int idade = 30;
    double salario = 5000.50;
    char letra = 'A';

    printf("Variável 'idade':\n");
    printf("  Valor: %d\n", idade);
    printf("  Endereço de memória: %p\n", (void*)&idade); // %p para imprimir endereços

    printf("\nVariável 'salario':\n");
    printf("  Valor: %.2f\n", salario);
    printf("  Endereço de memória: %p\n", (void*)&salario);

    printf("\nVariável 'letra':\n");
    printf("  Valor: %c\n", letra);
    printf("  Endereço de memória: %p\n", (void*)&letra);

    // --- 3. Declaração e Inicialização de Ponteiros ---
    int *ptr_idade; // Declara um ponteiro para um inteiro
    ptr_idade = &idade; // Atribui o endereço da variável 'idade' ao ponteiro

    double *ptr_salario = &salario; // Declara e inicializa na mesma linha
    char *ptr_letra = &letra;

    printf("\n--- Usando Ponteiros ---\n");
    printf("Ponteiro 'ptr_idade':\n");
    printf("  Armazena o endereço: %p\n", (void*)ptr_idade);
    printf("  Valor apontado (*ptr_idade): %d\n", *ptr_idade); // Desreferenciação

    printf("\nPonteiro 'ptr_salario':\n");
    printf("  Armazena o endereço: %p\n", (void*)ptr_salario);
    printf("  Valor apontado (*ptr_salario): %.2f\n", *ptr_salario);

    printf("\nPonteiro 'ptr_letra':\n");
    printf("  Armazena o endereço: %p\n", (void*)ptr_letra);
    printf("  Valor apontado (*ptr_letra): %c\n", *ptr_letra);

    // --- 4. Modificando Valores Através de Ponteiros ---
    printf("\n--- Modificando Valores via Ponteiro ---\n");
    printf("Valor original de 'idade': %d\n", idade);
    *ptr_idade = 31; // Modifica 'idade' através de 'ptr_idade'
    printf("Novo valor de 'idade' (via *ptr_idade): %d\n", idade);

    // --- 5. Ponteiros e Arrays ---
    int numeros[] = {10, 20, 30, 40, 50};
    int tamanho_array = sizeof(numeros) / sizeof(numeros[0]);

    printf("\n--- Ponteiros e Arrays ---\n");
    printf("Array 'numeros':\n");
    printf("  Endereço do primeiro elemento (numeros): %p\n", (void*)numeros);
    printf("  Endereço do primeiro elemento (&numeros[0]): %p\n", (void*)&numeros[0]);
    printf("  Valor do primeiro elemento (*numeros): %d\n", *numeros); // numeros é um ponteiro para o primeiro elemento

    // --- 6. Aritmética de Ponteiros ---
    int *ptr_array = numeros; // ptr_array aponta para o início do array
    printf("\n--- Aritmética de Ponteiros ---\n");
    printf("  ptr_array aponta para %d (endereço %p)\n", *ptr_array, (void*)ptr_array);
    ptr_array++; // Move o ponteiro para o próximo inteiro (20)
    printf("  ptr_array++ aponta para %d (endereço %p)\n", *ptr_array, (void*)ptr_array);
    printf("  Acessando o terceiro elemento (ptr_array + 1): %d\n", *(ptr_array + 1)); // Acessa o 30

    // --- 7. Passagem por Referência com Função ---
    printf("\n--- Passagem por Referência com Função ---\n");
    int meu_valor = 10;
    printf("Valor antes da função: %d\n", meu_valor);
    dobrarValor(&meu_valor); // Passa o endereço de 'meu_valor'
    printf("Valor depois da função: %d\n", meu_valor);

    // --- 8. Alocação Dinâmica de Memória (malloc/free) ---
    printf("\n--- Alocação Dinâmica de Memória ---\n");
    int *ptr_dinamico = (int *)malloc(sizeof(int)); 
    
    // --- 9. Boas Práticas: Verificação de NULL após malloc ---
    if (ptr_dinamico == NULL) {
        printf("Erro: Falha na alocação de memória.\n");
        return EXIT_FAILURE;
    }
    
    *ptr_dinamico = 100; // Atribui um valor à memória alocada
    printf("  Valor alocado dinamicamente: %d (endereço %p)\n", *ptr_dinamico, (void*)ptr_dinamico);
    
    // --- 10. Boas Práticas: Liberação de Memória (free) ---
    free(ptr_dinamico); // Libera a memória alocada
    ptr_dinamico = NULL; // Define o ponteiro como NULL após liberar (boa prática)
    printf("  Memória liberada e ponteiro definido para NULL.\n");

    // --- 11. Exemplo de Ponteiro NULL ---
    int *ptr_nulo = NULL;
    printf("\n--- Ponteiro NULL ---\n");
    printf("  Ponteiro nulo: %p\n", (void*)ptr_nulo);
    // Tentar desreferenciar um ponteiro NULL causaria um erro de segmentação!
    // if (ptr_nulo != NULL) { *ptr_nulo = 5; } // Sempre verificar!

    printf("\n--- Fim da Demonstração ---\n");

    return EXIT_SUCCESS; // Indica que o programa foi executado com sucesso
}
