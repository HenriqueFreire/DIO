// Defina o usuário para o qual queremos recomendações.
WITH 'Ana' AS userName

// --- Subconsulta para calcular pontuação ---
// Usamos CALL {} para unir os resultados de duas lógicas diferentes.
CALL {
    WITH userName
    // Lógica 1: Pontos por Amigos em Comum
    MATCH (user:User {name: userName})-[:FRIENDS_WITH]->(friend:User)-[:FRIENDS_WITH]->(recommendation:User)
    WHERE user <> recommendation AND NOT (user)-[:FRIENDS_WITH]->(recommendation)
    // Retorna a recomendação e a pontuação (10 por amigo em comum)
    RETURN recommendation, 10 * count(friend) AS score

    UNION

    WITH userName
    // Lógica 2: Pontos por Locais em Comum
    MATCH (user:User {name: userName})-[r:LIVES_IN|WORKS_AT|STUDIED_AT]->(place)<-[:LIVES_IN|WORKS_AT|STUDIED_AT]-(recommendation:User)
    WHERE user <> recommendation AND NOT (user)-[:FRIENDS_WITH]->(recommendation)
    // Retorna a recomendação e a pontuação baseada no tipo de local
    RETURN recommendation,
         CASE type(r)
             WHEN 'WORKS_AT' THEN 5
             WHEN 'STUDIED_AT' THEN 
                 CASE WHEN 'University' IN labels(place) THEN 5
                      ELSE 4 END
             WHEN 'LIVES_IN' THEN 3
             ELSE 1
         END AS score
}

// --- Agregação Final ---
// Agrupa todas as pontuações para cada recomendação e soma.
WITH recommendation, sum(score) as totalScore

// Retorna o ranking final ordenado pela maior pontuação.
RETURN recommendation.name as recommendationName, totalScore
ORDER BY totalScore DESC
