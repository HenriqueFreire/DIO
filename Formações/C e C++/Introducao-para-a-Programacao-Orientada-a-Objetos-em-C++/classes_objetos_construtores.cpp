#include <iostream> // Para entrada/saída (cout)
#include <string>   // Para usar o tipo string

// --- Definição da Classe: Pessoa ---
// Uma classe é um molde para criar objetos. Ela define as características (atributos)
// e os comportamentos (métodos) que os objetos terão.
class Pessoa {
private:
    // Atributos (membros de dados) da classe.
    // São 'private' para encapsulamento, ou seja, só podem ser acessados
    // e modificados pelos métodos da própria classe.
    std::string nome;
    int idade;

public:
    // --- Construtor Padrão (Default Constructor) ---
    // É chamado quando um objeto é criado sem argumentos.
    // Inicializa os atributos com valores padrão.
    Pessoa() {
        nome = "Desconhecido";
        idade = 0;
        std::cout << "Construtor Padrão chamado para " << nome << ".\n";
    }

    // --- Construtor Parametrizado ---
    // É chamado quando um objeto é criado com argumentos.
    // Permite inicializar os atributos com valores específicos.
    Pessoa(std::string n, int i) {
        nome = n;
        idade = i;
        std::cout << "Construtor Parametrizado chamado para " << nome << ".\n";
    }

    // --- Métodos (Funções Membro) ---
    // Definem os comportamentos que os objetos da classe podem realizar.

    // Método para exibir as informações da pessoa.
    void apresentar() {
        std::cout << "Olá, meu nome é " << nome << " e tenho " << idade << " anos.\n";
    }

    // Método para fazer a pessoa envelhecer um ano.
    void fazerAniversario() {
        idade++;
        std::cout << nome << " fez aniversário! Agora tem " << idade << " anos.\n";
    }

    // Métodos "getter" para acessar os atributos privados (boa prática de encapsulamento).
    std::string getNome() const { // 'const' indica que o método não modifica o objeto
        return nome;
    }

    int getIdade() const {
        return idade;
    }
};

int main() {
    std::cout << "--- Exemplo Didático de Classes, Objetos e Construtores em C++ ---\n\n";

    // --- Criação de Objetos ---
    // Um objeto é uma instância de uma classe.

    // 1. Objeto criado usando o Construtor Padrão
    std::cout << "Criando objeto 'pessoa1' (Construtor Padrão):\n";
    Pessoa pessoa1; // Cria um objeto 'pessoa1' da classe 'Pessoa'
    pessoa1.apresentar();
    std::cout << "\n";

    // 2. Objeto criado usando o Construtor Parametrizado
    std::cout << "Criando objeto 'pessoa2' (Construtor Parametrizado):\n";
    Pessoa pessoa2("Alice", 30); // Cria um objeto 'pessoa2' e inicializa com nome e idade
    pessoa2.apresentar();
    pessoa2.fazerAniversario();
    pessoa2.apresentar();
    std::cout << "\n";

    // 3. Outro objeto usando o Construtor Parametrizado
    std::cout << "Criando objeto 'pessoa3' (Construtor Parametrizado):\n";
    Pessoa pessoa3("Bob", 25);
    pessoa3.apresentar();
    std::cout << "\n";

    std::cout << "--- Fim da Demonstração ---\n";

    return 0;
}