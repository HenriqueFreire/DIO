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
