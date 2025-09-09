require_relative 'produto'
require_relative 'carrinho'

# Cria alguns produtos de exemplo
produtos_disponiveis = [
  Produto.new("Camiseta", 49.90),
  Produto.new("Calça Jeans", 99.90),
  Produto.new("Tênis Esportivo", 149.90),
  Produto.new("Meia (par)", 9.90),
  Produto.new("Boné", 29.90)
]

carrinho = Carrinho.new

loop do
  puts "\n--- Menu Principal ---"
  puts "1. Ver Produtos Disponíveis"
  puts "2. Adicionar Produto ao Carrinho"
  puts "3. Ver Carrinho"
  puts "4. Remover Produto do Carrinho"
  puts "5. Finalizar Compra (Ver Total)"
  puts "6. Sair"
  print "Escolha uma opção: "
  
  opcao = gets.chomp.to_i

  case opcao
  when 1
    puts "\n--- Produtos Disponíveis ---"
    produtos_disponiveis.each_with_index do |produto, index|
      puts "#{index + 1}. #{produto.to_s}"
    end
  when 2
    puts "\n--- Adicionar Produto ---"
    puts "Digite o número do produto que deseja adicionar:"
    produtos_disponiveis.each_with_index do |produto, index|
      puts "#{index + 1}. #{produto.nome}"
    end
    print "Número do produto: "
    escolha_produto = gets.chomp.to_i
    
    if escolha_produto > 0 && escolha_produto <= produtos_disponiveis.length
      produto_selecionado = produtos_disponiveis[escolha_produto - 1]
      print "Quantidade (padrão 1): "
      quantidade = gets.chomp.to_i
      quantidade = 1 if quantidade <= 0
      carrinho.adicionar_produto(produto_selecionado, quantidade)
    else
      puts "Opção inválida."
    end
  when 3
    carrinho.exibir_carrinho
  when 4
    puts "\n--- Remover Produto ---"
    if carrinho.instance_variable_get(:@itens).empty?
      puts "O carrinho está vazio. Nada para remover."
    else
      puts "Produtos no carrinho:"
      carrinho.instance_variable_get(:@itens).keys.each_with_index do |produto, index|
        puts "#{index + 1}. #{produto.nome}"
      end
      print "Digite o número do produto que deseja remover: "
      escolha_remover = gets.chomp.to_i
      
      produtos_no_carrinho = carrinho.instance_variable_get(:@itens).keys
      if escolha_remover > 0 && escolha_remover <= produtos_no_carrinho.length
        produto_a_remover = produtos_no_carrinho[escolha_remover - 1]
        print "Quantidade a remover (deixe em branco para remover tudo): "
        quantidade_remover_str = gets.chomp
        quantidade_remover = quantidade_remover_str.empty? ? nil : quantidade_remover_str.to_i
        
        carrinho.remover_produto(produto_a_remover, quantidade_remover)
      else
        puts "Opção inválida."
      end
    end
  when 5
    puts "\n--- Finalizar Compra ---"
    carrinho.exibir_carrinho
    puts "Obrigado por sua compra!"
  when 6
    puts "Saindo do programa. Até mais!"
    break
  else
    puts "Opção inválida. Por favor, tente novamente."
  end
end
