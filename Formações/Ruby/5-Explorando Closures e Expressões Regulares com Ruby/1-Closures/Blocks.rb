# Um bloco é um trecho de código que pode ser passado para um método.
# O bloco pode ser executado pelo método que o recebe.

# Exemplo 1: Bloco simples
# O método `times` executa o bloco 5 vezes.
5.times do
  puts "Executando o bloco"
end

puts "---"

# Exemplo 2: Bloco com argumentos
# O método `each` itera sobre os elementos do array e passa cada elemento para o bloco.
sum = 0
numbers = [5, 10, 5]
numbers.each {|number| sum += number}
puts "A soma dos números é: #{sum}"

puts "---"

# Exemplo 3: Bloco de múltiplas linhas
# O método `each` itera sobre os pares chave-valor do hash e passa cada par para o bloco.
foo = {2 => 3, 4 => 5}

foo.each do |key, value|
  puts "chave = #{key}"
  puts "valor = #{value}"
  puts "chave * valor = #{key * value}"
  puts "---"
end

# Exemplo 4: Bloco passado para um método
# O `yield` executa o bloco que foi passado para o método.
def foo
  yield
  yield
end

foo { puts "Executando o bloco com yield" }

puts "---"

# Exemplo 5: Verificando se um bloco foi passado
# O método `block_given?` verifica se um bloco foi passado como argumento.
def bar
  if block_given?
    # Chama o bloco
    yield
  else
    puts "Nenhum bloco foi passado como parâmetro"
  end
end

bar
bar { puts "Um bloco foi passado como parâmetro"}

puts "---"

# Exemplo 6: Passando um bloco como referência
# O `&` na definição do método indica que o bloco será passado como uma referência.
# Isso permite que o bloco seja chamado com o método `call`.
def baz(name, &block)
  @name = name
  block.call
end

baz('Leonardo') { puts "Olá #{@name}" }