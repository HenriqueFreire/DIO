# Desafio: Validador de WhatsApp com Expressões Regulares

# Define o número de WhatsApp a ser validado
whatsapp_number = "(11) 9 8765-4321"
# whatsapp_number = "(21) 99876-5432" # Exemplo de número inválido (formato diferente)
# whatsapp_number = "(11) 91234-5678" # Exemplo de número inválido (sem o espaço após o 9)

puts "Meu WhatsApp é: #{whatsapp_number}"

# Define a expressão regular para o formato (99) 9 9999-9999
# Explicação da Regex:
# \(\) : Corresponde aos parênteses literais.
# \d{2} : Corresponde a exatamente dois dígitos (para o DDD).
# \s   : Corresponde a um espaço em branco.
# \d   : Corresponde a um único dígito (o 9 extra).
# \s   : Corresponde a um espaço em branco.
# \d{4} : Corresponde a exatamente quatro dígitos.
# -    : Corresponde ao hífen literal.
# \d{4} : Corresponde a exatamente quatro dígitos.
whatsapp_regex = /^\(\d{2}\)\s\d\s\d{4}-\d{4}$/

# Usa o método `match` para verificar se o número corresponde ao padrão
match_result = whatsapp_regex.match(whatsapp_number)

# Imprime o resultado da validação
if match_result
  puts "O número de WhatsApp '#{whatsapp_number}' está no formato (99) 9 9999-9999. (Válido)"
else
  puts "O número de WhatsApp '#{whatsapp_number}' NÃO está no formato (99) 9 9999-9999. (Inválido)"
end
