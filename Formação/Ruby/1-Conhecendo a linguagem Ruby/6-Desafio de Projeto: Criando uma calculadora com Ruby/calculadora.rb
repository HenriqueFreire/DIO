loop do
  puts "Qual calculo deseja realizar?"
  puts "1 - para soma"
  puts "2 - para subtração"
  puts "3 - para multiplicação"
  puts "4 - para divisão"
  puts "0 - para sair"

  option = gets.chomp.to_i

  if option > 0 && option < 5
    puts "Digite o primeiro número:"
    number1 = gets.chomp.to_f

    puts "Digite o segundo número:"
    number2 = gets.chomp.to_f

    case option
      when 1 
        puts "A soma entre #{number1} e #{number2} é #{number1 + number2}" 
      when 2 
        puts "A subtração entre #{number1} e #{number2} é #{number1 - number2}"
      when 3 
        puts "A multiplicação entre #{number1} e #{number2} é #{number1 * number2}"
      when 4 
        puts "A divisão entre #{number1} e #{number2} é #{number1 / number2}"
    end
    elsif option == 0
      break
    else
      puts "Opcão inválida!
    end
end
