#include <iostream> // Para entrada/saída (cout)
#include <vector>   // Para usar std::vector como base da pilha
#include <string>   // Para mensagens
#include <stdexcept> // Para std::out_of_range

// --- 1. Implementação Didática de uma Pilha (Stack) ---
// Uma pilha é uma estrutura de dados LIFO (Last-In, First-Out).
// Usaremos std::vector internamente para simplificar a implementação.
template <typename T> // 'template' permite que a pilha funcione com qualquer tipo de dado
class Pilha {
private:
    std::vector<T> elementos; // Onde os elementos da pilha são armazenados

public:
    // Adiciona um elemento ao topo da pilha
    void push(const T& valor) {
        elementos.push_back(valor);
        std::cout << "Push: " << valor << " (Tamanho atual: " << elementos.size() << ")\n";
    }

    // Remove e retorna o elemento do topo da pilha
    T pop() {
        if (isEmpty()) {
            throw std::out_of_range("Pilha vazia! Nao eh possivel remover.");
        }
        T valor = elementos.back(); // Pega o elemento do topo
        elementos.pop_back();       // Remove o elemento do topo
        std::cout << "Pop: " << valor << " (Tamanho atual: " << elementos.size() << ")\n";
        return valor;
    }

    // Retorna o elemento do topo da pilha sem removê-lo
    const T& top() const {
        if (isEmpty()) {
            throw std::out_of_range("Pilha vazia! Nao ha elemento no topo.");
        }
        return elementos.back();
    }

    // Verifica se a pilha está vazia
    bool isEmpty() const {
        return elementos.empty();
    }

    // Retorna o número de elementos na pilha
    size_t size() const {
        return elementos.size();
    }

    // --- Método para acesso linear (para a busca) ---
    // Retorna uma referência constante ao vetor interno.
    // Isso permite que a função de busca itere sobre os elementos sem modificar a pilha.
    const std::vector<T>& getElementos() const {
        return elementos;
    }

    // Método para imprimir a pilha (útil para depuração)
    void imprimir() const {
        std::cout << "Pilha (topo -> base): [";
        for (int i = elementos.size() - 1; i >= 0; --i) {
            std::cout << elementos[i];
            if (i > 0) {
                std::cout << ", ";
            }
        }
        std::cout << "]\n";
    }
};

// --- 2. Método de Busca Linear em uma Pilha ---
// Esta função demonstra a busca linear em uma pilha.
// Ela percorre os elementos da pilha do topo para a base (ou vice-versa)
// até encontrar o valor desejado ou atingir o final da pilha.
template <typename T>
int buscaLinearPilha(const Pilha<T>& pilha, const T& valorBuscado) {
    // Obtém uma referência constante aos elementos internos da pilha.
    // Isso nos permite iterar sem modificar a pilha original.
    const std::vector<T>& elementosPilha = pilha.getElementos();
    
    std::cout << "Iniciando busca linear por '" << valorBuscado << "' na pilha...\n";

    // Percorre a pilha do topo para a base (LIFO)
    // O índice 'i' representa a posição do elemento no vetor interno.
    for (int i = elementosPilha.size() - 1; i >= 0; --i) {
        std::cout << "  Verificando elemento no indice " << i << " (valor: " << elementosPilha[i] << ")\n";
        if (elementosPilha[i] == valorBuscado) {
            std::cout << "  Valor '" << valorBuscado << "' encontrado no indice " << i << " (contando da base).\n";
            return i; // Retorna o índice (0-based) onde o valor foi encontrado
        }
    }
    std::cout << "  Valor '" << valorBuscado << "' nao encontrado na pilha.\n";
    return -1; // Retorna -1 se o valor não for encontrado
}

int main() {
    std::cout << "--- Exemplo Didático de Busca Linear em Pilha (C++) ---\n\n";

    // --- Criação e Manipulação da Pilha ---
    Pilha<int> minhaPilha; // Cria uma pilha de inteiros

    minhaPilha.push(10);
    minhaPilha.push(20);
    minhaPilha.push(30);
    minhaPilha.push(40);
    minhaPilha.push(50);
    minhaPilha.imprimir();
    std::cout << "\n";

    // --- Demonstração da Busca Linear ---

    // Busca por um elemento existente
    int valorParaBuscar1 = 30;
    int indiceEncontrado1 = buscaLinearPilha(minhaPilha, valorParaBuscar1);
    if (indiceEncontrado1 != -1) {
        std::cout << "Resultado: '" << valorParaBuscar1 << "' esta na pilha.\n";
    } else {
        std::cout << "Resultado: '" << valorParaBuscar1 << "' NAO esta na pilha.\n";
    }
    std::cout << "\n";

    // Busca por um elemento não existente
    int valorParaBuscar2 = 100;
    int indiceEncontrado2 = buscaLinearPilha(minhaPilha, valorParaBuscar2);
    if (indiceEncontrado2 != -1) {
        std::cout << "Resultado: '" << valorParaBuscar2 << "' esta na pilha.\n";
    }
    else {
        std::cout << "Resultado: '" << valorParaBuscar2 << "' NAO esta na pilha.\n";
    }
    std::cout << "\n";

    // A pilha permanece inalterada após a busca
    std::cout << "Pilha apos as buscas:\n";
    minhaPilha.imprimir();
    std::cout << "\n";

    // Exemplo de pop para mostrar LIFO
    try {
        minhaPilha.pop();
        minhaPilha.imprimir();
    } catch (const std::out_of_range& e) {
        std::cerr << "Erro: " << e.what() << std::endl;
    }


    std::cout << "\n--- Fim da Demonstração ---\n";

    return 0;
}
