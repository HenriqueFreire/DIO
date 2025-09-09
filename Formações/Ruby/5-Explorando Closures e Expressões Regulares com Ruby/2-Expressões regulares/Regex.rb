# Expressões Regulares (Regex) em Ruby

# Expressões regulares são padrões usados para encontrar combinações de caracteres em strings.
# Em Ruby, elas são objetos da classe `Regexp`.

puts "--- 1. Correspondência Básica ---"

# Usando o operador `=~` para verificar se uma string contém um padrão.
# Ele retorna o índice da primeira correspondência ou `nil` se não houver.

puts "Exemplo de correspondência simples:"
puts "Ruby" =~ /R/    # => 0 (índice onde 'R' é encontrado)
puts "Ruby" =~ /b/    # => 2
puts "Ruby" =~ /x/    # => nil

# O método `match` retorna um objeto `MatchData` com informações detalhadas sobre a correspondência.
match_data = "Olá, mundo!" .match(/mundo/)
puts "\nUsando o método match:
"#{match_data.inspect}"
puts "Texto correspondido: #{match_data[0]}"

puts "---"

puts "--- 2. Classes de Caracteres ---"

# `.` (ponto): Corresponde a qualquer caractere (exceto nova linha).
puts "\nQualquer caractere (.):"
puts "abc" =~ /a.c/ # => 0
puts "a c" =~ /a.c/ # => 0

# `\d`: Corresponde a qualquer dígito (0-9).
puts "\nDígito (\d):"
puts "123" =~ /\d\d\d/ # => 0
puts "abc" =~ /\d/    # => nil

# `\D`: Corresponde a qualquer caractere que não seja um dígito.
puts "\nNão dígito (\D):"
puts "abc" =~ /\D\D\D/ # => 0
puts "123" =~ /\D/    # => nil

# `\w`: Corresponde a qualquer caractere de palavra (letras, números, underscore).
puts "\nCaractere de palavra (\w):"
puts "hello_123" =~ /\w+/ # => 0

# `\W`: Corresponde a qualquer caractere que não seja de palavra.
puts "\nNão caractere de palavra (\W):"
puts "hello!" =~ /\W/ # => 5

# `\s`: Corresponde a qualquer caractere de espaço em branco (espaço, tab, nova linha).
puts "\nEspaço em branco (\s):"
puts "a b" =~ /a\sb/ # => 0

# `\S`: Corresponde a qualquer caractere que não seja de espaço em branco.
puts "\nNão espaço em branco (\S):"
puts "a b" =~ /a\Sb/ # => nil

# `[]`: Conjunto de caracteres. Corresponde a qualquer um dos caracteres dentro dos colchetes.
puts "\nConjunto de caracteres ([]):"
puts "cor" =~ /[co]or/ # => 0
puts "cor" =~ /[xyz]or/ # => nil

# `[^]`: Conjunto de caracteres negado. Corresponde a qualquer caractere que NÃO esteja dentro dos colchetes.
puts "\nConjunto de caracteres negado ([^]):"
puts "cor" =~ /[^xyz]or/ # => 0
puts "xor" =~ /[^xyz]or/ # => nil

puts "---"

puts "--- 3. Quantificadores ---"

# `*`: Zero ou mais ocorrências.
puts "\nZero ou mais (*):"
puts "ab" =~ /a*b/ # => 0
puts "aaab" =~ /a*b/ # => 0
puts "b" =~ /a*b/ # => 0

# `+`: Uma ou mais ocorrências.
puts "\nUma ou mais (+):"
puts "aaab" =~ /a+b/ # => 0
puts "b" =~ /a+b/ # => nil

# `?`: Zero ou uma ocorrência (opcional).
puts "\nZero ou uma (?):"
puts "cor" =~ /colou?r/ # => 0
puts "color" =~ /colou?r/ # => 0

# `{n}`: Exatamente n ocorrências.
puts "\nExatamente n ({n}):"
puts "aaaa" =~ /a{4}/ # => 0
puts "aaa" =~ /a{4}/ # => nil

# `{n,}`: n ou mais ocorrências.
puts "\nn ou mais ({n,}):"
puts "aaaaa" =~ /a{4,}/ # => 0
puts "aaa" =~ /a{4,}/ # => nil

# `{n,m}`: Entre n e m ocorrências (inclusive).
puts "\nEntre n e m ({n,m}):"
puts "aaaa" =~ /a{2,4}/ # => 0
puts "a" =~ /a{2,4}/ # => nil
puts "aaaaa" =~ /a{2,4}/ # => 0

puts "---"

puts "--- 4. Âncoras ---"

# `^`: Início da string.
puts "\nInício da string (^):"
puts "hello world" =~ /^hello/ # => 0
puts "world hello" =~ /^hello/ # => nil

# `$`: Fim da string.
puts "\nFim da string ($):"
puts "hello world" =~ /world$/ # => 6
puts "world hello" =~ /world$/ # => nil

# `\b`: Limite de palavra (word boundary).
puts "\nLimite de palavra (\b):"
puts "cat" =~ /\bcat\b/ # => 0
puts "category" =~ /\bcat\b/ # => nil

# `\B`: Não limite de palavra (non-word boundary).
puts "\nNão limite de palavra (\B):"
puts "category" =~ /\Bcat\B/ # => nil
puts "cat" =~ /\Bcat\B/ # => nil
puts "category" =~ /cat\B/ # => 0

puts "---"

puts "--- 5. Grupos e Captura ---"

# `()`: Cria um grupo de captura. O texto correspondido pelo grupo pode ser acessado.
puts "\nGrupos de captura ():"
match_data = "Nome: João, Idade: 30" .match(/Nome: (\w+), Idade: (\d+)/)
puts "Nome: #{match_data[1]}, Idade: #{match_data[2]}"

puts "---"

puts "--- 6. Alternância ---"

# `|`: Operador OU. Corresponde a um padrão OU outro.
puts "\nAlternância (|):"
puts "maçã" =~ /maçã|banana/ # => 0
puts "banana" =~ /maçã|banana/ # => 0
puts "laranja" =~ /maçã|banana/ # => nil

puts "---"

puts "--- 7. Substituição ---"

# `sub`: Substitui a primeira ocorrência do padrão.
puts "\nSubstituição (sub):"
texto = "Olá mundo, olá Ruby!"
puts texto.sub(/olá/, "Oi") # => "Oi mundo, olá Ruby!"

# `gsub`: Substitui todas as ocorrências do padrão.
puts "\nSubstituição global (gsub):"
puts texto.gsub(/olá/, "Oi") # => "Oi mundo, Oi Ruby!"

puts "---"

puts "--- 8. Divisão ---"

# `split`: Divide uma string em um array usando um padrão como delimitador.
puts "\nDivisão (split):"
frase = "maçã,banana;laranja"
puts frase.split(/[,;]/).inspect # => ["maçã", "banana", "laranja"]
