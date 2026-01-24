# Exemplo Didático: Algoritmo de Busca em Árvores (Conceitualmente Balanceadas) em C++

Este projeto demonstra o **algoritmo de busca** em uma Árvore Binária de Busca (BST), que é a base para a busca eficiente em árvores balanceadas. Embora esta implementação não inclua a lógica de balanceamento automático (como em árvores AVL ou Red-Black), o *algoritmo de busca* é idêntico e se beneficia da estrutura ordenada da árvore. A principal vantagem de uma árvore balanceada é garantir que a busca mantenha uma complexidade de tempo logarítmica (O(log N)) mesmo no pior caso.

## Conteúdo do Projeto:

*   `busca_arvore_balanceada.cpp`: Contém o código-fonte com a implementação da BST e o algoritmo de busca.
*   `README.md`: Este arquivo, explicando os conceitos.

## Conceitos Demonstrados:

### 1. Árvore Binária de Busca (BST)

*   **O que é:** Uma estrutura de dados hierárquica onde cada nó tem no máximo dois filhos (esquerdo e direito). A propriedade fundamental da BST é que, para qualquer nó:
    *   Todos os valores na sua subárvore esquerda são **menores** que o valor do nó.
    *   Todos os valores na sua subárvore direita são **maiores** que o valor do nó.
*   **Árvores Balanceadas:** São BSTs que, através de operações adicionais (como rotações) durante a inserção e remoção, garantem que a altura da árvore permaneça logarítmica em relação ao número de nós. Isso evita que a árvore se degrade para uma lista encadeada no pior caso, mantendo a eficiência O(log N) para todas as operações.

### 2. Nó (Node)

*   **Exemplo (`struct Node`):** Cada elemento na árvore é um nó. Ele contém:
    *   `int data`: O valor armazenado no nó.
    *   `Node* left`: Um ponteiro para o filho esquerdo do nó.
    *   `Node* right`: Um ponteiro para o filho direito do nó.

### 3. Algoritmo de Busca (`search` e `_search`)

*   **Como funciona:** O algoritmo de busca em uma BST (balanceada ou não) é recursivo e muito eficiente:
    1.  Começa na raiz da árvore.
    2.  Compara o valor buscado com o valor do nó atual:
        *   Se forem iguais, o elemento foi encontrado.
        *   Se o valor buscado for **menor**, a busca continua na subárvore esquerda.
        *   Se o valor buscado for **maior**, a busca continua na subárvore direita.
    3.  O processo se repete até que o elemento seja encontrado ou até que um nó `nullptr` (indicando que o elemento não está na árvore) seja alcançado.
*   **Complexidade de Tempo:**
    *   Em uma BST **balanceada**, a altura da árvore é O(log N), então a busca leva O(log N) tempo no pior caso.
    *   Em uma BST **não balanceada**, a altura pode ser O(N) no pior caso (se os elementos forem inseridos em ordem crescente ou decrescente), degradando a busca para O(N).
*   **Implementação no Exemplo:** A função `_search` demonstra este algoritmo recursivo, imprimindo o caminho percorrido para fins didáticos.

### 4. Inserção (`insert` e `_insert`)

*   O algoritmo de inserção segue uma lógica similar à da busca para encontrar o local correto onde o novo nó deve ser adicionado.
*   Neste exemplo, a lógica de balanceamento *não* está implementada na inserção, mas a estrutura da BST é mantida.

### 5. Travessia In-order (`printInOrder` e `_inorder`)

*   Uma travessia In-order visita os nós na ordem: subárvore esquerda -> nó raiz -> subárvore direita.
*   **Característica:** Para uma BST, uma travessia In-order sempre produz os elementos em ordem **crescente**.

### 6. Gerenciamento de Memória

*   A BST aloca nós dinamicamente (`new Node(...)`).
*   O destrutor (`~BalancedTreeSearch()`) utiliza uma função auxiliar (`_deleteTree`) para liberar recursivamente todos os nós alocados, prevenindo vazamentos de memória.

## Como Compilar e Executar:

1.  **Navegue até a pasta:**
    ```bash
    cd Desenvolvimento-de-um-Algoritmo-Para-Busca-em-Arvores-Balanceadas
    ```
2.  **Compile o código:**
    ```bash
    g++ busca_arvore_balanceada.cpp -o busca_arvore_balanceada
    ```
    (Use `g++` para compilar código C++).
3.  **Execute o programa:**
    ```bash
    ./busca_arvore_balanceada
    ```

O programa irá construir uma BST, inserir vários números, demonstrar o algoritmo de busca passo a passo e imprimir o conteúdo da árvore.
