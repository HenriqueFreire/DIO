# Captura os pedidos do usuário
pedidos = [
  {
    nome: gets.chomp,
    tipo: gets.chomp,
    distancia: gets.to_f
  },
  {
    nome: gets.chomp,
    tipo: gets.chomp,
    distancia: gets.to_f
  },
  {
    nome: gets.chomp,
    tipo: gets.chomp,
    distancia: gets.to_f
  }
]

# Usando o método "reduce" para encontrar o pedido com a menor distância.
pedido_mais_proximo = pedidos.reduce do |mais_proximo, pedido_atual|
  if pedido_atual[:distancia] < mais_proximo[:distancia]
    pedido_atual
  else
    mais_proximo
  end
end

# Imprime a saída de acordo com o enunciado.
puts "O pedido mais próximo é o de #{pedido_mais_proximo[:nome]}, do tipo #{pedido_mais_proximo[:tipo]}"
