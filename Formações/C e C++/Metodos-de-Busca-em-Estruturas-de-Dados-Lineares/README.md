# Exemplo Didático: Busca Linear em Lista Circular em C++

Este projeto demonstra o conceito de **busca linear** aplicada a uma estrutura de dados do tipo **lista circular** em C++. Uma lista circular é uma variação da lista encadeada onde o último nó aponta de volta para o primeiro nó, formando um ciclo.

## Conteúdo do Projeto:

*   `busca_linear_lista_circular.cpp`: Contém o código-fonte com o exemplo.
*   `README.md`: Este arquivo, explicando os conceitos.

## Conceitos Demonstrados:

### 1. Lista Circular

*   **O que é:** Uma lista encadeada onde o ponteiro `next` do último nó aponta para o primeiro nó da lista, em vez de `NULL`. Isso permite percorrer a lista indefinidamente a partir de qualquer ponto, a menos que um ponto de parada seja definido.
*   **Vantagens:** Útil para implementações de buffers circulares, agendamento de tarefas (round-robin) ou quando se deseja um loop contínuo sobre os elementos.
*   **Implementação no Exemplo:**
    *   **`Node`:** Uma estrutura simples que representa um elemento da lista, contendo um `int data` e um ponteiro `Node* next` para o próximo nó.
    *   **`ListaCircular`:** Uma classe que gerencia a lista, com métodos para adicionar nós (`addNode`), imprimir a lista (`printList`) e um destrutor (`~ListaCircular`) para liberar a memória alocada dinamicamente.

### 2. Busca Linear (Sequential Search)

*   **O que é:** O algoritmo de busca mais simples, que verifica cada elemento de uma coleção, um por um, em sequência, até que o elemento desejado seja encontrado ou até que todos os elementos tenham sido verificados.
*   **Complexidade:** Em média, a busca linear tem uma complexidade de tempo de O(n), onde 'n' é o número de elementos na coleção.
*   **Aplicação em Listas Circulares:** Para buscar um elemento em uma lista circular, você começa a partir de um nó (geralmente o `head`) e percorre a lista. A condição de parada é crucial: você deve parar quando encontrar o elemento ou quando o ponteiro de travessia retornar ao nó inicial, indicando que a lista inteira foi percorrida sem sucesso.

### 3. Demonstração no Código (`buscaLinearListaCircular`):

*   A função `buscaLinearListaCircular` recebe uma referência constante (`const ListaCircular&`) para a lista e o `valorBuscado`.
*   Ela inicia a travessia a partir do `head` da lista.
*   Usa um loop `do-while` para garantir que o primeiro elemento seja verificado antes da condição de parada (retornar ao `head`).
*   Para cada nó, compara `current->data` com `valorBuscado`.
*   Se encontrar, imprime a posição e retorna `true`.
*   Se o loop `do-while` terminar (ou seja, `current` voltou ao `head` sem encontrar o valor), imprime que o valor não foi encontrado e retorna `false`.
*   **Importante:** A função de busca não modifica a lista original.

## Como Compilar e Executar:

1.  **Navegue até a pasta:**
    ```bash
    cd Metodos-de-Busca-em-Estruturas-de-Dados-Lineares
    ```
2.  **Compile o código:**
    ```bash
    g++ busca_linear_lista_circular.cpp -o busca_linear_lista_circular
    ```
    (Use `g++` para compilar código C++).
3.  **Execute o programa:**
    ```bash
    ./busca_linear_lista_circular
    ```

O programa irá criar uma lista circular, adicionar elementos, e então demonstrar a busca linear por valores existentes e não existentes, imprimindo o processo de verificação.
