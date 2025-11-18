# Relatório Completo do Ciclo de QA: Funcionalidade de Cupom

---
---

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

---
---

# Plano de Testes: Funcionalidade de Cupom de Desconto

## 1. Visão Geral

Este documento detalha o plano de testes para a nova funcionalidade "Aplicar Cupom de Desconto" no carrinho de compras do e-commerce Swagglag Shopping.

**User Story:**
- **Como um** cliente,
- **Eu quero** poder aplicar um código de cupom de desconto no meu carrinho de compras,
- **Para que** eu possa obter um valor final mais baixo na minha compra.

## 2. Escopo do Teste

- **Em Escopo:**
  - Validação de cupons (válidos, inválidos, expirados).
  - Aplicação de desconto (percentual e valor fixo).
  - Exibição correta dos valores no carrinho (subtotal, desconto, total).
  - Mensagens de erro e sucesso para o usuário.
  - Remoção de um cupom aplicado.
  - Validação da interface do usuário (campo de entrada, botão).

- **Fora de Escopo:**
  - Testes de performance da aplicação do cupom.
  - Criação de cupons no painel administrativo.
  - Testes de segurança contra injeção de código no campo do cupom.

## 3. Estratégia de Teste

Os testes serão manuais e funcionais, focados em validar todos os critérios de aceite da User Story. Serão criados cenários de teste positivos (caminho feliz) e negativos (cenários de erro) para garantir a robustez da funcionalidade.

## 4. Casos de Teste

| ID    | Título do Teste                                  | Pré-condições                                                                 | Passos de Execução                                                                                                                               | Resultado Esperado                                                                                                                              |
|-------|--------------------------------------------------|-------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| **CT01**  | **Positivo:** Aplicar cupom de percentual válido     | 1. O usuário está logado.<br>2. O carrinho contém pelo menos um item.<br>3. Existe um cupom válido de 10% (ex: `PROMO10`). | 1. Navegar para a página do carrinho.<br>2. Inserir `PROMO10` no campo de cupom.<br>3. Clicar em "Aplicar".                                         | O desconto de 10% é calculado sobre o subtotal e exibido. O valor total do pedido é atualizado. Uma mensagem "Cupom aplicado com sucesso!" é exibida. |
| **CT02**  | **Positivo:** Aplicar cupom de valor fixo válido       | 1. O usuário está logado.<br>2. O carrinho contém itens somando mais de R$50.<br>3. Existe um cupom válido de R$20 (ex: `VALE20`). | 1. Navegar para a página do carrinho.<br>2. Inserir `VALE20` no campo de cupom.<br>3. Clicar em "Aplicar".                                          | O desconto de R$20 é subtraído do subtotal. O valor total do pedido é atualizado. Uma mensagem de sucesso é exibida.                               |
| **CT03**  | **Positivo:** Remover um cupom aplicado              | 1. O usuário aplicou com sucesso um cupom (`PROMO10`).                        | 1. Na página do carrinho, clicar no botão/link "Remover Cupom".                                                                                  | O desconto é removido. O valor total do pedido é recalculado para o valor original (sem desconto).                                              |
| **CT04**  | **Negativo:** Aplicar cupom com código inválido      | 1. O usuário está no carrinho com itens.                                      | 1. Inserir um código de cupom que não existe (ex: `INVALIDO`).<br>2. Clicar em "Aplicar".                                                          | Uma mensagem de erro "Cupom inválido ou expirado" é exibida. Nenhum desconto é aplicado.                                                        |
| **CT05**  | **Negativo:** Aplicar cupom expirado                 | 1. O usuário está no carrinho com itens.<br>2. Existe um cupom com data de validade expirada (ex: `EXPIRADO`). | 1. Inserir `EXPIRADO` no campo de cupom.<br>2. Clicar em "Aplicar".                                                                               | Uma mensagem de erro "Cupom inválido ou expirado" é exibida. Nenhum desconto é aplicado.                                                        |
| **CT06**  | **Negativo:** Tentar aplicar cupom em carrinho vazio | 1. O carrinho de compras está vazio.                                          | 1. Navegar para a página do carrinho.<br>2. Tentar inserir um cupom.                                                                             | O campo para inserir o cupom deve estar desabilitado ou, se habilitado, ao aplicar, deve exibir a mensagem "Seu carrinho está vazio".             |
| **CT07**  | **Negativo:** Tentar aplicar um segundo cupom        | 1. O usuário já aplicou um cupom com sucesso.                                 | 1. Tentar inserir um segundo código de cupom no campo.<br>2. Clicar em "Aplicar".                                                                | Uma mensagem de erro "Apenas um cupom pode ser usado por pedido" é exibida. O primeiro cupom permanece aplicado.                                |
| **CT08**  | **UI:** Verificar elementos da interface             | 1. O usuário está na página do carrinho.                                      | 1. Observar a seção de cupom da página.                                                                                                          | O campo de texto para inserção do cupom e o botão "Aplicar" devem estar visíveis e corretamente alinhados.                                     |

