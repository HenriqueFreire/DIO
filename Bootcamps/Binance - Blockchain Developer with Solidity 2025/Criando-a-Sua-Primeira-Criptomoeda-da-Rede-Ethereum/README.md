# ZeDaManga (ZDM) Token

Este é um token compatível com o padrão **ERC-20** da rede Ethereum. Abaixo estão explicadas as principais funcionalidades que ele possui.

## Funções Disponíveis

Como o contrato herda do padrão `ERC20` da OpenZeppelin, ele já vem com todas as funções essenciais prontas para uso:

### Informações do Token
- **`name()`**: Retorna o nome do token (`"ZeDaManga"`).
- **`symbol()`**: Retorna o símbolo do token (`"ZDM"`).
- **`decimals()`**: Retorna quantas casas decimais o token usa (padrão `18`).
- **`totalSupply()`**: Retorna a quantidade total de tokens em existência. No nosso caso, fixada em **1.000.000 ZDM**.

### Movimentação e Saldos
- **`balanceOf(address account)`**: Mostra quantos tokens uma carteira (`account`) possui.
- **`transfer(address to, uint256 amount)`**: Envia `amount` tokens da sua carteira para a carteira `to`.
    - *Nota*: Você precisa ter saldo suficiente para a transação ocorrer.

### Aprovações (Sistema de "Mesada")
O padrão ERC-20 permite que você autorize outras pessoas (ou contratos) a gastarem seus tokens:
- **`approve(address spender, uint256 amount)`**: Autoriza o `spender` a gastar até `amount` dos seus tokens.
- **`allowance(address owner, address spender)`**: Verifica quanto o `spender` ainda tem permissão para gastar da carteira do `owner`.
- **`transferFrom(address from, address to, uint256 amount)`**: Usada por um terceiro (o `spender`) para transferir tokens da carteira `from` para `to`, descontando da "mesada" autorizada.

## Características Especiais
Nosso contrato tem uma característica definida no momento da criação (Deploy):

```solidity
constructor() ERC20("ZeDaManga", "ZDM") {
    _mint(msg.sender, 1000000 * 10 ** decimals());
}
```

- **Mint Inicial**: Assim que o contrato é implantado, ele cria ("crunha") 1 milhão de tokens e os envia para a carteira de quem fez o deploy.
- **Suprimento Fixo**: Como não criamos uma função pública de `mint` adicional, a quantidade de tokens é fixa e não pode ser aumentada posteriormente (deflacionário/fixo).
