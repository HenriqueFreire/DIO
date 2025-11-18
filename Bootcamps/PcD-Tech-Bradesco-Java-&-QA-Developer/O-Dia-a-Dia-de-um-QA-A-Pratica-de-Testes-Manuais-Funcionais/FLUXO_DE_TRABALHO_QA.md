# Documentação do Fluxo de Trabalho de QA para o E-commerce Swagglag Shopping

## 1. Introdução

Este documento descreve o processo e a metodologia de Quality Assurance (QA) a serem seguidos no desenvolvimento do e-commerce Swagglag Shopping. O objetivo é garantir que o software atenda aos requisitos de negócios e de usuário, oferecendo uma experiência de alta qualidade, livre de defeitos críticos.

## 2. Tipos de Testes

Para o projeto Swagglag Shopping, focaremos nos seguintes tipos de testes:

### 2.1. Testes Manuais
Testes executados por um analista de QA sem o uso de ferramentas de automação. São essenciais para avaliar a usabilidade e a experiência do usuário (UX).

### 2.2. Testes Funcionais
Verificam se as funcionalidades do sistema se comportam conforme o esperado nas especificações. O objetivo é validar as ações e operações do software.

**Exemplos para o Swagglag Shopping:**
- Um usuário consegue fazer login com credenciais válidas?
- A busca de produtos retorna resultados relevantes?
- É possível adicionar um item ao carrinho de compras?
- O processo de checkout funciona de ponta a ponta?

## 3. Ciclo de Vida do Teste de Software (STLC)

Seguiremos as fases do STLC para garantir uma cobertura de teste completa e organizada.

#### Fase 1: Planejamento de Testes
- **Objetivo:** Definir o escopo, os objetivos, os recursos e o cronograma dos testes.
- **Atividades:**
  - Identificar as funcionalidades a serem testadas (login, catálogo, carrinho, checkout, etc.).
  - Definir os tipos de testes a serem executados.
  - Estimar o esforço e os recursos necessários.

#### Fase 2: Análise de Requisitos
- **Objetivo:** Analisar os requisitos do sistema para entender o que precisa ser testado.
- **Atividades:**
  - Revisar a documentação de requisitos do Swagglag Shopping.
  - Esclarecer dúvidas com a equipe de desenvolvimento e de negócios.
  - Identificar critérios de aceite para cada funcionalidade.

#### Fase 3: Desenvolvimento de Casos de Teste
- **Objetivo:** Criar os casos de teste detalhados que serão executados.
- **Atividades:**
  - Escrever passos claros e concisos para cada teste.
  - Definir os resultados esperados para cada passo.
  - Mapear os casos de teste aos requisitos.

#### Fase 4: Configuração do Ambiente de Teste
- **Objetivo:** Preparar o ambiente necessário para a execução dos testes.
- **Atividades:**
  - Garantir que o ambiente de homologação (staging) esteja estável.
  - Preparar a massa de dados necessária (contas de usuário, produtos de teste, etc.).

#### Fase 5: Execução dos Testes
- **Objetivo:** Executar os casos de teste e registrar os resultados.
- **Atividades:**
  - Seguir os passos definidos nos casos de teste.
  - Comparar os resultados obtidos com os resultados esperados.
  - Documentar qualquer desvio como um defeito.

#### Fase 6: Encerramento do Ciclo de Teste
- **Objetivo:** Avaliar os resultados e preparar o relatório final.
- **Atividades:**
  - Verificar se todos os testes planejados foram executados.
  - Criar um relatório de resumo dos testes, incluindo as métricas definidas.
  - Realizar uma reunião de balanço com a equipe.

## 4. Cenários de Teste para o Swagglag Shopping

A seguir, exemplos de cenários de teste de alta prioridade.

| ID | Cenário de Teste | Passos de Execução | Resultado Esperado |
|----|------------------|-------------------|--------------------|
| 1  | Login com Sucesso | 1. Navegar para a página de login.<br>2. Inserir usuário e senha válidos.<br>3. Clicar em "Login". | O usuário é redirecionado para a página inicial, logado em sua conta. |
| 2  | Login com Senha Inválida | 1. Navegar para a página de login.<br>2. Inserir um usuário válido e uma senha inválida.<br>3. Clicar em "Login". | Uma mensagem de erro "Usuário ou senha inválidos" é exibida. |
| 3  | Busca de Produto | 1. Ir para a página inicial.<br>2. Digitar o nome de um produto existente na barra de busca.<br>3. Pressionar Enter. | A página de resultados de busca exibe o produto pesquisado. |
| 4  | Adicionar Produto ao Carrinho | 1. Navegar para a página de um produto.<br>2. Clicar no botão "Adicionar ao Carrinho". | O produto é adicionado ao carrinho e o ícone do carrinho é atualizado com a quantidade. |
| 5  | Finalizar Compra | 1. Acessar o carrinho de compras.<br>2. Clicar em "Finalizar Compra".<br>3. Preencher os dados de entrega e pagamento.<br>4. Clicar em "Confirmar Pedido". | O pedido é confirmado e uma página de sucesso da compra é exibida. |

## 5. Relatório de Bugs (Defeitos)

Qualquer comportamento inesperado deve ser reportado como um bug.

### Estrutura de um Relatório de Bug:
- **Título:** Um resumo claro e conciso do problema.
- **Prioridade/Severidade:** (Ex: Alta, Média, Baixa) - Impacto no negócio e no sistema.
- **Ambiente:** Onde o bug foi encontrado (Ex: Staging, Produção).
- **Passos para Reproduzir:** Sequência exata de ações para recriar o bug.
- **Resultado Esperado:** O que o sistema deveria ter feito.
- **Resultado Atual:** O que o sistema fez de fato.
- **Anexos:** Screenshots, vídeos ou logs que ajudem a ilustrar o problema.

### Exemplo de Relatório de Bug:
- **Título:** [Checkout] Mensagem de erro não é exibida ao tentar finalizar a compra com o carrinho vazio.
- **Prioridade:** Média
- **Passos para Reproduzir:**
  1. Navegar para o site Swagglag Shopping.
  2. Garantir que o carrinho de compras esteja vazio.
  3. Clicar no ícone do carrinho.
  4. Clicar no botão "Finalizar Compra".
- **Resultado Esperado:** O botão "Finalizar Compra" deveria estar desabilitado ou uma mensagem como "Seu carrinho está vazio" deveria ser exibida.
- **Resultado Atual:** O usuário é redirecionado para a página de checkout, que fica em um estado de carregamento infinito.

## 6. Ferramentas Sugeridas

- **Gerenciamento de Testes e Bugs:** Jira, Trello, Azure DevOps.
- **Documentação:** Confluence, Notion.

## 7. Métricas de Teste

- **Número de Casos de Teste:** Total planejado vs. executado.
- **Densidade de Defeitos:** Número de defeitos encontrados por funcionalidade.
- **Cobertura de Requisitos:** Percentual de requisitos que possuem casos de teste associados.
- **Taxa de Rejeição de Bugs:** Percentual de bugs reportados que foram rejeitados pela equipe de desenvolvimento (considerados inválidos).
