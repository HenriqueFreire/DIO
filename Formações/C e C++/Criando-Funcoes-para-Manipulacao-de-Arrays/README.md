# Criando Funções para Manipulação de Arrays em C

Este projeto demonstra como declarar e inicializar arrays em C, e como criar funções para manipulá-los, seguindo boas práticas de programação.

## Conteúdo do Projeto:

*   `manipulacao_arrays.c`: Contém o código-fonte com exemplos de arrays e funções.
*   `README.md`: Este arquivo, explicando o projeto.

## Conceitos Demonstrados:

### 1. Declaração e Inicialização de Arrays

Em C, um array é uma coleção de elementos do mesmo tipo armazenados em locais de memória contíguos.

```c
int meuArray[] = {10, 5, 20, 15, 30}; // Declara e inicializa um array de inteiros
int tamanho = sizeof(meuArray) / sizeof(meuArray[0]); // Calcula o número de elementos
```

### 2. Passando Arrays para Funções

Ao passar um array para uma função em C, você deve sempre passar também o seu tamanho. Isso ocorre porque o array "decai" para um ponteiro para seu primeiro elemento quando passado como argumento, e a função não tem como saber seu tamanho original.

```c
// Exemplo de assinatura de função que recebe um array e seu tamanho
void imprimirArray(const int arr[], int tamanho);
```

*   `const int arr[]`: O uso de `const` indica que a função não irá modificar os elementos do array, o que é uma boa prática para garantir a integridade dos dados.
*   `int tamanho`: Essencial para que a função saiba quantos elementos processar.

### 3. Função de Exemplo: `imprimirArray`

Esta função itera sobre os elementos do array e os imprime no console, formatando a saída para ser legível.

### 4. Função de Exemplo: `encontrarMaiorElemento`

Esta função percorre o array para identificar e retornar o maior valor presente. Ela também inclui um tratamento básico de erro para o caso de receber um array vazio ou com tamanho inválido.

## Como Compilar e Executar:

1.  **Navegue até a pasta:**
    ```bash
    cd Criando-Funcoes-para-Manipulacao-de-Arrays
    ```
2.  **Compile o código:**
    ```bash
    gcc manipulacao_arrays.c -o manipulacao_arrays
    ```
3.  **Execute o programa:**
    ```bash
    ./manipulacao_arrays
    ```

O programa irá imprimir os elementos do array de exemplo e o maior valor encontrado, além de demonstrar o tratamento de erro para um array vazio.
