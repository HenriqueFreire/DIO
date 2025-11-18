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
