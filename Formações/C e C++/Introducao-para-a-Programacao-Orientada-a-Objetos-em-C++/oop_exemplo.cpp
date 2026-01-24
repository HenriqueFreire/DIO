#include <iostream> // Para entrada/saída (cout, cin)
#include <string>   // Para usar o tipo string

// --- 1. Classe Base: Animal ---
// Demonstra a criação de uma classe e encapsulamento.
class Animal {
private:
    // Membros privados: encapsulamento. Acessíveis apenas pelos métodos da própria classe.
    std::string nome;
    int idade;

public:
    // --- 2. Construtor Parametrizado ---
    // Método especial chamado quando um objeto é criado. Inicializa os membros.
    Animal(std::string nome_animal, int idade_animal) : nome(nome_animal), idade(idade_animal) {
        std::cout << "Animal " << nome << " criado (Construtor Animal).\n";
    }

    // --- 3. Métodos Públicos (Getters) ---
    // Permitem acesso controlado aos membros privados.
    std::string getNome() const {
        return nome;
    }

    int getIdade() const {
        return idade;
    }

    // --- 4. Método Virtual (para Polimorfismo) ---
    // 'virtual' permite que classes derivadas forneçam sua própria implementação.
    virtual void fazerBarulho() const {
        std::cout << nome << " faz um barulho genérico.\n";
    }

    // Método para exibir informações básicas do animal.
    virtual void exibirInfo() const {
        std::cout << "Nome: " << nome << ", Idade: " << idade << " anos.\n";
    }

    // --- 5. Destrutor ---
    // Método especial chamado quando um objeto é destruído. Útil para liberar recursos.
    virtual ~Animal() { // Destrutor virtual é uma boa prática para classes base
        std::cout << "Animal " << nome << " destruído (Destrutor Animal).\n";
    }
};

// --- 6. Classe Derivada: Cachorro (Herança) ---
// 'Cachorro' herda de 'Animal', reutilizando sua funcionalidade e adicionando a sua própria.
class Cachorro : public Animal {
private:
    std::string raca; // Membro específico de Cachorro

public:
    // --- 7. Construtor da Classe Derivada ---
    // Chama o construtor da classe base 'Animal' e inicializa seus próprios membros.
    Cachorro(std::string nome_cachorro, int idade_cachorro, std::string raca_cachorro)
        : Animal(nome_cachorro, idade_cachorro), raca(raca_cachorro) {
        std::cout << "Cachorro " << nome_cachorro << " criado (Construtor Cachorro).\n";
    }

    // --- 8. Sobrescrita de Método (Polimorfismo) ---
    // Fornece uma implementação específica para 'fazerBarulho' para Cachorro.
    void fazerBarulho() const override {
        std::cout << getNome() << " late: Au Au!\n";
    }

    // Sobrescrita do método exibirInfo para incluir a raça.
    void exibirInfo() const override {
        std::cout << "Nome: " << getNome() << ", Idade: " << getIdade() << " anos, Raça: " << raca << ".\n";
    }

    // Destrutor específico de Cachorro
    ~Cachorro() override { // 'override' também pode ser usado em destrutores virtuais
        std::cout << "Cachorro " << getNome() << " destruído (Destrutor Cachorro).\n";
    }
};

int main() {
    std::cout << "--- Exemplo de Programação Orientada a Objetos em C++ ---\n\n";

    // --- 9. Criação de Objetos ---
    // Cria um objeto da classe base Animal
    Animal meuAnimal("Leao", 5);
    meuAnimal.exibirInfo();
    meuAnimal.fazerBarulho();
    std::cout << "\n";

    // Cria um objeto da classe derivada Cachorro
    Cachorro meuCachorro("Rex", 3, "Labrador");
    meuCachorro.exibirInfo();
    meuCachorro.fazerBarulho();
    std::cout << "\n";

    // --- 10. Polimorfismo Básico (usando ponteiros para a classe base) ---
    // Um ponteiro para Animal pode apontar para um objeto Cachorro.
    // A chamada a fazerBarulho() e exibirInfo() usará a versão do Cachorro (devido a 'virtual' e 'override').
    Animal* animalGenerico = &meuCachorro;
    std::cout << "--- Polimorfismo com ponteiro Animal apontando para Cachorro ---\n";
    animalGenerico->exibirInfo();
    animalGenerico->fazerBarulho();
    std::cout << "\n";

    // Demonstração de outro animal
    Animal outroAnimal("Gato", 2);
    outroAnimal.exibirInfo();
    outroAnimal.fazerBarulho();
    std::cout << "\n";

    std::cout << "--- Fim da Demonstração ---\n";
    // Objetos são destruídos automaticamente ao sair do escopo de main(),
    // chamando seus destrutores.

    return 0;
}