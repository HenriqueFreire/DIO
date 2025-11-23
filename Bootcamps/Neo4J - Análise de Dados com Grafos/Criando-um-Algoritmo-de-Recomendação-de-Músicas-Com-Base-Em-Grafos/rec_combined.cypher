// --- Consulta de Recomendação Combinada e Ponderada ---
// Usa uma subconsulta para agregar os resultados das 3 lógicas.

CALL {
    // --- Lógica 1: Recomendação por Músicas em Comum ---
    MATCH (targetUser:User {name: 'Henrique'})-[:LISTENED_TO]->(listenedMusic:Music)
    MATCH (similarUser:User)-[:LISTENED_TO]->(listenedMusic) WHERE targetUser <> similarUser
    MATCH (similarUser)-[:LISTENED_TO]->(rec:Music)
    WHERE NOT (targetUser)-[:LISTENED_TO]->(rec)
    WITH rec, count(DISTINCT similarUser) AS score
    RETURN rec.name AS recommendation, score, "Por Música Similar" AS type

    UNION ALL

    // --- Lógica 2: Recomendação por Artistas em Comum ---
    MATCH (targetUser:User {name: 'Henrique'})-[:LISTENED_TO]->(:Music)<-[:PERFORMED]-(sharedArtist:Artist)
    MATCH (similarUser:User)-[:LISTENED_TO]->(:Music)<-[:PERFORMED]-(sharedArtist) WHERE targetUser <> similarUser
    MATCH (similarUser)-[:LISTENED_TO]->(rec:Music)
    WHERE NOT (targetUser)-[:LISTENED_TO]->(rec)
    WITH rec, count(DISTINCT similarUser) AS score
    RETURN rec.name AS recommendation, score, "Por Artista Similar" AS type

    UNION ALL

    // --- Lógica 3: Recomendação por Gênero Favorito ---
    MATCH (targetUser:User {name: 'Henrique'})-[:LISTENED_TO]->(:Music)-[:BELONGS_TO_GENRE]->(g:Genre)
    WITH g, count(g) AS genreFrequency ORDER BY genreFrequency DESC LIMIT 1
    MATCH (rec:Music)-[:BELONGS_TO_GENRE]->(g)
    WHERE NOT (:User {name: 'Henrique'})-[:LISTENED_TO]->(rec)
    RETURN rec.name AS recommendation, 1 AS score, "Por Gênero Favorito" AS type
}
// Agrega os resultados das 3 lógicas
WITH recommendation, sum(score) AS finalScore, collect(type) AS reason
RETURN recommendation, finalScore, reason
ORDER BY finalScore DESC
LIMIT 10;
