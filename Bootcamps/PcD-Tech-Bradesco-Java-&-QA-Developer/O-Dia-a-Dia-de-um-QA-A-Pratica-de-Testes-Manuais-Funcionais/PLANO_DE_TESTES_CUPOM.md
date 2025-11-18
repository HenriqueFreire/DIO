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
