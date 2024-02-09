# Manipulando Hashes
# Também é um tipo de lista, mas ela tem CHAVE: VALOR
# Criando um hash vazio variavel = Hash.new
animais = Hash.new

# Podemos iniciar com pares de CHAVE-VALOR variavel = {chave: 'valor', chave2: 'valor2'}
animais = {ave: "Tucano", mamifero: "cachorro", reptil: "tartaruga"}

# Adicione um nome item ao hash variavel[:nome inclusão] = "valor a ser add"
animais[:peixe] = "tucunaré"

# Para retornar todas as chaves de um hash nome.keys
animais.keys

# Para retornar todos os valores de um hash nome.values
animais.values

# Para excluir um elemento nome.delete(:nome a ser excluído)
animais.delete(:peixe)

# Descobrir o tamanho da hash nome.size
animais.size

# Verifique se o hash está vazio nome.empty? 
animais.empty?