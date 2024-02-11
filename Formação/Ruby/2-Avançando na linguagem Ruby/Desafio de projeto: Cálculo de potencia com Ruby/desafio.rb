numeros = []

while numeros.length < 3
  if numeros.empty?
    puts "Digite um número inteiro"  
  else 
    puts "\nDigite mais um número inteiro"
  end

  numero_escolhido = gets.chomp.to_i
  numeros.push(numero_escolhido)
end

numeros_ao_cubo = numeros.map do |n|
  n ** 3
end 

put ''

numeros_ao_cubo.each do |cubo|
  puts "#{numeros[numeros_ao_cubo.index(cubo)]} elevado ao cubo é: #{cubo}"
end