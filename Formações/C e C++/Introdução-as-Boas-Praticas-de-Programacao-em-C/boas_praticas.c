#include <stdio.h>  // Para funções de entrada/saída como printf e scanf
#include <stdlib.h> // Para EXIT_SUCCESS e EXIT_FAILURE
#include <stdbool.h> // Para usar o tipo booleano (true/false)

// --- 1. Boas Práticas: Uso de Constantes ---
// Define valores mínimos e máximos para as dimensões do retângulo.
// Isso torna o código mais fácil de entender e modificar em um único lugar.
#define MIN_DIMENSAO 1.0
#define MAX_DIMENSAO 1000.0

// --- 2. Boas Práticas: Nomes Descritivos para Funções ---
// Função para ler uma dimensão (largura ou comprimento) do usuário.
// Retorna um valor válido ou -1.0 em caso de falha após múltiplas tentativas.
double lerDimensao(const char* nome_dimensao) {
    double valor;
    int tentativas = 0;
    const int MAX_TENTATIVAS = 3; // Limite de tentativas para entrada inválida

    // --- 3. Boas Práticas: Validação de Entrada e Tratamento de Erros ---
    // Loop para garantir que o usuário insira um valor válido.
    while (tentativas < MAX_TENTATIVAS) {
        printf("Digite o %s (entre %.1f e %.1f metros): ", nome_dimensao, MIN_DIMENSAO, MAX_DIMENSAO);
        
        // scanf retorna o número de itens lidos com sucesso.
        // Se não for 1, a entrada não foi um número válido.
        if (scanf("%lf", &valor) == 1) {
            // Valida se o valor está dentro do intervalo permitido.
            if (valor >= MIN_DIMENSAO && valor <= MAX_DIMENSAO) {
                return valor; // Retorna o valor válido
            } else {
                printf("Erro: O %s deve estar entre %.1f e %.1f. Tente novamente.\n", 
                       nome_dimensao, MIN_DIMENSAO, MAX_DIMENSAO);
            }
        } else {
            printf("Erro: Entrada inválida. Por favor, digite um número. Tente novamente.\n");
            // --- 7. Boas Práticas: Limpeza do Buffer de Entrada ---
            // Limpa o buffer de entrada para evitar loops infinitos em caso de entrada não numérica.
            while (getchar() != '\n'); 
        }
        tentativas++;
    }
    printf("Número máximo de tentativas excedido. Encerrando.\n");
    return -1.0; // Indica falha na leitura
}

// --- 4. Boas Práticas: Funções Pequenas e Focadas (Modularidade) ---
// Função para calcular a área de um retângulo.
double calcularArea(double largura, double comprimento) {
    return largura * comprimento;
}

// Função para calcular o perímetro de um retângulo.
double calcularPerimetro(double largura, double comprimento) {
    return 2 * (largura + comprimento);
}

// Função para exibir os resultados formatados.
void exibirResultados(double largura, double comprimento, double area, double perimetro) {
    printf("\n--- Resultados ---\n");
    printf("Largura:    %.2f metros\n", largura);
    printf("Comprimento:%.2f metros\n", comprimento);
    printf("Área:       %.2f metros quadrados\n", area);
    printf("Perímetro:  %.2f metros\n", perimetro);
    printf("------------------\n");
}

// --- 5. Boas Práticas: Função main() Clara e Concisa ---
// A função principal do programa.
int main() {
    double largura, comprimento;
    double area, perimetro;

    // --- 6. Boas Práticas: Tratamento de Erros na main() ---
    // Lê a largura, verificando se a leitura foi bem-sucedida.
    largura = lerDimensao("largura");
    if (largura == -1.0) {
        return EXIT_FAILURE; // Encerra o programa com código de erro
    }

    // Lê o comprimento, verificando se a leitura foi bem-sucedida.
    comprimento = lerDimensao("comprimento");
    if (comprimento == -1.0) {
        return EXIT_FAILURE; // Encerra o programa com código de erro
    }

    // Calcula a área e o perímetro
    area = calcularArea(largura, comprimento);
    perimetro = calcularPerimetro(largura, comprimento);

    // Exibe os resultados
    exibirResultados(largura, comprimento, area, perimetro);

    // --- 8. Boas Práticas: Retorno de main() ---
    return EXIT_SUCCESS; // Encerra o programa com sucesso
}