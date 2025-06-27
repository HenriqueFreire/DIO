# Condicional
# 
#  - if(se): Determina se uma instrução é verdadeira(true).
#  A partir desse resultado determina se as instruções dentro do bloco serão executadas.
# 
#  - Else(senão): Caso o "if" seja falso(false), ele informa o que deverá ser feito
#  
#  Elsif: Quando for necessário verificar mais uma condição "if".

dia = 'domingo'
if dia == 'domingo' # == é uma comparação de igualdade
  almoco = 'especial'
elsif dia == 'feriado'
  almoco = 'mais tarde'
else 
  almoco = 'normal'
end
puts "Hoje, o almoço será #{almoco}"