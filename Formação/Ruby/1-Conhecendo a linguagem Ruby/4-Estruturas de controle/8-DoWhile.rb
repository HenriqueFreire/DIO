# - Do/While(fazer enquanto): Cria um laço de 
# repetição que só irá parar quando uma instrução
# BREAK for verdadeira.
count = 1

loop do
  puts count
  if count == 150
    break
  end
  count += 1
end
  