# Diferenças entre Lambda e Proc em Ruby

# Tanto `Proc` quanto `lambda` são objetos que encapsulam blocos de código,
# mas eles têm algumas diferenças importantes em seu comportamento.

puts "--- 1. Rigor na Contagem de Argumentos (Arity) ---"

# Procs são mais flexíveis em relação ao número de argumentos passados.
# Se o número de argumentos não corresponder, eles tentarão fazer o melhor possível:
# - Argumentos extras são ignorados.
# - Argumentos ausentes são tratados como `nil`.

my_proc = Proc.new { |a, b, c|
  puts "Proc: a=#{a.inspect}, b=#{b.inspect}, c=#{c.inspect}"
}

puts "\nChamando Proc com diferentes números de argumentos:"
my_proc.call(1)          # b e c serão nil
my_proc.call(1, 2)       # c será nil
my_proc.call(1, 2, 3)    # Todos os argumentos correspondem
my_proc.call(1, 2, 3, 4) # 4 será ignorado

puts "---"

# Lambdas são mais rigorosas em relação ao número de argumentos passados.
# Se o número de argumentos não corresponder ao esperado, um `ArgumentError` será levantado.

my_lambda = -> (a, b, c) {
  puts "Lambda: a=#{a.inspect}, b=#{b.inspect}, c=#{c.inspect}"
}

puts "\nChamando Lambda com diferentes números de argumentos:"
my_lambda.call(1, 2, 3) # Todos os argumentos correspondem

# As linhas abaixo levantariam um ArgumentError:
# my_lambda.call(1, 2) # ArgumentError: wrong number of arguments (given 2, expected 3)
# my_lambda.call(1)  # ArgumentError: wrong number of arguments (given 1, expected 3)
# my_lambda.call(1, 2, 3, 4) # ArgumentError: wrong number of arguments (given 4, expected 3)

puts "---"

puts "--- 2. Comportamento do `return` ---"

# O comportamento do `return` dentro de um Proc e uma Lambda é uma das diferenças mais significativas.

# `return` em um Proc:
# Quando `return` é usado dentro de um Proc, ele tenta retornar do *método onde o Proc foi definido*.
# Se o Proc não for chamado dentro de um método, ele levantará um `LocalJumpError`.

def method_with_proc
  puts "Entrando em method_with_proc"
  my_proc_return = Proc.new { puts "Dentro do Proc"; return "Retorno do Proc" }
  my_proc_return.call
  puts "Esta linha nunca será executada se o Proc for chamado e retornar"
end

puts "\nChamando method_with_proc:"
puts method_with_proc

puts "---"

# `return` em uma Lambda:
# Quando `return` é usado dentro de uma Lambda, ele retorna o controle *apenas para a Lambda em si*,
# e não para o método que a chamou. O fluxo de execução continua no método chamador.

def method_with_lambda_return
  puts "Entrando em method_with_lambda_return"
  my_lambda_return = -> { puts "Dentro da Lambda"; return "Retorno da Lambda" }
  puts "Antes de chamar a lambda"
  result = my_lambda_return.call
  puts "Resultado da lambda: #{result}"
  puts "Depois de chamar a lambda"
  return "Retorno do método"
end

puts "\nChamando method_with_lambda_return:"
puts method_with_lambda_return

puts "---"

puts "--- Resumo ---"
puts "Proc: Menos rigoroso com argumentos, `return` sai do método definidor."
puts "Lambda: Mais rigorosa com argumentos, `return` sai apenas da lambda."
