class Produto
  attr_accessor :nome, :preco

  def initialize(nome, preco)
    @nome = nome
    @preco = preco
  end

  def to_s
    "#{nome} (R$#{'%.2f' % preco})"
  end
end
