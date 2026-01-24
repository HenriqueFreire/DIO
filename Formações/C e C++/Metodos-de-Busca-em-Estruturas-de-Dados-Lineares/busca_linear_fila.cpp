#include <iostream> // Para entrada/saída (cout)
#include <queue>    // Para usar std::queue
#include <string>   // Para mensagens
#include <vector>   // Para auxiliar na busca sem modificar a fila original

// --- 1. Implementação Didática de uma Fila (Queue) ---
// Uma fila é uma estrutura de dados FIFO (First-In, First-Out).
// Usaremos std::queue, que é um adaptador de contêiner da STL.
// Por padrão, std::queue usa std::deque como seu contêiner subjacente.

// --- 2. Método de Busca Linear em uma Fila ---
// Esta função demonstra a busca linear em uma fila.
// Ela percorre os elementos da fila da frente para o final (FIFO)
// até encontrar o valor desejado ou atingir o final da fila.
template <typename T>
int buscaLinearFila(const std::queue<T>& filaOriginal, const T& valorBuscado) {
    // Para buscar em uma fila sem modificá-la, precisamos de uma cópia temporária.
    // Com std::queue, a forma mais didática de iterar sem modificar a original é copiando.
    std::queue<T> filaTemporaria = filaOriginal;
    
    std::cout << "Iniciando busca linear por '" << valorBuscado << "' na fila...\n";

    int indice = 0; // Índice (0-based) do elemento, contando da frente da fila
    while (!filaTemporaria.empty()) {
        T elementoAtual = filaTemporaria.front(); // Pega o elemento da frente
        std::cout << "  Verificando elemento no indice " << indice << " (valor: " << elementoAtual << ")\n";
        
        if (elementoAtual == valorBuscado) {
            std::cout << "  Valor '" << valorBuscado << "' encontrado no indice " << indice << " (contando da frente).\n";
            return indice; // Retorna o índice onde o valor foi encontrado
        }
        
        filaTemporaria.pop(); // Remove o elemento da frente para ir para o próximo
        indice++;
    }
    
    std::cout << "  Valor '" << valorBuscado << "' nao encontrado na fila.\n";
    return -1; // Retorna -1 se o valor não for encontrado
}

int main() {
    std::cout << "--- Exemplo Didático de Busca Linear em Fila (C++) ---\n\n";

    // --- Criação e Manipulação da Fila ---
    std::queue<int> minhaFila; // Cria uma fila de inteiros

    minhaFila.push(10);
    minhaFila.push(20);
    minhaFila.push(30);
    minhaFila.push(40);
    minhaFila.push(50);
    
    std::cout << "Fila criada (frente -> final): [";
    std::queue<int> tempPrintFila = minhaFila; // Cópia para imprimir sem esvaziar a original
    while(!tempPrintFila.empty()){
        std::cout << tempPrintFila.front();
        tempPrintFila.pop();
        if(!tempPrintFila.empty()) std::cout << ", ";
    }
    std::cout << "]\n";
    std::cout << "\n";

    // --- Demonstração da Busca Linear ---

    // Busca por um elemento existente
    int valorParaBuscar1 = 30;
    int indiceEncontrado1 = buscaLinearFila(minhaFila, valorParaBuscar1);
    if (indiceEncontrado1 != -1) {
        std::cout << "Resultado: '" << valorParaBuscar1 << "' esta na fila.\n";
    } else {
        std::cout << "Resultado: '" << valorParaBuscar1 << "' NAO esta na fila.\n";
    }
    std::cout << "\n";

    // Busca por um elemento não existente
    int valorParaBuscar2 = 100;
    int indiceEncontrado2 = buscaLinearFila(minhaFila, valorParaBuscar2);
    if (indiceEncontrado2 != -1) {
        std::cout << "Resultado: '" << valorParaBuscar2 << "' esta na fila.\n";
    } else {
        std::cout << "Resultado: '" << valorParaBuscar2 << "' NAO esta na fila.\n";
    }
    std::cout << "\n";

    // A fila original permanece inalterada após a busca
    std::cout << "Fila original apos as buscas (frente -> final): [";
    std::queue<int> tempPrintFila2 = minhaFila;
    while(!tempPrintFila2.empty()){
        std::cout << tempPrintFila2.front();
        tempPrintFila2.pop();
        if(!tempPrintFila2.empty()) std::cout << ", ";
    }
    std::cout << "]\n";
    std::cout << "\n";

    // Exemplo de pop para mostrar FIFO
    std::cout << "Removendo elemento da frente da fila (pop):\n";
    if (!minhaFila.empty()) {
        std::cout << "Elemento removido: " << minhaFila.front() << "\n";
        minhaFila.pop();
    }
    std::cout << "Fila apos pop (frente -> final): [";
    std::queue<int> tempPrintFila3 = minhaFila;
    while(!tempPrintFila3.empty()){
        std::cout << tempPrintFila3.front();
        tempPrintFila3.pop();
        if(!tempPrintFila3.empty()) std::cout << ", ";
    }
    std::cout << "]\n";


    std::cout << "\n--- Fim da Demonstração ---\n";

    return 0;
}