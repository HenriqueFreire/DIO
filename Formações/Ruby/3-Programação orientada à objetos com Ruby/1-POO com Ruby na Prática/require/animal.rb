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

animal = Animal.new

animal.dormir