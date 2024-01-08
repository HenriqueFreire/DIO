#  Case(caso): Parecido com o "if", 
# mas quando há diversas condições

puts 'Digite seu mês de nascimento:'
mes = gets.chomp.to_i

# definir casos

case mes
when 1..3 # intervalo
  puts 'Você nasceu no primeiro trimestre do ano'
when 4..6 # intervalo
  puts 'Você nasceu no segundo trimestre do ano'
when 7..9 # intervalo
  puts 'Você nasceu no terceiro trimestre do ano'
when 10..12 # intervalo
  puts 'Você nasceu no quarto trimestre do ano'
else
  puts 'Valor inválido!'
end