# Proc é um objeto que encapsula um bloco de código.
# Ele pode ser armazenado em uma variável, passado como argumento para métodos e chamado posteriormente.

# Exemplo 1: Proc simples
# Cria um Proc que imprime uma mensagem.
my_proc = Proc.new do
  puts "Olá, eu sou um Proc!"
end

# Chama o Proc.
my_proc.call

puts "---"

# Exemplo 2: Proc com argumentos
# Procs não são rigorosos em relação ao número de argumentos passados.
# Argumentos extras são ignorados e argumentos ausentes são tratados como `nil`.
my_proc_with_args = Proc.new { |name, age| puts "Olá, #{name}! Você tem #{age} anos." }

my_proc_with_args.call("João", 30)
my_proc_with_args.call("Maria") # age será nil
my_proc_with_args.call("Pedro", 25, "extra") # "extra" será ignorado

puts "---"

# Exemplo 3: Proc passado para um método
# Você pode passar um Proc para um método usando o operador `&`.
def execute_proc(a_proc)
  a_proc.call
end

my_proc_to_pass = Proc.new { puts "Este Proc foi passado para um método!" }
execute_proc(my_proc_to_pass)

puts "---"

# Exemplo 4: Comportamento do `return` em Procs
# O `return` dentro de um Proc sai do método onde o Proc foi definido,
# não apenas do Proc em si.
def method_with_proc_return
  my_proc_return = Proc.new { return "Retorno do Proc" }
  my_proc_return.call
  puts "Esta linha nunca será executada se o Proc for chamado"
end

puts method_with_proc_return

puts "---"

# Exemplo 5: Criando um Proc a partir de um bloco
# Você pode converter um bloco em um Proc usando `&` na definição do método.
def convert_block_to_proc(&block)
  block.call
end

convert_block_to_proc { puts "Este é um bloco convertido em Proc!" }
