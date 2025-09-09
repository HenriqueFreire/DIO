# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Criando livros de mangá/manhwa/manhua..."

Livro.find_or_create_by!(titulo: "Naruto") do |livro|
  livro.autor = "Masashi Kishimoto"
  livro.nota = 5
  livro.descricao = "Um jovem ninja que sonha em se tornar o Hokage."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/9/94/NarutoCoverTankobon1.jpg"
end

Livro.find_or_create_by!(titulo: "Solo Leveling") do |livro|
  livro.autor = "Chugong (original), Dubu (arte)"
  livro.nota = 5
  livro.descricao = "Um caçador fraco ganha uma habilidade única para subir de nível."
  livro.url = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7rE3YRjwSBprmCJF0zo1xZB_AfDH97DR9_4WN4RewPirkCTPGfH8GSHJQ_6byWA0n7g6z9GJ44_ii4KiyCcU5uJiqgwX4h2j_k3ybRzWWoAyjn5ydxMKTqOQAb6AIzcdDCf0jPKDP3GHhXl46nWd5pEfXxUhDflMTzffo9MkZASKulZlw8vS-Mq3iijU5/w520/7c21cc6b-df69-4880-a185-53a3f7a2f81d.jpg
"
end

Livro.find_or_create_by!(titulo: "Tales of Demons and Gods") do |livro|
  livro.autor = "Mad Snail"
  livro.nota = 4
  livro.descricao = "Um poderoso especialista renasce no corpo de seu eu mais jovem."
  livro.url = "https://m.media-amazon.com/images/I/81wDz65+NOL._UF350,350_QL50_.jpg"
end

# Novos livros adicionados:

# Japanese Manga
Livro.find_or_create_by!(titulo: "One Piece") do |livro|
  livro.autor = "Eiichiro Oda"
  livro.nota = 5
  livro.descricao = "Uma grande aventura para encontrar o One Piece."
  livro.url = "https://m.media-amazon.com/images/I/716EGgqzyOL._UF1000,1000_QL80_.jpg"
end

Livro.find_or_create_by!(titulo: "Attack on Titan") do |livro|
  livro.autor = "Hajime Isayama"
  livro.nota = 5
  livro.descricao = "A humanidade luta pela sobrevivência contra Titãs humanoides gigantes."
  livro.url = "https://m.media-amazon.com/images/I/71WVN5IXeJL._UF350,350_QL50_.jpg"
end

Livro.find_or_create_by!(titulo: "My Hero Academia") do |livro|
  livro.autor = "Kohei Horikoshi"
  livro.nota = 4
  livro.descricao = "Um garoto que nasceu sem superpoderes em um mundo de heróis."
  livro.url = "https://m.media-amazon.com/images/I/81AjnD8nvHL._UF1000,1000_QL80_.jpg"
end

Livro.find_or_create_by!(titulo: "Demon Slayer") do |livro|
  livro.autor = "Koyoharu Gotouge"
  livro.nota = 5
  livro.descricao = "A busca de um garoto para vingar sua família e curar sua irmã."
  livro.url = "https://m.media-amazon.com/images/I/71oZmNhST-L._UF1000,1000_QL80_.jpg"
end

Livro.find_or_create_by!(titulo: "Jujutsu Kaisen") do |livro|
  livro.autor = "Gege Akutami"
  livro.nota = 4
  livro.descricao = "O estudante Yuji Itadori se junta a uma organização secreta de Feiticeiros Jujutsu."
  livro.url = "https://m.media-amazon.com/images/I/81TmHlRleJL.jpg"
end

# Korean Manhwa
Livro.find_or_create_by!(titulo: "Tower of God") do |livro|
  livro.autor = "SIU"
  livro.nota = 5
  livro.descricao = "A jornada de um garoto por uma torre misteriosa para encontrar sua amiga."
  livro.url = "https://d14d9vp3wdof84.cloudfront.net/image/589816272436/image_r6dpof9jh50in5f838mtaqn85s/-S897-FWEBP"
end

Livro.find_or_create_by!(titulo: "God of High School") do |livro|
  livro.autor = "Yongje Park"
  livro.nota = 4
  livro.descricao = "Um torneio de artes marciais para determinar o lutador mais forte do ensino médio."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/The_God_of_High_School_webtoon_cover.jpg/220px-The_God_of_High_School_webtoon_cover.jpg"
end

Livro.find_or_create_by!(titulo: "Lookism") do |livro|
  livro.autor = "Park Tae-jun"
  livro.nota = 4
  livro.descricao = "Um estudante intimidado acorda com um corpo novo e atraente."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/Lookism_webtoon_cover.jpg/220px-Lookism_webtoon_cover.jpg"
end

Livro.find_or_create_by!(titulo: "The Beginning After The End") do |livro|
  livro.autor = "TurtleMe (original), Fuyuki23 (arte)"
  livro.nota = 5
  livro.descricao = "Um rei é reencarnado em um novo mundo de magia e monstros."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/The_Beginning_After_the_End_webtoon_cover.jpg/220px-The_Beginning_After_the_End_webtoon_cover.jpg"
end

Livro.find_or_create_by!(titulo: "Omniscient Reader's Viewpoint") do |livro|
  livro.autor = "Sing Shong (original), Sleepy-C (arte)"
  livro.nota = 5
  livro.descricao = "Um homem que sabe o final de uma webnovel se encontra em seu mundo."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/Omniscient_Reader%27s_Viewpoint_webtoon_cover.jpg/220px-Omniscient_Reader%27s_Viewpoint_webtoon_cover.jpg"
end

# Chinese Manhua
Livro.find_or_create_by!(titulo: "Martial Peak") do |livro|
  livro.autor = "Momo (original), Kuaikan Manhua (arte)"
  livro.nota = 4
  livro.descricao = "A jornada de um jovem para se tornar o mais forte artista marcial."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/Martial_Peak_manhua_cover.jpg/220px-Martial_Peak_manhua_cover.jpg"
end

Livro.find_or_create_by!(titulo: "Apotheosis") do |livro|
  livro.autor = "Fengling Tianxia (original), Kuaikan Manhua (arte)"
  livro.nota = 4
  livro.descricao = "O caminho de um jovem mestre para o cultivo após o declínio de sua família."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/Apotheosis_manhua_cover.jpg/220px-Apotheosis_manhua_cover.jpg"
end

Livro.find_or_create_by!(titulo: "Soul Land") do |livro|
  livro.autor = "Tang Jia San Shao (original), Mu Feng (arte)"
  livro.nota = 5
  livro.descricao = "Um prodígio das artes marciais reencarnado em um mundo de 'Mestres das Almas'."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/Soul_Land_manhua_cover.jpg/220px-Soul_Land_manhua_cover.jpg"
end

Livro.find_or_create_by!(titulo: "The Great Ruler") do |livro|
  livro.autor = "Heavenly Silkworm Potato (original), Kuaikan Manhua (arte)"
  livro.nota = 4
  livro.descricao = "A jornada de um jovem para se tornar um poderoso cultivador em um vasto mundo."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/The_Great_Ruler_manhua_cover.jpg/220px-The_Great_Ruler_manhua_cover.jpg"
end

Livro.find_or_create_by!(titulo: "Battle Through the Heavens") do |livro|
  livro.autor = "Heavenly Silkworm Potato (original), Kuaikan Manhua (arte)"
  livro.nota = 5
  livro.descricao = "A queda de um gênio e sua jornada para recuperar seu poder."
  livro.url = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/Battle_Through_the_Heavens_manhua_cover.jpg/220px-Battle_Through_the_Heavens_manhua_cover.jpg"
end

puts "Livros criados com sucesso!"
