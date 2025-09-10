# Define o caminho para o arquivo de lista na raiz do projeto
# __dir__ aponta para o diretório do script atual
file_path = File.join(__dir__, './lista.txt')

# Novo item para adicionar
novo_item = "Café"

# Adiciona o novo item ao final do arquivo
File.open(file_path, 'a') do |file|
  file.puts(novo_item)
end

puts "Item '#{novo_item}' foi adicionado à lista."

puts "\n--- Conteúdo Atual da Lista ---"
puts File.read(file_path)
