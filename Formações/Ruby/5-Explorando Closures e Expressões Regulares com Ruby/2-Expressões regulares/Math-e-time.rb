# Módulo Math e Classe Time em Ruby

# --- Módulo Math ---
# O módulo `Math` fornece funções matemáticas de propósito geral.
# Você não precisa instanciar o módulo; seus métodos são chamados diretamente.

puts "--- Módulo Math ---"

# Exemplo 1: Funções Matemáticas Básicas
puts "\nFunções Matemáticas Básicas:"
puts "Raiz quadrada de 16: #{Math.sqrt(16)}"
puts "Seno de PI/2: #{Math.sin(Math::PI / 2)}"
puts "Coseno de 0: #{Math.cos(0)}"
puts "Logaritmo natural de 10: #{Math.log(10)}"
puts "e elevado à potência de 2: #{Math.exp(2)}"

# Exemplo 2: Constantes Matemáticas
puts "\nConstantes Matemáticas:"
puts "Valor de PI: #{Math::PI}"
puts "Valor de E (base do logaritmo natural): #{Math::E}"

puts "---"

# --- Classe Time ---
# A classe `Time` representa datas e horas. Ela lida com fusos horários e conversões.

puts "--- Classe Time ---"

# Exemplo 1: Criando objetos Time
puts "\nCriando objetos Time:"
current_time = Time.now # Hora atual
puts "Hora atual: #{current_time}"

specific_time = Time.new(2025, 9, 9, 10, 30, 0) # Ano, Mês, Dia, Hora, Minuto, Segundo
puts "Hora específica: #{specific_time}"

# Exemplo 2: Acessando componentes da data/hora
puts "\nAcessando componentes:"
puts "Ano: #{current_time.year}"
puts "Mês: #{current_time.month}"
puts "Dia: #{current_time.day}"
puts "Hora: #{current_time.hour}"
puts "Minuto: #{current_time.min}"
puts "Segundo: #{current_time.sec}"
puts "Dia da semana (0=domingo): #{current_time.wday}"
puts "Dia do ano (1-366): #{current_time.yday}"

# Exemplo 3: Formatando a hora
puts "\nFormatando a hora:"
puts "Formato curto: #{current_time.strftime("%d/%m/%Y %H:%M:%S")}"
puts "Nome do dia da semana: #{current_time.strftime("%A")}"
puts "Nome do mês: #{current_time.strftime("%B")}"

# Exemplo 4: Aritmética de Tempo
puts "\nAritmética de Tempo:"
future_time = current_time + (10 * 24 * 60 * 60) # Adiciona 10 dias (em segundos)
puts "Daqui a 10 dias: #{future_time}"

past_time = current_time - (3600) # Subtrai 1 hora (em segundos)
puts "Há 1 hora: #{past_time}"

# Exemplo 5: Comparando Tempo
puts "\nComparando Tempo:"
puts "#{current_time} > #{specific_time}: #{current_time > specific_time}"
puts "#{current_time} < #{specific_time}: #{current_time < specific_time}"
puts "#{current_time} == #{current_time}: #{current_time == current_time}"
