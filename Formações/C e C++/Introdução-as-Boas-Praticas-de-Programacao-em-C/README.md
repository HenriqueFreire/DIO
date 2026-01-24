# Introdução às Boas Práticas de Programação em C

Este projeto demonstra um exemplo didático de boas práticas de programação na linguagem C, utilizando um programa simples que calcula a área e o perímetro de um retângulo.

## Boas Práticas Demonstradas:

1.  **Nomes Descritivos:** Variáveis, funções e constantes possuem nomes claros que indicam seu propósito (ex: `lerDimensao`, `MIN_DIMENSAO`, `MAX_TENTATIVAS`).
2.  **Modularidade (Funções):** O problema foi dividido em funções pequenas e focadas, cada uma com uma responsabilidade única (ex: `lerDimensao` para entrada, `calcularArea` para cálculo, `exibirResultados` para saída). Isso torna o código mais fácil de entender, testar e manter.
3.  **Comentários Explicativos:** Comentários são usados para explicar o *porquê* de certas decisões ou lógicas complexas, não apenas o *que* o código faz.
4.  **Uso de Constantes:** Valores fixos são definidos como constantes (`#define` ou `const`), evitando "números mágicos" e facilitando futuras alterações (ex: `MIN_DIMENSAO`, `MAX_DIMENSAO`).
5.  **Validação de Entrada:** A função `lerDimensao` valida se a entrada do usuário é um número e se está dentro de um intervalo aceitável, solicitando nova entrada em caso de erro.
6.  **Tratamento de Erros:** O programa verifica o retorno de funções como `scanf` e `lerDimensao` para identificar e reagir a entradas inválidas ou falhas, encerrando o programa de forma controlada (`EXIT_FAILURE`).
7.  **Limpeza do Buffer de Entrada:** Em caso de entrada não numérica, o buffer do `stdin` é limpo (`while (getchar() != '\n');`) para evitar que entradas inválidas afetem leituras subsequentes.
8.  **Função `main()` Clara:** A função `main` atua como um orquestrador, chamando as outras funções em uma sequência lógica e lidando com o fluxo principal do programa e o tratamento de erros de alto nível.
9.  **Retorno de `main()`:** `EXIT_SUCCESS` (0) para sucesso e `EXIT_FAILURE` (1) para indicar que o programa terminou com um erro.

## Como Compilar e Executar:

1.  **Navegue até a pasta:**
    ```bash
    cd Introdução-as-Boas-Praticas-de-Programacao-em-C
    ```
2.  **Compile o código:**
    ```bash
    gcc boas_praticas.c -o boas_praticas
    ```
3.  **Execute o programa:**
    ```bash
    ./boas_praticas
    ```

O programa solicitará a largura e o comprimento do retângulo, validando as entradas e exibindo a área e o perímetro calculados.
