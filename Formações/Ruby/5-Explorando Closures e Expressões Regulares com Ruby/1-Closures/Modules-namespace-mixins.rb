# Módulos em Ruby servem a dois propósitos principais:
# 1. Namespaces: Para organizar classes e métodos, evitando conflitos de nomes.
# 2. Mixins: Para compartilhar funcionalidades entre classes sem usar herança de classe.

puts "--- Módulos como Namespaces ---"

# Exemplo 1: Módulos como Namespaces
# Módulos ajudam a organizar o código e evitar colisões de nomes.
module MinhaApp
  module Utilitarios
    def self.saudar
      "Olá do módulo Utilitarios!"
    end

    class Configuracao
      attr_accessor :versao

      def initialize
        @versao = "1.0"
      end
    end
  end

  class Usuario
    attr_accessor :nome

    def initialize(nome)
      @nome = nome
    end

    def apresentar
      "Meu nome é #{nome}."
    end
  end
end

# Acessando métodos e classes dentro do namespace do módulo
puts MinhaApp::Utilitarios.saudar
config = MinhaApp::Utilitarios::Configuracao.new
puts "Versão da Configuração: #{config.versao}"
usuario = MinhaApp::Usuario.new("Alice")
puts usuario.apresentar

puts "\n--- Módulos como Mixins (com `include`) ---"

# Exemplo 2: Módulos como Mixins (com `include`)
# Módulos podem ser incluídos em classes para adicionar métodos de instância.
module Saudavel
  def saudar
    "Olá, eu sou #{self.class.name}!"
  end

  def despedir
    "Adeus de #{self.class.name}!"
  end
end

class Pessoa
  include Saudavel # Inclui o módulo Saudavel, adicionando seus métodos como métodos de instância
  attr_accessor :nome

  def initialize(nome)
    @nome = nome
  end
end

class Cachorro
  include Saudavel # Cachorro também pode ser Saudavel!
  attr_accessor :nome

  def initialize(nome)
    @nome = nome
  end
end

pessoa = Pessoa.new("Carlos")
puts pessoa.saudar
puts pessoa.despedir

cachorro = Cachorro.new("Rex")
puts cachorro.saudar
puts cachorro.despedir

puts "\n--- Módulos com `extend` vs `include` ---"

# Exemplo 3: `extend` vs `include`
# `include` adiciona métodos como métodos de instância.
# `extend` adiciona métodos como métodos de classe (ou singleton methods para objetos).
module AcoesDeLog
  def log_instancia(mensagem)
    puts "[INSTÂNCIA LOG] #{mensagem}"
  end

  def self.log_modulo(mensagem)
    puts "[MÓDULO LOG] #{mensagem}"
  end

  def log_classe(mensagem)
    puts "[CLASSE LOG] #{mensagem}"
  end
end

class MinhaClasse
  include AcoesDeLog # log_instancia se torna um método de instância
  extend AcoesDeLog  # log_classe se torna um método de classe

  def fazer_algo
    log_instancia("Fazendo algo na instância.")
  end
end

obj = MinhaClasse.new
obj.fazer_algo
MinhaClasse.log_classe("Fazendo algo na classe.")

# Métodos definidos com `self.` dentro do módulo são métodos de módulo e podem ser chamados diretamente.
AcoesDeLog.log_modulo("Chamando método diretamente do módulo.")

puts "\n--- Módulos Aninhados ---"

# Exemplo 4: Módulos Aninhados
# Módulos podem ser aninhados para criar hierarquias de namespaces mais complexas.
module Empresa
  module Departamento
    class Funcionario
      attr_accessor :nome, :cargo

      def initialize(nome, cargo)
        @nome = nome
        @cargo = cargo
      end

      def detalhes
        "#{nome} - #{cargo}"
      end
    end
  end
end

funcionario = Empresa::Departamento::Funcionario.new("Ana", "Desenvolvedora")
puts funcionario.detalhes
