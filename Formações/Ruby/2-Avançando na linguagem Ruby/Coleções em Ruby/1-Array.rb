# Coleção(Collection)
# Representa um conjunto de dados

# Vamos manipular arrays
# Lista de livros

# Criar uma array vazia
livros = []

# Vamos adicionar um item nesse array nome.push('o que queremos colocar')
livros.push('Memórias póstumas de Braz Cubas')

# Vamos adicionar vários itens no array ao mesmo tempo nome.push('o que queremos colocar', 'o que queremos colocar 2')
livros.push('Iracema','Mais esperto que o diabo')

# Organizando os novos dados da lista nome.insert(0, 'nome 1', 'nome 2')
livros.insert(0, 'Dom Casmurro', 'Sargento de Milícias')

# Acessando os elementos do array nome[número]
livros[4]

# Acessando intervalos do array nome[1..4]
livros[1..4]

# Recuperar o primeiro elemento nome.first
livros.first

# Recuperar o último elemento nome.last
livros.last

# para saber a quantidade de elementos de um array nome.count ou nome.length
livros.count
livros.length

# descubra se o array está vazio nome.empty?
livros.empty?

# verefique se um nome está presente nesse array nome.include?('nome')
livros.include?('Iracema')

# Para excluir elementos
# Excluir um elemento específico nome.delete_at(número)
livros.delete_at(0)

# Excluir o último elemento nome.pop
livros.pop


