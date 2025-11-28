// Defina o usuário para o qual queremos recomendações.
WITH 'Ana' AS userName

// Encontra o usuário e potenciais recomendações que compartilham um lugar.
MATCH (user:User {name: userName})-[r1:LIVES_IN|WORKS_AT|STUDIED_AT]->(place)<-[r2:LIVES_IN|WORKS_AT|STUDIED_AT]-(recommendation:User)

// Garante que não estamos recomendando o próprio usuário ou amigos existentes.
WHERE user <> recommendation AND NOT (user)-[:FRIENDS_WITH]->(recommendation)

// Agrupa as recomendações e coleta os detalhes das conexões em comum.
WITH recommendation, 
     count(place) AS commonConnections, 
     collect({connection: type(r1), place: coalesce(place.name, place.city)}) AS details

// Retorna a recomendação, o número de conexões e os detalhes.
RETURN recommendation.name AS recommendationName, 
       commonConnections,
       details
ORDER BY commonConnections DESC