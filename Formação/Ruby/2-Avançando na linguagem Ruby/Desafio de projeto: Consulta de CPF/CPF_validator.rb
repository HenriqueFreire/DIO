require 'cpf_cnpj'

puts "Digite o seu CPF."

cpf = gets.chomp

def cpf_validator(cpf)
  if CPF.valid?(cpf)
    puts "CPF válido!"
  else
    puts "CPF inválido!"
  end
end

cpf_validator(cpf)
