#Desafios Ruby na DIO têm funções "gets" e "puts" acessíveis globalmente:
# "gets" : lê UMA linha com dado(s) de entrada (inputs) do usuário;
# "puts": imprime um texto de saída (output), pulando linha.

# Solicita as entradas do usuário
preco_gas = gets.chomp.to_f               # Preço do gás
imposto_variavel = gets.chomp.to_i         # Indica se o imposto variável será aplicado (0 ou 1)
valor_imposto_variavel = gets.chomp.to_f   # Valor do imposto variável, em porcentagem

def calcular_preco_gas(preco_gas, imposto_variavel, valor_imposto_variavel)
  # Calcula o preço com o imposto fixo de 10%
  preco_com_imposto_fixo = preco_gas * 1.10

  # Se o imposto variável deve ser cobrado (imposto_variavel == 1)
  if imposto_variavel == 1
    # Adiciona o imposto variável sobre o valor com o imposto fixo
    preco_com_imposto_fixo *= (1 + valor_imposto_variavel / 100)
  end
  
  # Formata a saída: sem casas decimais para inteiros, com uma casa para não inteiros
  if preco_com_imposto_fixo.round(1) == preco_com_imposto_fixo.to_i
    puts "O preço do gás nesse mês é de R$#{preco_com_imposto_fixo.to_i}"
  else
    puts "O preço do gás nesse mês é de R$#{'%.1f' % preco_com_imposto_fixo}"
  end
end

# Chama a função para calcular e exibir o preço final
calcular_preco_gas(preco_gas, imposto_variavel, valor_imposto_variavel)
