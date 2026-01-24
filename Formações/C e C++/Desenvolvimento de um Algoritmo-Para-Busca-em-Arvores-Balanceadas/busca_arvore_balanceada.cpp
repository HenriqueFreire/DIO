#include <iostream> // Para entrada/saída (cout)
#include <string>   // Para mensagens
#include <vector>   // Para auxiliar na inserção de elementos

// --- 1. Definição do Nó (Node) da Árvore ---
// Cada nó contém um valor (dado), e ponteiros para seus filhos esquerdo e direito.
struct Node {
    int data;
    Node* left;  // Ponteiro para o filho esquerdo
    Node* right; // Ponteiro para o filho direito

    // Construtor para facilitar a criação de nós
    Node(int val) : data(val), left(nullptr), right(nullptr) {}
};

// --- 2. Implementação da Árvore para Busca (Conceitualmente Balanceada) ---
// Esta classe implementa as operações de inserção e busca de uma Árvore Binária de Busca (BST).
// Para fins didáticos de busca em "árvores balanceadas", o algoritmo de busca é o mesmo
// de uma BST comum. A diferença de uma árvore *realmente* balanceada estaria na lógica
// de inserção/remoção, que realizaria rotações para manter a altura logarítmica.
// Aqui, focamos no ALGORITMO DE BUSCA que se beneficia dessa estrutura.
class BalancedTreeSearch {
private:
    Node* root; // Ponteiro para a raiz da árvore

    // --- Métodos Auxiliares Recursivos ---

    // Inserção recursiva de um novo nó
    Node* _insert(Node* node, int data) {
        if (node == nullptr) {
            return new Node(data); // Cria um novo nó se o local estiver vazio
        }
        if (data < node->data) {
            node->left = _insert(node->left, data); // Insere na subárvore esquerda
        } else if (data > node->data) {
            node->right = _insert(node->right, data); // Insere na subárvore direita
        }
        // Se data == node->data, não faz nada (não permite duplicatas neste exemplo)
        return node;
    }

    // --- ALGORITMO DE BUSCA (Recursivo) ---
    // Este é o coração da busca em árvores binárias (balanceadas ou não).
    // A eficiência O(log N) é garantida se a árvore for balanceada.
    Node* _search(Node* node, int data) const {
        // Caso base 1: O nó é nulo (valor não encontrado)
        if (node == nullptr) {
            std::cout << "  Nó nulo, valor " << data << " não encontrado neste caminho.\n";
            return nullptr;
        }
        // Caso base 2: O valor foi encontrado no nó atual
        if (node->data == data) {
            std::cout << "  Valor " << data << " encontrado no nó com valor " << node->data << ".\n";
            return node;
        }

        // Se o valor buscado for menor que o valor do nó atual, busca na subárvore esquerda
        if (data < node->data) {
            std::cout << "  " << data << " < " << node->data << ", buscando à esquerda de " << node->data << ".\n";
            return _search(node->left, data);
        }
        // Se o valor buscado for maior que o valor do nó atual, busca na subárvore direita
        else {
            std::cout << "  " << data << " > " << node->data << ", buscando à direita de " << node->data << ".\n";
            return _search(node->right, data);
        }
    }

    // Travessia In-order (esquerda -> raiz -> direita) para imprimir a árvore ordenada
    void _inorder(Node* node) const {
        if (node != nullptr) {
            _inorder(node->left);
            std::cout << node->data << " ";
            _inorder(node->right);
        }
    }

    // Função auxiliar para deletar todos os nós da árvore (usada no destrutor)
    void _deleteTree(Node* node) {
        if (node != nullptr) {
            _deleteTree(node->left);
            _deleteTree(node->right);
            delete node;
        }
    }

public:
    // Construtor: Inicializa a árvore como vazia
    BalancedTreeSearch() : root(nullptr) {
        std::cout << "Árvore para Busca criada.\n";
    }

    // Destrutor: Libera toda a memória alocada para os nós da árvore
    ~BalancedTreeSearch() {
        _deleteTree(root);
        std::cout << "Árvore para Busca destruída e memória liberada.\n";
    }

    // --- Métodos Públicos ---

    // Insere um valor na árvore
    void insert(int data) {
        root = _insert(root, data);
        std::cout << "Inserido: " << data << "\n";
    }

    // Busca um valor na árvore
    bool search(int data) const {
        std::cout << "Iniciando busca por " << data << ":\n";
        return _search(root, data) != nullptr;
    }

    // Realiza e imprime a travessia In-order
    void printInOrder() const {
        std::cout << "Conteúdo da árvore (In-order): ";
        _inorder(root);
        std::cout << "\n";
    }
};

int main() {
    std::cout << "--- Exemplo Didático de Busca em Árvores (Conceitualmente Balanceadas) em C++ ---\n\n";

    BalancedTreeSearch bst; // Cria uma instância da árvore

    // --- Inserção de Elementos ---
    // Inserimos elementos de forma a tentar manter a árvore razoavelmente balanceada
    // para ilustrar a eficiência da busca. Em uma árvore *realmente* balanceada (AVL, Red-Black),
    // a lógica de inserção seria mais complexa, com rotações.
    std::cout << "--- Inserindo elementos ---\n";
    bst.insert(50);
    bst.insert(30);
    bst.insert(70);
    bst.insert(20);
    bst.insert(40);
    bst.insert(60);
    bst.insert(80);
    bst.insert(10);
    bst.insert(25);
    std::cout << "\n";

    bst.printInOrder();
    std::cout << "\n";

    // --- Busca de Elementos ---
    int valorBuscado1 = 40;
    if (bst.search(valorBuscado1)) {
        std::cout << "Resultado da busca por " << valorBuscado1 << ": Encontrado!\n";
    } else {
        std::cout << "Resultado da busca por " << valorBuscado1 << ": Nao encontrado.\n";
    }
    std::cout << "\n";

    int valorBuscado2 = 90;
    if (bst.search(valorBuscado2)) {
        std::cout << "Resultado da busca por " << valorBuscado2 << ": Encontrado!\n";
    } else {
        std::cout << "Resultado da busca por " << valorBuscado2 << ": Nao encontrado.\n";
    }
    std::cout << "\n";

    int valorBuscado3 = 25;
    if (bst.search(valorBuscado3)) {
        std::cout << "Resultado da busca por " << valorBuscado3 << ": Encontrado!\n";
    } else {
        std::cout << "Resultado da busca por " << valorBuscado3 << ": Nao encontrado.\n";
    }
    std::cout << "\n";

    std::cout << "--- Fim da Demonstração ---\n";

    return 0;
}