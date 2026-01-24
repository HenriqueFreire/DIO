#include <iostream> // Para entrada/saída (cout)
#include <string>   // Para usar o tipo string

// --- Classe Base: Veiculo ---
// Esta classe define características comuns a todos os veículos.
class Veiculo {
protected:
    // Membros 'protected' são acessíveis pela própria classe e por classes derivadas.
    // Isso permite que as classes filhas acessem esses atributos diretamente,
    // mas ainda os mantém encapsulados do mundo exterior.
    std::string marca;
    int ano;

public:
    // Construtor da classe base.
    Veiculo(std::string m, int a) : marca(m), ano(a) {
        std::cout << "Construtor Veiculo chamado para " << marca << ".\n";
    }

    // Método para exibir informações básicas do veículo.
    void exibirInfoBase() const {
        std::cout << "Marca: " << marca << ", Ano: " << ano << ".\n";
    }

    // Destrutor virtual é uma boa prática para classes base que serão herdadas.
    virtual ~Veiculo() {
        std::cout << "Destrutor Veiculo chamado para " << marca << ".\n";
    }
};

// --- Classe Derivada: Carro ---
// 'Carro' herda de 'Veiculo', adicionando características específicas de carro.
// 'public Veiculo' significa que os membros públicos/protegidos de Veiculo
// permanecem públicos/protegidos em Carro.
class Carro : public Veiculo {
private:
    int numeroPortas; // Característica específica de Carro

public:
    // Construtor da classe Carro.
    // Ele chama o construtor da classe base 'Veiculo' usando a sintaxe 'Veiculo(m, a)'.
    Carro(std::string m, int a, int portas) : Veiculo(m, a), numeroPortas(portas) {
        std::cout << "Construtor Carro chamado para " << marca << ".\n";
    }

    // Método para exibir informações do carro, incluindo as herdadas e as específicas.
    void exibirInfoCarro() const {
        // Acessa membros 'protected' da classe base diretamente.
        std::cout << "Carro: " << marca << ", Ano: " << ano << ", Portas: " << numeroPortas << ".\n";
    }

    ~Carro() override {
        std::cout << "Destrutor Carro chamado para " << marca << ".\n";
    }
};

// --- Classe Derivada: Moto ---
// 'Moto' também herda de 'Veiculo', com suas próprias características específicas.
class Moto : public Veiculo {
private:
    bool temBau; // Característica específica de Moto

public:
    // Construtor da classe Moto.
    Moto(std::string m, int a, bool bau) : Veiculo(m, a), temBau(bau) {
        std::cout << "Construtor Moto chamado para " << marca << ".\n";
    }

    // Método para exibir informações da moto.
    void exibirInfoMoto() const {
        std::cout << "Moto: " << marca << ", Ano: " << ano << ", Tem Baú: " << (temBau ? "Sim" : "Não") << ".\n";
    }

    ~Moto() override {
        std::cout << "Destrutor Moto chamado para " << marca << ".\n";
    }
};

int main() {
    std::cout << "--- Exemplo Didático de Herança em C++ ---\n\n";

    // --- Criação de Objetos da Classe Base ---
    std::cout << "Criando um Veículo genérico:\n";
    Veiculo meuVeiculo("Bicicleta", 2020);
    meuVeiculo.exibirInfoBase();
    std::cout << "\n";

    // --- Criação de Objetos da Classe Derivada Carro ---
    std::cout << "Criando um Carro:\n";
    Carro meuCarro("Toyota", 2022, 4);
    meuCarro.exibirInfoCarro();
    // Carro também pode usar métodos da classe base
    std::cout << "  (Usando método da classe base): ";
    meuCarro.exibirInfoBase();
    std::cout << "\n";

    // --- Criação de Objetos da Classe Derivada Moto ---
    std::cout << "Criando uma Moto:\n";
    Moto minhaMoto("Honda", 2023, true);
    minhaMoto.exibirInfoMoto();
    // Moto também pode usar métodos da classe base
    std::cout << "  (Usando método da classe base): ";
    minhaMoto.exibirInfoBase();
    std::cout << "\n";

    std::cout << "--- Fim da Demonstração ---\n";

    return 0;
}
