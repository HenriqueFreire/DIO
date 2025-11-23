// Consulta de Recomendação Avançada: Baseada em Artistas em Comum

// :param userName => O nome do usuário para o qual queremos as recomendações.
// Vamos usar 'Henrique' como exemplo.

MATCH (targetUser:User {name: 'Henrique'})-[:LISTENED_TO]->(:Music)<-[:PERFORMED]-(sharedArtist:Artist)

// Encontra usuários similares que também ouviram músicas dos mesmos artistas
MATCH (similarUser:User)-[:LISTENED_TO]->(:Music)<-[:PERFORMED]-(sharedArtist)
WHERE targetUser <> similarUser

// Pega todas as músicas ouvidas pelos usuários similares
MATCH (similarUser)-[:LISTENED_TO]->(recommendedMusic:Music)

// Filtra as músicas que o usuário alvo já ouviu
WHERE NOT (targetUser)-[:LISTENED_TO]->(recommendedMusic)

// Agrupa as recomendações, contando tanto a popularidade da música quanto a afinidade com o artista
WITH recommendedMusic, count(DISTINCT similarUser) AS recommendationScore
ORDER BY recommendationScore DESC

// Retorna as top 5 recomendações
RETURN recommendedMusic.name AS recommendation, recommendationScore
LIMIT 5;
