class Carrinho
  def initialize
    @itens = {} # Stores {Produto => quantidade}
  end

  def adicionar_produto(produto, quantidade = 1)
    if @itens.key?(produto)
      @itens[produto] += quantidade
    else
      @itens[produto] = quantidade
    end
    puts "#{quantidade}x #{produto.nome} adicionado(s) ao carrinho."
  end

  def remover_produto(produto, quantidade = nil)
    if @itens.key?(produto)
      if quantidade.nil? || quantidade >= @itens[produto]
        @itens.delete(produto)
        puts "#{produto.nome} removido(s) completamente do carrinho."
      else
        @itens[produto] -= quantidade
        puts "#{quantidade}x #{produto.nome} removido(s) do carrinho."
      end
    else
      puts "#{produto.nome} não encontrado no carrinho."
    end
  end

  def total
    @itens.sum { |produto, quantidade| produto.preco * quantidade }
  end

  def exibir_carrinho
    if @itens.empty?
      puts "O carrinho está vazio."
    else
      puts "--- Seu Carrinho ---"
      @itens.each do |produto, quantidade|
        puts "#{quantidade}x #{produto.nome} (R$#{'%.2f' % produto.preco} cada) - Subtotal: R$#{'%.2f' % (produto.preco * quantidade)}"
      end
      puts "--------------------"
      puts "Total: R$#{'%.2f' % total}"
      puts "--------------------"
    end
  end
end
