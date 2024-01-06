# Tipos de dados
# - Classicação dos dados que iremos utilizar em nosso programa.
# - Tipagem Dinâmica: Quem vai classificar é o próprio Ruby.

# Quais são?
# - Integer: Números inteiros.
# - Float: Números decimais.
# - Boolean: Verdadeiro ou falso. 
# - String: Conjunto de caracteres(escrever textos)
# - Array: Permite armazenar uma lista ordenada, utilize colchetes[]
# - Symbol: Assemelha-se a String, mas ele é imutavel, isto é, um 
# objeto que ocupa sempre o mesmo espaçõ na memória, use : (maisnome) 
# para representa-lo.
# - Hash: Coleção de dados organizados por chave única e seus valores,
# use chaves {} para representa-lo.

#integer
a = 10
puts a.class

# Float
b = 13.2
puts b.class

# String
c = "Ruby"
puts c.class

# Array
d = ["oi", "tudo", "bem"]
puts d.class
d[0]

# Symbol
e = :teste
e.class
e.object_id

# Hash
f = {linguagem: "Ruby", framework: "Ruby on Rails"}
f.class
f.[:linguagem]
