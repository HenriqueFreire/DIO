# - Times("vezes"): Executa uma repetição por determinado números de vezes.

6.times {print "Oi "}
6.times {puts "Oi"}

4.times do
  puts "Olá!"
end

20.times do |contador|
  puts "#{contador += 1}"
end