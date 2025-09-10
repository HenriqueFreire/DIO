require 'nokogiri'
require 'net/http'

# Desafio: Utilizando a Gem NOKOGIRI, leia a página example.com
# e retorne na tela o que se encontra dentro da tag <p>.

# Faz uma requisição HTTP para o site example.com
uri = URI('http://example.com/')
response = Net::HTTP.get(uri)

# Utiliza Nokogiri para parsear o corpo da resposta HTML
doc = Nokogiri::HTML(response)

# Encontra a primeira ocorrência da tag 'p' usando o método at()
p_tag_content = doc.at('p').content

# Imprime o conteúdo da tag <p> no console
puts "O conteúdo da tag <p> da página é:"
puts p_tag_content
