# Jogo de Sudoku CLI

Este é um jogo de Sudoku de interface de linha de comando (CLI) implementado em Java. Você pode gerar novos quebra-cabeças, jogar inserindo números e ter o jogo validando seus movimentos.

## Funcionalidades

*   **Gerar Novos Quebra-Cabeças**: Inicie um novo jogo de Sudoku com um quebra-cabeça gerado aleatoriamente e solucionável.
*   **Jogar Interativamente**: Insira números no tabuleiro, com validação em tempo real de seus movimentos.
*   **Condição de Vitória**: Detecta quando você resolveu o quebra-cabeça com sucesso.
*   **Validação Básica**: Impede a colocação de números em células pré-preenchidas e verifica as regras do Sudoku (conflitos de linha, coluna e caixa 3x3).

## Como Jogar

### Pré-requisitos

Para executar este jogo, você precisa:
*   **Java Development Kit (JDK) 11 ou mais recente**: Certifique-se de ter um JDK compatível instalado.
*   **Nix**: O projeto utiliza Nix para gerenciamento de dependências e construção.

### Construindo e Executando o Jogo

1.  **Clone o repositório** (se ainda não o fez):
    ```bash
    git clone <url_do_repositorio>
    cd Criando\ um\ Jogo\ do\ Sudoku\ em\ Java # Ou onde quer que esteja a raiz do seu projeto
    ```

2.  **Construa o projeto usando Nix**:
    Navegue até o diretório raiz do projeto e execute:
    ```bash
    nix-shell --run "mvn clean install"
    ```
    Este comando fará o download de todas as dependências necessárias, compilará o código Java, executará os testes e empacotará a aplicação.

3.  **Execute o jogo**:
    Após uma construção bem-sucedida, você pode executar o jogo a partir da raiz do projeto:
    ```bash
    nix-shell --run "java -jar target/sudoku-game-1.0-SNAPSHOT.jar"
    ```
    Alternativamente, se `mvn` estiver diretamente no seu PATH, você pode usar:
    ```bash
    mvn exec:java -Dexec.mainClass="com.sudoku.App"
    ```

### Comandos no Jogo

Assim que o jogo iniciar, você verá um tabuleiro de Sudoku impresso no seu console.

*   **Fazer uma jogada**: Insira sua jogada no formato `linha coluna valor`.
    *   `linha`: O número da linha (1-9).
    *   `coluna`: O número da coluna (1-9).
    *   `valor`: O número que você deseja colocar (1-9), ou `0` para limpar uma célula.
    *   Exemplo: `1 1 5` para colocar um `5` na célula superior esquerda.
    *   Exemplo: `1 1 0` para limpar a célula superior esquerda.

*   **Iniciar um novo jogo**: Digite `novo` e pressione Enter.

*   **Sair do jogo**: Digite `sair` e pressione Enter.

### Exemplo de Jogo

```
Bem-vindo ao Sudoku!
Novo jogo gerado:
. . . | . . . | . . .
. . . | . . . | . . .
. . . | . . . | . . .
------+-------+------
. . . | . . . | . . .
. . . | . . . | . . .
. . . | . . . | . . .
------+-------+------
. . . | . . . | . . .
. . . | . . . | . . .
. . . | . . . | . . .

Digite sua jogada (linha coluna valor), ou 'novo' para um novo jogo, ou 'sair' para sair:
1 1 5

Tabuleiro atual:
5 . . | . . . | . . .
. . . | . . . | . . .
. . . | . . . | . . .
------+-------+------
... (e assim por diante)
```

## Executando Testes

Para executar os testes de unidade para o jogo de Sudoku:

```bash
nix-shell --run "mvn test"
```
Ou, se você já construiu o projeto:
```bash
nix-shell --run "mvn surefire:test"
```

Aproveite para jogar Sudoku!