# Aplicações de Ponteiros e Endereços de Memória em C

Este projeto oferece um exemplo didático abrangente sobre o uso de ponteiros e a manipulação de endereços de memória na linguagem C. Ponteiros são um conceito fundamental em C, permitindo um controle de baixo nível sobre a memória e a criação de estruturas de dados complexas.

## Conteúdo do Projeto:

*   `ponteiros_memoria.c`: Contém o código-fonte com diversos exemplos de ponteiros.
*   `README.md`: Este arquivo, explicando os conceitos.

## Conceitos Demonstrados:

### 1. Endereços de Memória (`&` - Operador "Address-of")

*   Cada variável em C é armazenada em um local específico na memória RAM.
*   O operador `&` (e comercial) é usado para obter o endereço de memória de uma variável.
*   Endereços são geralmente exibidos em formato hexadecimal (ex: `0x7ffeefbff5c4`).

### 2. Declaração e Inicialização de Ponteiros

*   Um ponteiro é uma variável que armazena um endereço de memória de outra variável.
*   Sintaxe: `tipo_da_variavel *nome_do_ponteiro;`
*   Exemplo: `int *ptr_idade;` (declara um ponteiro que pode armazenar o endereço de uma variável `int`).
*   Para inicializar um ponteiro, atribua a ele o endereço de uma variável: `ptr_idade = &idade;`

### 3. Desreferenciação (`*` - Operador "Dereference")

*   O operador `*` (asterisco) é usado para acessar o *valor* armazenado no endereço para o qual o ponteiro aponta.
*   Exemplo: `printf("%d", *ptr_idade);` (imprime o valor da variável `idade` através do ponteiro `ptr_idade`).
*   Você pode modificar o valor da variável apontada usando o operador de desreferenciação: `*ptr_idade = 31;`

### 4. Ponteiros e Arrays

*   Em C, o nome de um array (sem colchetes) pode ser tratado como um ponteiro para o seu primeiro elemento.
*   Exemplo: `int numeros[] = {10, 20}; int *ptr_numeros = numeros;`
*   `*numeros` é equivalente a `numeros[0]`.

### 5. Aritmática de Ponteiros

*   Ponteiros podem ser incrementados (`++`) ou decrementados (`--`).
*   Quando um ponteiro é incrementado, ele avança para o próximo elemento do *tipo de dado* que ele aponta, não apenas para o próximo byte.
*   Exemplo: Se `ptr` aponta para um `int`, `ptr++` move `ptr` para o endereço do próximo `int` na memória.
*   Você também pode somar ou subtrair inteiros de ponteiros (ex: `*(ptr + 2)` para acessar o terceiro elemento).

### 6. Ponteiros como Parâmetros de Função (Passagem por Referência)

*   Para que uma função modifique o valor de uma variável na função chamadora, você deve passar o *endereço* da variável (um ponteiro) para a função.
*   A função então desreferencia o ponteiro para acessar e modificar o valor original.
*   Exemplo: `void dobrarValor(int *ptr_numero);` e na chamada `dobrarValor(&minha_variavel);`

### 7. Alocação Dinâmica de Memória (`malloc` e `free`)

*   `malloc()`: Aloca um bloco de memória no *heap* (memória dinâmica) em tempo de execução e retorna um ponteiro para o início desse bloco.
*   `free()`: Libera a memória alocada por `malloc` (ou `calloc`, `realloc`), evitando vazamentos de memória.
*   **Boas Práticas:**
    *   Sempre verificar se `malloc` retornou `NULL` (indicando falha na alocação).
    *   Sempre chamar `free()` para cada `malloc()` correspondente.
    *   Após `free()`, é uma boa prática definir o ponteiro para `NULL` para evitar "ponteiros pendurados" (dangling pointers).

### 8. Ponteiros Nulos (`NULL`)

*   Um ponteiro `NULL` é um ponteiro que não aponta para nenhum local de memória válido.
*   É uma boa prática inicializar ponteiros com `NULL` se eles não apontarem para nada no momento da declaração.
*   Sempre verificar se um ponteiro não é `NULL` antes de tentar desreferenciá-lo para evitar erros de segmentação (segmentation faults).

## Como Compilar e Executar:

1.  **Navegue até a pasta:**
    ```bash
    cd Aplicacoes-de-Ponteiros-e-Enderecos-de-Memoria
    ```
2.  **Compile o código:**
    ```bash
    gcc ponteiros_memoria.c -o ponteiros_memoria
    ```
3.  **Execute o programa:**
    ```bash
    ./ponteiros_memoria
    ```

O programa imprimirá os valores e endereços de memória de várias variáveis, demonstrando as operações com ponteiros.
