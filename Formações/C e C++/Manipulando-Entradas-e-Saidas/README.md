# Manipulando Entradas e Saídas em C

Este projeto demonstra diversas formas de manipular entradas (input) e saídas (output) na linguagem C, cobrindo desde a leitura e escrita de dados básicos no console até operações com arquivos.

## Conteúdo do Projeto:

*   `manipulacao_io.c`: Contém o código-fonte com exemplos de manipulação de I/O.
*   `README.md`: Este arquivo, explicando os conceitos.

## Conceitos Demonstrados:

### 1. Entrada de Dados (Input)

*   **`scanf()`:** Função versátil para ler dados formatados do teclado.
    *   `%d`: Para inteiros.
    *   `%lf`: Para números de ponto flutuante (`double`).
    *   `%c`: Para um único caractere (usar ` %c` com um espaço antes para ignorar whitespaces pendentes).
    *   `%s`: Para ler uma única palavra (string sem espaços).
    *   `%[^
]`: Para ler uma linha inteira, incluindo espaços, até a quebra de linha (não consome o `
`).
*   **`fgets()`:** Função mais segura para ler linhas inteiras de texto, pois permite especificar o tamanho máximo do buffer, prevenindo *buffer overflows*. Inclui o `
` se houver espaço.
*   **Limpeza do Buffer de Entrada:** Após usar `scanf()` (especialmente para `%d`, `%f`, `%c` ou `%s`), é crucial limpar o buffer de entrada (`while (getchar() != '\n' && c != EOF);`) para remover o `
` deixado pelo Enter, evitando que ele seja lido por uma `scanf()` ou `fgets()` subsequente.

### 2. Saída de Dados (Output)

*   **`printf()`:** Função principal para imprimir dados formatados no console.
    *   **Especificadores de Formato:** `%d` (int), `%f` (float/double), `%c` (char), `%s` (string).
    *   **Formatação Avançada:**
        *   `%05d`: Imprime um inteiro com 5 dígitos, preenchendo com zeros à esquerda.
        *   `%10.2f`: Imprime um float/double com 2 casas decimais, alinhado à direita em um campo de 10 caracteres.
        *   `%-15s`: Imprime uma string alinhada à esquerda em um campo de 15 caracteres.
*   **`puts()`:** Função simples para imprimir uma string seguida automaticamente por uma quebra de linha. É mais eficiente que `printf("%s\n", ...)` para strings literais.

### 3. Manipulação de Arquivos (File I/O)

*   **`FILE *fopen(const char *filename, const char *mode);`:** Abre um arquivo.
    *   `filename`: Nome do arquivo.
    *   `mode`: Modo de abertura (ex: `"w"` para escrita, `"r"` para leitura, `"a"` para anexar).
    *   Retorna um ponteiro para `FILE` ou `NULL` em caso de erro.
*   **`int fprintf(FILE *stream, const char *format, ...);`:** Escreve dados formatados em um arquivo.
*   **`int fscanf(FILE *stream, const char *format, ...);`:** Lê dados formatados de um arquivo.
*   **`char *fgets(char *str, int n, FILE *stream);`:** Lê uma linha de texto de um arquivo.
*   **`int fclose(FILE *stream);`:** Fecha um arquivo, liberando os recursos.
*   **Tratamento de Erros:** Sempre verificar se `fopen` retornou `NULL` e usar `perror()` para imprimir mensagens de erro do sistema.

## Como Compilar e Executar:

1.  **Navegue até a pasta:**
    ```bash
    cd Manipulando-Entradas-e-Saidas
    ```
2.  **Compile o código:**
    ```bash
    gcc manipulacao_io.c -o manipulacao_io
    ```
3.  **Execute o programa:**
    ```bash
    ./manipulacao_io
    ```

O programa irá interagir com você, solicitando diferentes tipos de entrada e demonstrando as saídas formatadas, além de criar e ler de um arquivo `exemplo.txt` no mesmo diretório.
