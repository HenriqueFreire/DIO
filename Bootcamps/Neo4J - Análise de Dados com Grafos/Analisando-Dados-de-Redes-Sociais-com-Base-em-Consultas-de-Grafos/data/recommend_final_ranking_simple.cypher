// Defina o usuário para o qual queremos recomendações.
WITH 'Ana' AS userName

// --- Subconsulta para calcular pontuação ---
// Usamos CALL {} para unir os resultados de duas lógicas diferentes.
CALL {
    WITH userName
    // Lógica 1: Pontos por Amigos em Comum
    MATCH (user:User {name: userName})-[:FRIENDS_WITH]->(friend:User)-[:FRIENDS_WITH]->(recommendation:User)
    WHERE user <> recommendation AND NOT (user)-[:FRIENDS_WITH]->(recommendation)
    // Cada amigo em comum agora vale 1 ponto
    RETURN recommendation, count(friend) AS score

    UNION

    WITH userName
    // Lógica 2: Pontos por Locais em Comum
    MATCH (user:User {name: userName})-[r:LIVES_IN|WORKS_AT|STUDIED_AT]->(place)<-[:LIVES_IN|WORKS_AT|STUDIED_AT]-(recommendation:User)
    WHERE user <> recommendation AND NOT (user)-[:FRIENDS_WITH]->(recommendation)
    // Cada local em comum agora vale 1 ponto
    RETURN recommendation, 1 AS score
}

// --- Agregação Final ---
// Agrupa todas as pontuações para cada recomendação e soma.
WITH recommendation, sum(score) as totalScore

// Retorna o ranking final ordenado pela maior pontuação.
RETURN recommendation.name as recommendationName, totalScore
ORDER BY totalScore DESC