---
---

# Log de Execução de Testes: Cupom de Desconto

**Data:** 17/11/2025
**Executor:** Analista de QA
**Ambiente:** Staging (Homologação)

Este documento registra os resultados da execução dos casos de teste definidos no arquivo `PLANO_DE_TESTES_CUPOM.md`.

| ID    | Título do Teste                                  | Resultado | Observações                                                                                                                                                                                          |
|-------|--------------------------------------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **CT01**  | **Positivo:** Aplicar cupom de percentual válido     | **PASSOU**  | O cupom `PROMO10` foi aplicado corretamente. O cálculo do desconto e o total final estão corretos. A mensagem de sucesso foi exibida.                                                              |
| **CT02**  | **Positivo:** Aplicar cupom de valor fixo válido       | **FALHOU**  | **BUG ENCONTRADO.** Ao aplicar o cupom `VALE20` em um carrinho com subtotal de R$100,00, o desconto aplicado foi de R$2,00 em vez de R$20,00. O valor total ficou R$98,00, mas o esperado era R$80,00. |
| **CT03**  | **Positivo:** Remover um cupom aplicado              | **PASSOU**  | O cupom `PROMO10` foi removido com sucesso e o valor do pedido foi recalculado corretamente para o original.                                                                                        |
| **CT04**  | **Negativo:** Aplicar cupom com código inválido      | **PASSOU**  | Ao inserir o código `INVALIDO`, a mensagem de erro "Cupom inválido ou expirado" foi exibida como esperado.                                                                                         |
| **CT05**  | **Negativo:** Aplicar cupom expirado                 | **PASSOU**  | Ao inserir o código `EXPIRADO`, a mensagem de erro correta foi exibida.                                                                                                                              |
| **CT06**  | **Negativo:** Tentar aplicar cupom em carrinho vazio | **PASSOU**  | O campo de cupom estava visível, mas ao tentar aplicar, a mensagem "Seu carrinho está vazio" foi exibida. Comportamento aceitável.                                                                 |
| **CT07**  | **Negativo:** Tentar aplicar um segundo cupom        | **PASSOU**  | Após aplicar `PROMO10`, tentei aplicar `VALE20`. A mensagem "Apenas um cupom pode ser usado por pedido" foi exibida e o primeiro cupom permaneceu ativo.                                           |
| **CT08**  | **UI:** Verificar elementos da interface             | **PASSOU**  | O campo de texto e o botão "Aplicar" estão visíveis e funcionais.                                                                                                                                    |

### Resumo da Execução
- **Total de Testes Executados:** 8
- **Testes com Sucesso (PASSOU):** 7
- **Testes com Falha (FALHOU):** 1
- **Bugs Abertos:** 1 (Referente ao CT02)

O próximo passo é detalhar o bug encontrado no CT02 em um relatório de bug formal para a equipe de desenvolvimento.

