# Lambda é um tipo de Proc, mas com algumas diferenças importantes.
# Lambdas são mais rigorosas em relação ao número de argumentos passados.
# Lambdas têm comportamento de retorno diferente de Procs.

# Exemplo 1: Lambda simples
# Cria uma lambda que imprime uma mensagem.
my_lambda = lambda do
  puts "Olá, eu sou uma lambda!"
end

# Chama a lambda.
my_lambda.call

puts "---"

# Exemplo 2: Lambda com argumentos
# Lambdas verificam o número de argumentos. Se o número de argumentos não corresponder,
# um `ArgumentError` será levantado.
my_lambda_with_args = -> (name) do
  puts "Olá, #{name}! Eu sou uma lambda com argumentos."
end

my_lambda_with_args.call("Maria")
# my_lambda_with_args.call # Isso levantaria um ArgumentError

puts "---"

# Exemplo 3: Lambda que retorna um valor
# O `return` dentro de uma lambda retorna o controle para a lambda em si,
# não para o método que a chamou (como acontece com Procs).
def execute_lambda
  my_returning_lambda = -> do
    return "Retorno da lambda"
  end
  puts "Antes de chamar a lambda"
  result = my_returning_lambda.call
  puts result
  puts "Depois de chamar a lambda"
end

execute_lambda

puts "---"

# Exemplo 4: Diferenças entre Lambda e Proc

# Rigor na contagem de argumentos:
# Proc não é rigoroso com o número de argumentos.
my_proc = Proc.new { |a, b| puts "Proc: a=#{a}, b=#{b}" }
my_proc.call(1) # b será nil
my_proc.call(1, 2, 3) # 3 será ignorado

# Lambda é rigorosa com o número de argumentos.
my_lambda_strict = -> (a, b) { puts "Lambda: a=#{a}, b=#{b}" }
my_lambda_strict.call(1, 2)
# my_lambda_strict.call(1) # ArgumentError

puts "---"

# Comportamento do `return`:
# `return` em um Proc sai do método onde o Proc foi definido.
def method_with_proc
  my_proc_return = Proc.new { return "Retorno do Proc" }
  my_proc_return.call
  puts "Esta linha nunca será executada se o Proc for chamado"
end

puts method_with_proc

puts "---"

# `return` em uma Lambda sai apenas da Lambda.
def method_with_lambda
  my_lambda_return = -> { return "Retorno da Lambda" }
  puts "Antes de chamar a lambda"
  result = my_lambda_return.call
  puts result
  puts "Depois de chamar a lambda"
end

method_with_lambda
