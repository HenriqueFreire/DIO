// Defina o usuário para o qual queremos recomendações.
// Você pode trocar 'Ana' por qualquer outro nome.
WITH 'Ana' AS userName

// Encontra o usuário inicial, seus amigos, e os amigos dos amigos (fof).
MATCH (user:User {name: userName})-[:FRIENDS_WITH]->(friend:User)-[:FRIENDS_WITH]->(fof:User)

// Cláusula WHERE para filtrar os resultados:
// 1. A pessoa recomendada (fof) não pode ser o próprio usuário inicial.
// 2. O usuário inicial não pode já ser amigo da pessoa recomendada.
WHERE fof <> user AND NOT (user)-[:FRIENDS_WITH]->(fof)

// Retorna o nome da pessoa recomendada e a contagem de amigos em comum.
RETURN fof.name AS recommendation, count(DISTINCT friend) AS mutualFriends

// Ordena os resultados para mostrar primeiro quem tem mais amigos em comum.
ORDER BY mutualFriends DESC
