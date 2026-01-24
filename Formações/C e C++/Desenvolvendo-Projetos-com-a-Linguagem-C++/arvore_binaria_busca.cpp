#include <iostream> // Para entrada/saída (cout)
#include <string>   // Para mensagens

// --- 1. Definição do Nó (Node) da Árvore Binária de Busca ---
// Cada nó contém um valor (dado), e ponteiros para seus filhos esquerdo e direito.
struct Node {
    int data;
    Node* left;  // Ponteiro para o filho esquerdo
    Node* right; // Ponteiro para o filho direito

    // Construtor para facilitar a criação de nós
    Node(int val) : data(val), left(nullptr), right(nullptr) {}
};

// --- 2. Implementação da Árvore Binária de Busca (BST) ---
// Uma BST é uma estrutura de dados onde, para cada nó:
// - Todos os valores na subárvore esquerda são menores que o valor do nó.
// - Todos os valores na subárvore direita são maiores que o valor do nó.
class BinarySearchTree {
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

    // Busca recursiva por um valor
    Node* _search(Node* node, int data) const {
        if (node == nullptr || node->data == data) {
            return node; // Retorna o nó se encontrado ou nullptr se não
        }
        if (data < node->data) {
            return _search(node->left, data); // Busca na subárvore esquerda
        } else {
            return _search(node->right, data); // Busca na subárvore direita
        }
    }

    // Travessia In-order (esquerda -> raiz -> direita)
    void _inorder(Node* node) const {
        if (node != nullptr) {
            _inorder(node->left);
            std::cout << node->data << " ";
            _inorder(node->right);
        }
    }

    // Travessia Pre-order (raiz -> esquerda -> direita)
    void _preorder(Node* node) const {
        if (node != nullptr) {
            std::cout << node->data << " ";
            _preorder(node->left);
            _preorder(node->right);
        }
    }

    // Travessia Post-order (esquerda -> direita -> raiz)
    void _postorder(Node* node) const {
        if (node != nullptr) {
            _postorder(node->left);
            _postorder(node->right);
            std::cout << node->data << " ";
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
    BinarySearchTree() : root(nullptr) {
        std::cout << "Árvore Binária de Busca criada.\n";
    }

    // Destrutor: Libera toda a memória alocada para os nós da árvore
    ~BinarySearchTree() {
        _deleteTree(root);
        std::cout << "Árvore Binária de Busca destruída e memória liberada.\n";
    }

    // --- Métodos Públicos ---

    // Insere um valor na árvore
    void insert(int data) {
        root = _insert(root, data);
        std::cout << "Inserido: " << data << "\n";
    }

    // Busca um valor na árvore
    bool search(int data) const {
        return _search(root, data) != nullptr;
    }

    // Realiza e imprime a travessia In-order
    void inorderTraversal() const {
        std::cout << "Travessia In-order: ";
        _inorder(root);
        std::cout << "\n";
    }

    // Realiza e imprime a travessia Pre-order
    void preorderTraversal() const {
        std::cout << "Travessia Pre-order: ";
        _preorder(root);
        std::cout << "\n";
    }

    // Realiza e imprime a travessia Post-order
    void postorderTraversal() const {
        std::cout << "Travessia Post-order: ";
        _postorder(root);
        std::cout << "\n";
    }
};

int main() {
    std::cout << "--- Exemplo Didático de Árvore Binária de Busca (C++) ---\n\n";

    BinarySearchTree bst; // Cria uma instância da BST

    // --- Inserção de Elementos ---
    bst.insert(50);
    bst.insert(30);
    bst.insert(70);
    bst.insert(20);
    bst.insert(40);
    bst.insert(60);
    bst.insert(80);
    std::cout << "\n";

    // --- Travessias ---
    bst.inorderTraversal();  // Esperado: 20 30 40 50 60 70 80 (ordenado)
    bst.preorderTraversal(); // Esperado: 50 30 20 40 70 60 80
    bst.postorderTraversal(); // Esperado: 20 40 30 60 80 70 50
    std::cout << "\n";

    // --- Busca de Elementos ---
    int valorBuscado1 = 40;
    if (bst.search(valorBuscado1)) {
        std::cout << "Busca por " << valorBuscado1 << ": Encontrado!\n";
    } else {
        std::cout << "Busca por " << valorBuscado1 << ": Nao encontrado.\n";
    }

    int valorBuscado2 = 90;
    if (bst.search(valorBuscado2)) {
        std::cout << "Busca por " << valorBuscado2 << ": Encontrado!\n";
    } else {
        std::cout << "Busca por " << valorBuscado2 << ": Nao encontrado.\n";
    }
    std::cout << "\n";

    std::cout << "--- Fim da Demonstração ---\n";
    // A árvore é automaticamente destruída ao sair do escopo de main(),
    // chamando o destrutor que libera a memória de todos os nós.

    return 0;
}