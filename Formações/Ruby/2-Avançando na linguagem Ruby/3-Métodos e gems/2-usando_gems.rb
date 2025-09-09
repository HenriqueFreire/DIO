# o que são gems:
# É um pacote que oferece funcionalidades para resolver uma necessidade específica.
# Resumindo ela é uma biblioteca cheia de coisas prontas para facilitar sua vida

# para instalar uma gem?
# escolha qual gem você quer e digite:
# gem install (nome da gem)

# a biblioteca que usaremos nessa aula será a os

# 1. instalar a biblioteca (gem)
require 'os'

# Escrever nosso código 
# iremos codar um programa que retorna algumas das configurações do nosso computador
# para isso:

# 2. definir um método
# esse método vai analisar qual o sistema operacioal do nosso computador
# dentro desse método, nosso código precisa analisar SE(IF) nosso sistema operacional é x
# SeNÂO(ELSIF) y, SENÃO(ELSIF) z, SENÃO(ELSE) outra coisa não esqueça de finalizar tanto o IF quanto o DEF
def meu_SO
  if OS.windows?
    "Windows"
  elsif OS.linux?
    "Linux"
  elsif OS.mac?
    "Mac"
  else
    "Não identifiquei o sistema operacional"
  end
end

# 3. No final de tudo queremos que o programa imprima qual o 
# sistema operacional e o número de bits e as cores do seu PC

puts "Meu PC é #{OS.bits} bits, possui #{OS.cpu_count} cores e o sistema operacional é #{meu_SO}"