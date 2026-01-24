#include <stdio.h> // Para funções de entrada/saída como printf

// --- Exemplo de Função para Manipular Array: Imprimir Elementos ---
// Esta função recebe um array de inteiros e seu tamanho, e imprime todos os seus elementos.
// Boas práticas:
// - 'const int arr[]': Indica que a função não modificará o conteúdo do array original.
// - 'int tamanho': É essencial passar o tamanho do array, pois C não o faz automaticamente.
void imprimirArray(const int arr[], int tamanho) {
    printf("Elementos do array: [");
    for (int i = 0; i < tamanho; i++) {
        printf("%d", arr[i]);
        if (i < tamanho - 1) {
            printf(", "); // Adiciona vírgula e espaço entre os elementos
        }
    }
    printf("]\n");
}

// --- Exemplo de Função para Manipular Array: Encontrar o Maior Elemento ---
// Esta função encontra e retorna o maior elemento em um array de inteiros.
// Boas práticas:
// - Tratamento de caso de array vazio ou inválido.
int encontrarMaiorElemento(const int arr[], int tamanho) {
    // --- Tratamento de Erros ---
    // Verifica se o array não está vazio para evitar acesso inválido de memória.
    if (tamanho <= 0) {
        printf("Erro: Array vazio ou tamanho inválido.\n");
        return -1; // Retorna um valor que indica erro (ou lança uma exceção em linguagens mais modernas)
    }

    int maior = arr[0]; // Assume que o primeiro elemento é o maior inicialmente

    // Percorre o array a partir do segundo elemento
    for (int i = 1; i < tamanho; i++) {
        if (arr[i] > maior) {
            maior = arr[i]; // Atualiza o maior se encontrar um elemento maior
        }
    }
    return maior; // Retorna o maior elemento encontrado
}

int main() {
    // --- Exemplo de Declaração e Inicialização de um Array ---
    // Um array de inteiros chamado 'meuArray' com 5 elementos.
    // Os valores são inicializados diretamente.
    int meuArray[] = {10, 5, 20, 15, 30};
    
    // Calcula o tamanho do array. Isso é feito dividindo o tamanho total do array
    // (em bytes) pelo tamanho de um único elemento (em bytes).
    int tamanho = sizeof(meuArray) / sizeof(meuArray[0]);

    printf("--- Demonstração de Manipulação de Arrays em C ---\n");

    // Chama a função para imprimir os elementos do array
    imprimirArray(meuArray, tamanho);

    // Chama a função para encontrar o maior elemento e armazena o resultado
    int maior_valor = encontrarMaiorElemento(meuArray, tamanho);

    // Imprime o maior valor encontrado, se a função não retornou um erro
    if (maior_valor != -1) { // Verifica se não houve erro na função
        printf("O maior elemento no array é: %d\n", maior_valor);
    }

    // Exemplo com um array vazio para demonstrar o tratamento de erro
    int arrayVazio[] = {};
    // Para arrays vazios inicializados assim, sizeof(arrayVazio) pode ser 0 ou um valor pequeno dependendo do compilador.
    // É mais seguro verificar o tamanho antes de usar sizeof(arrayVazio[0]) se o array puder ser realmente vazio.
    // Neste caso, para um array vazio, sizeof(arrayVazio) será 0, e a divisão por sizeof(int) (que é > 0) resultará em 0.
    int tamanhoVazio = sizeof(arrayVazio) / sizeof(int); 
    printf("\n--- Teste com Array Vazio ---\n");
    imprimirArray(arrayVazio, tamanhoVazio); // Imprimirá "[]"
    encontrarMaiorElemento(arrayVazio, tamanhoVazio); // Irá imprimir a mensagem de erro

    return 0; // Indica que o programa foi executado com sucesso
}
