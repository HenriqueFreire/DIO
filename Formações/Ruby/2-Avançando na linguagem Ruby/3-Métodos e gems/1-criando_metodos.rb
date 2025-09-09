# Tópicos da nossa aula

# O que são métodos?
# Método é uma forma de organizar funções específicas em um programa.
# O método permite a reutilização de código, ou seja, evita escrever o mesmo código diversas vezes.

# Criando métodos.
# Para definir o método:
# 1. utilizamos a palavra def
# 2. seguida do nome do método (escolhido por você)
# 3. na sequência definimos um conjunto de expressões
# 4. para finalizar esse bloco use a palavra end
# 5. para executar o método basta escrever seu nome

def oi
  puts 'Oi dev!'
end

oi

# Entendendo o que são parâmentros e usando.
# Um método pode depender de um ou mais parâmentros
# Como?
# Ao lado do método que você criou defina os parâmetros (o que deverá aparecer)
# def (nome do método) (parâmentro1, parâmentro2)

def nome (nome, sobrenome)
  puts " Oi #{nome} #{sobrenome}, você é um dev em Ruby!"
end

nome('Henrique', 'Freire')

# Entendendo e usando return (retorno)
# O return sempre resulta na sua última instrução

