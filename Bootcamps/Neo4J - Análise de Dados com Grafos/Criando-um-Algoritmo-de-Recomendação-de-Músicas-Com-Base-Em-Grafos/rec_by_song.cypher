// Consulta de Recomendação de Músicas para um Usuário Específico

// :param userName => O nome do usuário para o qual queremos as recomendações.
// Vamos usar 'Henrique' como exemplo.

MATCH (targetUser:User {name: 'Henrique'})-[:LISTENED_TO]->(listenedMusic:Music)

// Encontra outros usuários que ouviram as mesmas músicas que o usuário alvo
MATCH (similarUser:User)-[:LISTENED_TO]->(listenedMusic)
WHERE targetUser <> similarUser

// Encontra as músicas que esses usuários similares ouviram
MATCH (similarUser)-[:LISTENED_TO]->(recommendedMusic:Music)
// Filtra as músicas que o usuário alvo já ouviu
WHERE NOT (targetUser)-[:LISTENED_TO]->(recommendedMusic)

// Agrupa as recomendações e conta a frequência
WITH recommendedMusic, count(DISTINCT similarUser) AS recommendationScore
ORDER BY recommendationScore DESC

// Retorna as top 5 recomendações
RETURN recommendedMusic.name AS recommendation, recommendationScore
LIMIT 5;
