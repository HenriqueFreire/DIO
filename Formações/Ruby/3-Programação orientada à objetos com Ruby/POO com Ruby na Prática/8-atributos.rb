# Como você já sabe objetos possuem informações e comportamentos
# vimos uma parte deste conteúdo utilizando métodos para representar comportamentos
# Agora vamos aprender a adicionar e recuperar informações de um objeto

# Ruby disponibiliza um método chamado attr_ accessor que cria os
# métodos var e var- para todos os atributos declarados.

class Aluno
  attr_accessor :nome, :idade
end

aluno = Aluno.new

aluno.nome = 'Henrique'
puts aluno.nome

aluno.idade = '29 anos'
puts aluno.idade

aluno.cidade = 'São Paulo'
puts aluno.cidade