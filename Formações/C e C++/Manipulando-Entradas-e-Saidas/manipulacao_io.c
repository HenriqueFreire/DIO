#include <stdio.h>  // Para funções de I/O padrão (printf, scanf, puts, gets, fopen, fclose, etc.)
#include <stdlib.h> // Para EXIT_SUCCESS, EXIT_FAILURE
#include <string.h> // Para funções de string como strcspn (útil com fgets)

// Função para limpar o buffer de entrada, essencial após scanf para evitar problemas com leituras subsequentes.
void limparBufferEntrada() {
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
}

int main() {
    printf("--- Demonstração de Manipulação de Entradas e Saídas em C ---\n\n");

    // --- 1. Entrada de Dados (Input) ---

    // 1.1. Lendo um Inteiro
    int numero_inteiro;
    printf("1.1. Digite um número inteiro: ");
    if (scanf("%d", &numero_inteiro) == 1) {
        printf("   Você digitou: %d\n", numero_inteiro);
    } else {
        printf("   Erro: Entrada inválida para número inteiro.\n");
        limparBufferEntrada(); // Limpa o buffer em caso de erro
    }
    limparBufferEntrada(); // Sempre limpa o buffer após scanf para evitar problemas

    // 1.2. Lendo um Número de Ponto Flutuante (Float/Double)
    double numero_decimal;
    printf("\n1.2. Digite um número decimal: ");
    if (scanf("%lf", &numero_decimal) == 1) { // %lf para double
        printf("   Você digitou: %.2f\n", numero_decimal);
    } else {
        printf("   Erro: Entrada inválida para número decimal.\n");
        limparBufferEntrada();
    }
    limparBufferEntrada();

    // 1.3. Lendo um Caractere
    char caractere_unico;
    printf("\n1.3. Digite um único caractere: ");
    // O espaço antes de %c ignora qualquer whitespace pendente (como o \n do enter anterior)
    if (scanf(" %c", &caractere_unico) == 1) {
        printf("   Você digitou: '%c'\n", caractere_unico);
    } else {
        printf("   Erro: Entrada inválida para caractere.\n");
        limparBufferEntrada();
    }
    limparBufferEntrada();

    // 1.4. Lendo uma Palavra (String sem espaços)
    char palavra[50];
    printf("\n1.4. Digite uma palavra (sem espaços): ");
    if (scanf("%s", palavra) == 1) {
        printf("   Você digitou: \"%s\"\n", palavra);
    } else {
        printf("   Erro: Entrada inválida para palavra.\n");
        limparBufferEntrada();
    }
    limparBufferEntrada();

    // 1.5. Lendo uma Linha Completa (com espaços) usando scanf("%[^\n]")
    char linha_scanf[100];
    printf("\n1.5. Digite uma frase (com scanf(\"%%[^\\n]\")): ");
    // %[^\n] lê tudo até a quebra de linha, mas não consome a quebra de linha.
    // É importante limpar o buffer antes de usá-lo se houver um \n pendente.
    if (scanf("%[^\n]", linha_scanf) == 1) {
        printf("   Você digitou: \"%s\"\n", linha_scanf);
    } else {
        printf("   Erro: Entrada inválida para frase (scanf).\n");
    }
    limparBufferEntrada(); // Consome o \n deixado pelo scanf("%[^\n]")

    // 1.6. Lendo uma Linha Completa (com espaços) usando fgets
    char linha_fgets[100];
    printf("\n1.6. Digite outra frase (com fgets): ");
    // fgets lê até n-1 caracteres ou até a quebra de linha, incluindo a quebra de linha se couber.
    // É mais seguro que gets() pois evita buffer overflow.
    if (fgets(linha_fgets, sizeof(linha_fgets), stdin) != NULL) {
        // fgets inclui o '\n' se houver espaço. Podemos removê-lo para uma saída mais limpa.
        linha_fgets[strcspn(linha_fgets, "\n")] = 0; 
        printf("   Você digitou: \"%s\"\n", linha_fgets);
    } else {
        printf("   Erro: Falha na leitura da frase (fgets).\n");
    }


    // --- 2. Saída de Dados (Output) ---

    printf("\n--- 2. Saída de Dados (Output) ---\n");

    // 2.1. Imprimindo Variáveis com printf
    printf("2.1. Imprimindo variáveis:\n");
    printf("   Inteiro: %d\n", numero_inteiro);
    printf("   Decimal: %.3f\n", numero_decimal); // .3f para 3 casas decimais
    printf("   Caractere: '%c'\n", caractere_unico);
    printf("   Palavra: \"%s\"\n", palavra);

    // 2.2. Saída Formatada com printf
    printf("\n2.2. Saída Formatada:\n");
    printf("   Número inteiro com largura 5, preenchido com zeros: %05d\n", 42);
    printf("   Número decimal com 1 casa decimal e alinhado à direita em 10 espaços: %10.1f\n", 123.456);
    printf("   String alinhada à esquerda em 15 espaços: \"%-15s\"\n", "C Lang");

    // 2.3. Usando puts() para Strings
    printf("\n2.3. Usando puts() para Strings:\n");
    puts("   puts() imprime uma string e adiciona uma nova linha automaticamente.");
    puts("   É mais simples que printf(\"%s\\n\", ...); para strings.");


    // --- 3. Manipulação de Arquivos (File I/O) ---

    printf("\n--- 3. Manipulação de Arquivos ---\n");

    FILE *arquivo;
    const char *nome_arquivo = "exemplo.txt";

    // 3.1. Escrevendo em um Arquivo
    // "w" abre o arquivo para escrita (cria se não existe, sobrescreve se existe)
    arquivo = fopen(nome_arquivo, "w");
    if (arquivo == NULL) {
        perror("Erro ao abrir arquivo para escrita"); // Imprime erro do sistema
        return EXIT_FAILURE;
    }
    fprintf(arquivo, "Esta é a primeira linha.\n");
    fprintf(arquivo, "Este é um número: %d\n", 123);
    fclose(arquivo); // Sempre fechar o arquivo após o uso
    printf("3.1. Dados escritos em '%s'.\n", nome_arquivo);

    // 3.2. Lendo de um Arquivo
    // "r" abre o arquivo para leitura
    arquivo = fopen(nome_arquivo, "r");
    if (arquivo == NULL) {
        perror("Erro ao abrir arquivo para leitura");
        return EXIT_FAILURE;
    }
    char linha_lida[100];
    int num_lido;

    printf("\n3.2. Lendo de '%s':\n", nome_arquivo);
    // Lê a primeira linha como string
    if (fgets(linha_lida, sizeof(linha_lida), arquivo) != NULL) {
        printf("   Linha 1: %s", linha_lida); // fgets mantém o \n
    }
    // Lê a segunda linha, esperando uma string e um inteiro
    // Note que fscanf pode deixar o \n no buffer, mas como estamos fechando o arquivo, não é um problema aqui.
    if (fscanf(arquivo, "Este é um número: %d", &num_lido) == 1) {
        printf("   Número lido da linha 2: %d\n", num_lido);
    } else {
        printf("   Erro ao ler número do arquivo.\n");
    }
    fclose(arquivo);
    printf("3.2. Leitura de '%s' concluída.\n", nome_arquivo);

    printf("\n--- Fim da Demonstração ---\n");

    return EXIT_SUCCESS;
}