---
---

## Ciclo de Teste de Regressão e Confirmação

**Data:** 18/11/2025
**Executor:** Analista de QA
**Ambiente:** Staging (Homologação)
**Build/Versão:** 1.2.1 (com a correção do BUG-001)

| ID    | Título do Teste                                  | Resultado | Observações                                                                                                                                                           |
|-------|--------------------------------------------------|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **CT02**  | **(Re-teste)** Aplicar cupom de valor fixo válido    | **PASSOU**  | **BUG CORRIGIDO.** Ao aplicar o cupom `VALE20` em um carrinho de R$100,00, o desconto foi de R$20,00 e o total final foi R$80,00, como esperado. A correção foi validada. |
| **CT01**  | **(Regressão)** Aplicar cupom de percentual válido | **PASSOU**  | A funcionalidade de cupom de percentual não foi afetada pela correção. O cálculo continua correto.                                                                  |
| **CT03**  | **(Regressão)** Remover um cupom aplicado          | **PASSOU**  | A funcionalidade de remover o cupom não foi afetada e continua funcionando como esperado.                                                                           |

### Resumo Final
- **Status do BUG-001:** Fechado/Corrigido.
- **Resultado do Ciclo de Regressão:** Todos os testes passaram.
- **Decisão de QA:** A funcionalidade "Cupom de Desconto" está **APROVADA** e tem a luz verde (green light) do time de QA para ser enviada para o ambiente de Produção.

---
---

# Relatório de Bug: BUG-001

**Título:** [Carrinho] Cálculo do desconto para cupom de valor fixo está incorreto

**Produto:** Swagglag Shopping
**Funcionalidade:** Cupom de Desconto

**Prioridade:** Alta (Afeta diretamente a funcionalidade de compra e o valor final para o cliente)
**Severidade:** Alta (Causa um comportamento incorreto em uma funcionalidade crítica de negócio)

**Executor do Teste:** Analista de QA
**Data do Encontro:** 17/11/2025
**Ambiente:** Staging (Homologação)
**Build/Versão:** 1.2.0

---

### **Passos para Reproduzir:**

1.  Faça login no site com um usuário válido.
2.  Adicione qualquer produto ao carrinho de compras, garantindo que o subtotal seja igual ou superior a R$100,00. (Ex: Produto "Awesome T-Shirt" de R$100,00).
3.  Navegue até a página do carrinho de compras.
4.  No campo "Código do Cupom", insira o código de um cupom de valor fixo válido: `VALE20`.
5.  Clique no botão "Aplicar".
6.  Observe o valor do desconto e o valor total do pedido.

---

### **Resultado Esperado:**

- O sistema deveria aplicar um desconto de **R$20,00** sobre o subtotal.
- O valor total do pedido deveria ser atualizado para **R$80,00** (R$100,00 - R$20,00).
- A linha de resumo do pedido deveria mostrar "Desconto: -R$20,00".

---

### **Resultado Atual (Comportamento do Bug):**

- O sistema aplicou um desconto de apenas **R$2,00**.
- O valor total do pedido foi incorretamente atualizado para **R$98,00**.
- A linha de resumo do pedido mostrou "Desconto: -R$2,00".

---

### **Anexos / Evidências:**

*(Neste ponto, o QA normalmente anexaria um screenshot da tela mostrando o cálculo errado. Como estamos em texto, descrevemos a imagem)*

**`[Screenshot: tela_carrinho_bug_vale20.png]`**
- A imagem mostra o carrinho com um item de R$100,00.
- O cupom `VALE20` está aplicado.
- A linha de desconto exibe "-R$2,00".
- O total do pedido exibe "R$98,00".

---

### **Notas Adicionais:**

- O problema parece estar relacionado à forma como o valor do cupom é lido ou processado, talvez tratando "20" como "2.0" ou dividindo por 10 indevidamente.
- O mesmo problema não ocorre com cupons de porcentagem (CT01 executado com sucesso).
