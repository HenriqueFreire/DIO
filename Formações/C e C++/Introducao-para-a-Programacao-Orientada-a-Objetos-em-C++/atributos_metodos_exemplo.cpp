#include <iostream> // Para entrada/saída (cout)
#include <string>   // Para usar o tipo string

// --- Definição da Classe: Carro ---
// Uma classe é um molde que define as características (atributos)
// e os comportamentos (métodos) que os objetos terão.
class Carro {
private:
    // --- Atributos (Características/Membros de Dados) ---
    // Representam o "o que" o objeto possui.
    // São 'private' para encapsulamento, protegendo o acesso direto.
    std::string marca;
    std::string modelo;
    int velocidadeAtual;

public:
    // --- Construtor ---
    // Método especial para inicializar os atributos de um objeto quando ele é criado.
    Carro(std::string m, std::string mod) {
        marca = m;
        modelo = mod;
        velocidadeAtual = 0; // Carro começa parado
        std::cout << "Carro " << marca << " " << modelo << " criado.\n";
    }

    // --- Métodos (Comportamentos/Funções Membro) ---
    // Representam o "o que" o objeto pode fazer.

    // Método para acelerar o carro
    void acelerar(int incremento) {
        if (incremento > 0) {
            velocidadeAtual += incremento;
            std::cout << marca << " " << modelo << " acelerou para " << velocidadeAtual << " km/h.\n";
        } else {
            std::cout << "Incremento de velocidade inválido.\n";
        }
    }

    // Método para frear o carro
    void frear(int decremento) {
        if (decremento > 0 && velocidadeAtual - decremento >= 0) {
            velocidadeAtual -= decremento;
            std::cout << marca << " " << modelo << " freou para " << velocidadeAtual << " km/h.\n";
        } else if (velocidadeAtual - decremento < 0) {
            velocidadeAtual = 0;
            std::cout << marca << " " << modelo << " parou.\n";
        } else {
            std::cout << "Decremento de velocidade inválido.\n";
        }
    }

    // Método para exibir o status atual do carro
    void exibirStatus() const { // 'const' indica que este método não modifica o objeto
        std::cout << "Status do Carro: " << marca << " " << modelo 
                  << " está a " << velocidadeAtual << " km/h.\n";
    }

    // Métodos "getter" para acessar atributos privados (exemplo de encapsulamento)
    std::string getMarca() const {
        return marca;
    }

    std::string getModelo() const {
        return modelo;
    }
};

int main() {
    std::cout << "--- Exemplo Didático de Atributos e Métodos em C++ ---\n\n";

    // --- Criação de Objetos ---
    // Criamos instâncias da classe Carro. Cada uma é um objeto independente.
    Carro meuCarro("Ford", "Fiesta");
    Carro seuCarro("Chevrolet", "Onix");
    std::cout << "\n";

    // --- Interagindo com os Objetos (Chamando Métodos e Acessando Atributos via Getters) ---

    // Objeto 'meuCarro'
    meuCarro.exibirStatus();
    meuCarro.acelerar(50);
    meuCarro.exibirStatus();
    meuCarro.frear(20);
    meuCarro.exibirStatus();
    std::cout << "Marca do meu carro: " << meuCarro.getMarca() << "\n";
    std::cout << "\n";

    // Objeto 'seuCarro'
    seuCarro.exibirStatus();
    seuCarro.acelerar(70);
    seuCarro.acelerar(30);
    seuCarro.exibirStatus();
    seuCarro.frear(100);
    seuCarro.exibirStatus();
    std::cout << "Modelo do seu carro: " << seuCarro.getModelo() << "\n";
    std::cout << "\n";

    std::cout << "--- Fim da Demonstração ---\n";

    return 0;
}
