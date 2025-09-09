# O método `method_missing` em Ruby

# O `method_missing` é um método especial em Ruby que é invocado quando um objeto
# recebe uma chamada para um método que não existe ou não pode ser encontrado
# na sua hierarquia de herança.
# Ele permite que você intercepte e lide com chamadas de métodos dinamicamente,
# o que é uma ferramenta poderosa para metaprogramação.

puts "--- 1. Comportamento Básico do `method_missing` ---"

# Por padrão, se você chamar um método inexistente, Ruby levantará um `NoMethodError`.
# Exemplo (comentado para não interromper a execução):
# class MinhaClasseSimples
# end
# obj = MinhaClasseSimples.new
# obj.metodo_inexistente # => NoMethodError

puts "---"

puts "--- 2. Implementando `method_missing` ---"

# Você pode sobrescrever `method_missing` em suas classes para definir como
# métodos inexistentes devem ser tratados.

class DelegadorDeChamadas
  def method_missing(method_name, *args, &block)
    puts "\nChamada para o método inexistente: #{method_name}"
    puts "Argumentos: #{args.inspect}"
    puts "Bloco presente: #{block_given?}"

    case method_name
    when :saudar
      "Olá, #{args[0]}!"
    when :somar
      args.sum
    else
      # É crucial chamar `super` para métodos que você não pretende lidar.
      # Isso garante que o `NoMethodError` seja levantado para métodos
      # que realmente não deveriam existir ou ser tratados dinamicamente.
      super
    end
  end
end

delegador = DelegadorDeChamadas.new

puts delegador.saudar("Mundo")
puts delegador.somar(10, 20, 30)

# Este método não será tratado e chamará `super`, resultando em `NoMethodError`.
# puts delegador.metodo_desconhecido

puts "---"

puts "--- 3. Implementando `respond_to_missing?` ---"

# Ao usar `method_missing`, é uma boa prática também implementar `respond_to_missing?`.
# Isso garante que métodos como `respond_to?` e `methods` reflitam corretamente
# os métodos que sua classe pode responder dinamicamente.

class DelegadorComRespondTo
  def method_missing(method_name, *args, &block)
    if method_name.to_s.start_with?("find_by_")
      puts "\nSimulando find_by_#{method_name.to_s.sub("find_by_", "")}: #{args[0]}"
      return "Resultado para #{method_name.to_s.sub("find_by_", "")}: #{args[0]}"
    else
      super
    end
  end

  # `respond_to_missing?` é chamado por `respond_to?` quando o método não é encontrado
  # na tabela de métodos normal do objeto.
  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?("find_by_") || super
  end
end

delegador2 = DelegadorComRespondTo.new

# `respond_to?` agora retorna true para métodos dinâmicos
puts "\nrespond_to?(:find_by_name): #{delegador2.respond_to?(:find_by_name)}"
puts "respond_to?(:qualquer_coisa): #{delegador2.respond_to?(:qualquer_coisa)}"

puts delegador2.find_by_name("Alice")
puts delegador2.find_by_email("alice@example.com")

puts "---"

puts "--- Considerações Importantes ---"
puts "*   Sempre chame `super` em `method_missing` para métodos que você não lida."
puts "*   Sempre implemente `respond_to_missing?` junto com `method_missing`."
puts "*   Use `method_missing` com moderação, pois pode dificultar a depuração e a compreensão do código."
