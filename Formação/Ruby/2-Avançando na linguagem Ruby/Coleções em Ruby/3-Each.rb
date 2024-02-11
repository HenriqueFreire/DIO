# Percorr uma coleção de forma parecida ao for,
# mas não sobrescrevendo o valor de variáveis fora da estrutura de repetição

# primeiro vamos usar o EACH(CADA) em um ARRAY

# Criar array
nomes = ['maria', 'João', 'Marcelo']

nome = 'Mariana'

nomes.each do |nome|
puts nome
end

# Vamos usar each com hash
cursos = {'Curso 1'=>'Ruby', 'Curso2'=>'Go', 'Curso 3'=>'Python'}

cursos.each do |key,value|
puts "#{key} #{value}"
end
