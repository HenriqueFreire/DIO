#include <iostream> // Para entrada/saída (cout)
#include <string>   // Para mensagens

// --- 1. Definição do Nó (Node) da Lista Circular ---
// Cada nó contém um dado e um ponteiro para o próximo nó.
struct Node {
    int data;
    Node* next;

    // Construtor para facilitar a criação de nós
    Node(int val) : data(val), next(nullptr) {}
};

// --- 2. Implementação Didática de uma Lista Circular Simples ---
// Uma lista circular é uma lista encadeada onde o último nó aponta para o primeiro.
class ListaCircular {
private:
    Node* head; // Ponteiro para o primeiro nó da lista

public:
    // Construtor: Inicializa a lista como vazia
    ListaCircular() : head(nullptr) {}

    // Verifica se a lista está vazia
    bool isEmpty() const {
        return head == nullptr;
    }

    // Adiciona um novo nó ao final da lista circular
    void addNode(int data) {
        Node* newNode = new Node(data);
        if (isEmpty()) {
            head = newNode;
            head->next = head; // O primeiro nó aponta para si mesmo
        } else {
            Node* current = head;
            // Percorre até o último nó (o nó cujo 'next' aponta para 'head')
            while (current->next != head) {
                current = current->next;
            }
            current->next = newNode; // O antigo último nó aponta para o novo nó
            newNode->next = head;    // O novo nó aponta para o head, fechando o círculo
        }
        std::cout << "Adicionado: " << data << "\n";
    }

    // Imprime os elementos da lista circular
    void printList() const {
        if (isEmpty()) {
            std::cout << "Lista Circular: [Vazia]\n";
            return;
        }
        std::cout << "Lista Circular: [";
        Node* current = head;
        do {
            std::cout << current->data;
            current = current->next;
            if (current != head) { // Se não for o último elemento antes de voltar ao head
                std::cout << ", ";
            }
        } while (current != head); // Continua até voltar ao head
        std::cout << "]\n";
    }

    // --- Destrutor: Libera a memória alocada para os nós ---
    ~ListaCircular() {
        if (isEmpty()) {
            return;
        }
        Node* current = head->next;
        Node* nextNode;
        while (current != head) {
            nextNode = current->next;
            delete current;
            current = nextNode;
        }
        delete head; // Libera o nó head por último
        head = nullptr;
        std::cout << "Lista Circular destruída e memória liberada.\n";
    }

    // --- Método para acesso linear (para a busca) ---
    // Retorna o ponteiro para o head da lista (para a função de busca)
    Node* getHead() const {
        return head;
    }
};

// --- 3. Método de Busca Linear em uma Lista Circular ---
// Esta função demonstra a busca linear em uma lista circular.
// Ela percorre os elementos da lista sequencialmente.
bool buscaLinearListaCircular(const ListaCircular& lista, int valorBuscado) {
    if (lista.isEmpty()) {
        std::cout << "Iniciando busca linear por '" << valorBuscado << "' na lista vazia. Nao encontrado.\n";
        return false;
    }

    Node* current = lista.getHead();
    int indice = 0;
    std::cout << "Iniciando busca linear por '" << valorBuscado << "' na lista circular...\n";

    do {
        std::cout << "  Verificando elemento no indice " << indice << " (valor: " << current->data << ")\n";
        if (current->data == valorBuscado) {
            std::cout << "  Valor '" << valorBuscado << "' encontrado no indice " << indice << ".\n";
            return true; // Valor encontrado
        }
        current = current->next;
        indice++;
    } while (current != lista.getHead()); // Continua até voltar ao ponto de partida

    std::cout << "  Valor '" << valorBuscado << "' nao encontrado na lista circular.\n";
    return false; // Valor não encontrado
}

int main() {
    std::cout << "--- Exemplo Didático de Busca Linear em Lista Circular (C++) ---\n\n";

    // --- Criação e Manipulação da Lista Circular ---
    ListaCircular minhaLista; // Cria uma lista circular

    minhaLista.addNode(10);
    minhaLista.addNode(20);
    minhaLista.addNode(30);
    minhaLista.addNode(40);
    minhaLista.printList();
    std::cout << "\n";

    // --- Demonstração da Busca Linear ---

    // Busca por um elemento existente
    int valorParaBuscar1 = 30;
    if (buscaLinearListaCircular(minhaLista, valorParaBuscar1)) {
        std::cout << "Resultado: '" << valorParaBuscar1 << "' esta na lista.\n";
    } else {
        std::cout << "Resultado: '" << valorParaBuscar1 << "' NAO esta na lista.\n";
    }
    std::cout << "\n";

    // Busca por um elemento não existente
    int valorParaBuscar2 = 100;
    if (buscaLinearListaCircular(minhaLista, valorParaBuscar2)) {
        std::cout << "Resultado: '" << valorParaBuscar2 << "' esta na lista.\n";
    } else {
        std::cout << "Resultado: '" << valorParaBuscar2 << "' NAO esta na lista.\n";
    }
    std::cout << "\n";

    // A lista permanece inalterada após a busca
    std::cout << "Lista apos as buscas:\n";
    minhaLista.printList();
    std::cout << "\n";

    std::cout << "\n--- Fim da Demonstração ---\n";

    return 0;
}
