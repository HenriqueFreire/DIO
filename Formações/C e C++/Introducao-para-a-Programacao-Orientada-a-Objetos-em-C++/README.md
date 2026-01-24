# Exemplo Didático: Atributos e Métodos em C++

Este projeto foca nos dois componentes essenciais de uma classe na Programação Orientada a Objetos (POO) em C++: **Atributos** e **Métodos**. Ele demonstra como esses elementos definem o que um objeto "é" e o que um objeto "faz".

## Conteúdo do Projeto:

*   `atributos_metodos_exemplo.cpp`: Contém o código-fonte com o exemplo.
*   `README.md`: Este arquivo, explicando os conceitos.

## Conceitos Demonstrados:

### 1. Atributos (Membros de Dados)

*   **O que são:** Atributos são as **características** ou **propriedades** que um objeto possui. Eles representam o estado do objeto. Pense neles como as "variáveis" que pertencem a um objeto.
*   **Exemplo (`class Carro`):**
    *   `std::string marca;`
    *   `std::string modelo;`
    *   `int velocidadeAtual;`
    *   Esses atributos descrevem o carro: qual sua marca, qual seu modelo e qual sua velocidade no momento.
*   **Encapsulamento (`private`):** No exemplo, os atributos são declarados como `private`. Isso é uma boa prática de encapsulamento, significando que eles só podem ser acessados e modificados pelos métodos da própria classe `Carro`. Para acessar esses atributos de fora da classe, usamos métodos públicos (como `getMarca()`).

### 2. Métodos (Funções Membro)

*   **O que são:** Métodos são os **comportamentos** ou **ações** que um objeto pode realizar. Eles representam o "o que" o objeto pode fazer. Pense neles como as "funções" que pertencem a um objeto.
*   **Exemplo (`class Carro`):**
    *   **Construtor (`Carro(std::string m, std::string mod)`):** Um método especial que inicializa o objeto quando ele é criado.
    *   **`acelerar(int incremento)`:** Um método que modifica o estado do carro (aumenta a `velocidadeAtual`).
    *   **`frear(int decremento)`:** Um método que modifica o estado do carro (diminui a `velocidadeAtual`).
    *   **`exibirStatus() const`:** Um método que exibe informações sobre o estado atual do carro. O `const` indica que este método não altera nenhum atributo do objeto.
    *   **Getters (`getMarca()`, `getModelo()`):** Métodos públicos que permitem ler o valor de atributos privados de forma controlada.

### 3. Interação entre Atributos e Métodos

*   Os métodos de uma classe operam sobre os atributos dessa mesma classe. Por exemplo, o método `acelerar()` acessa e modifica o atributo `velocidadeAtual` do objeto `Carro`.
*   A combinação de atributos e métodos dentro de uma classe define completamente o comportamento e o estado de um objeto.

## Como Compilar e Executar:

1.  **Navegue até a pasta:**
    ```bash
    cd Introducao-para-a-Programacao-Orientada-a-Objetos-em-C++
    ```
2.  **Compile o código:**
    ```bash
    g++ atributos_metodos_exemplo.cpp -o atributos_metodos_exemplo
    ```
    (Use `g++` para compilar código C++).
3.  **Execute o programa:**
    ```bash
    ./atributos_metodos_exemplo
    ```

O programa demonstrará a criação de objetos `Carro`, a modificação de seus estados através de métodos e a exibição de suas características.