// Consulta de Recomendação: Baseada no Gênero Favorito do Usuário

// :param userName => O nome do usuário para o qual queremos as recomendações.
// Vamos usar 'Henrique' como exemplo.

// Encontra todos os gêneros que o usuário ouviu
MATCH (targetUser:User {name: 'Henrique'})-[:LISTENED_TO]->(:Music)-[:BELONGS_TO_GENRE]->(g:Genre)

// Conta a frequência de cada gênero e seleciona o mais ouvido (o favorito)
WITH g, count(g) AS genreFrequency
ORDER BY genreFrequency DESC
LIMIT 1

// Encontra todas as músicas que pertencem a esse gênero favorito
MATCH (recommendedMusic:Music)-[:BELONGS_TO_GENRE]->(g)

// Filtra as músicas que o usuário alvo já ouviu
WHERE NOT (:User {name: 'Henrique'})-[:LISTENED_TO]->(recommendedMusic)

// Retorna as recomendações
RETURN recommendedMusic.name AS recommendation
LIMIT 10;
