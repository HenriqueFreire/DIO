# Herança

# Para herdar características de outra classe, 
#adicione na frente do nome de uma classe filha 
#o símbolo de menor e depois o nome da classe pai

#exemplo animal

class Animal
  def dormir
    'ZZZZZZ'
  end

  def pular
    'tóin tóin'
  end
end

class Gato < Animal
  def miar
    'miau'
  end
end

gato = Gato.new

puts gato.miar
puts gato.dormir

