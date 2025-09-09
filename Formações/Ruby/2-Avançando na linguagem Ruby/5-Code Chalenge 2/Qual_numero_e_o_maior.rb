#Desafios Ruby na DIO têm funções "gets" e "puts" acessíveis globalmente:
# "gets" : lê UMA linha com dado(s) de entrada (inputs) do usuário;
# "puts": imprime um texto de saída (output), pulando linha.
# ".to_i": Converte para int

number1 = gets.to_i
number2 = gets.to_i

if number1 > number2
  puts "O número #{number1} é o maior e o #{number2} é o menor"
else
  puts "O número #{number2} é o maior e o #{number1} é o menor"
end
