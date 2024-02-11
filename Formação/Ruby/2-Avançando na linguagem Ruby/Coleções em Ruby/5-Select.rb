# Realiza uma seleção de elementos presentes em uma collection através de uma condição pré-determinados
# traz como resultado somente os valores que passam nesta condição
# muito útil em pesquisas

# Primeiro vamos usar SELECT com ARRAY
# criar uma array
numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9]

selecionados = numeros.select do |n|
  n > 6
end

puts selecionados

# Agora vamos usar o SELECT em um HASH
# Crie uma hash
numeros_hash = {
  0 => 'zero',
  1 => 'um',
  2 => 'dois',
  3 => 'três'
}

puts 'Vamos selecionar chaves(keys) com valores maiores que 0'
selecionados_chave = numeros_hash.select do |key, value|
  key == 0
end

puts selecionados_chave