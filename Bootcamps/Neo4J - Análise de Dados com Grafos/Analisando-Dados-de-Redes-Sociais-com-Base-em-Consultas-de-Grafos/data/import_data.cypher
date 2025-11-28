// APAGA TODOS OS DADOS EXISTENTES (CUIDADO!)
// Útil para executar o script várias vezes do zero.
MATCH (n)
DETACH DELETE n;

// --- CRIAÇÃO DOS NÓS (NODES) ---

// Criar Cidades (Locations)
CREATE (:Location {city: 'Recife', state: 'PE', country: 'Brasil'});
CREATE (:Location {city: 'São Paulo', state: 'SP', country: 'Brasil'});
CREATE (:Location {city: 'Porto', state: 'Porto', country: 'Portugal'});

// Criar Empresas (Companies)
CREATE (:Company {name: 'TechCorp'});
CREATE (:Company {name: 'InovaSoft'});

// Criar Universidades (Universities)
CREATE (:University {name: 'UFPE'});
CREATE (:University {name: 'USP'});

// Criar Escolas (Schools)
CREATE (:School {name: 'Colégio Exemplo'});

// Criar Usuários (Users)
CREATE (:User {name: 'Ana'});
CREATE (:User {name: 'Bruno'});
CREATE (:User {name: 'Carla'});
CREATE (:User {name: 'Daniel'});
CREATE (:User {name: 'Elisa'});
CREATE (:User {name: 'Fabio'});
CREATE (:User {name: 'Gabi'});
CREATE (:User {name: 'Hugo'});
CREATE (:User {name: 'Mariana'});


// --- CRIAÇÃO DOS RELACIONAMENTOS (RELATIONSHIPS) ---

// Conectar usuários às suas localizações
MATCH (u:User {name: 'Ana'}), (l:Location {city: 'Recife'}) CREATE (u)-[:LIVES_IN]->(l);
MATCH (u:User {name: 'Bruno'}), (l:Location {city: 'Recife'}) CREATE (u)-[:LIVES_IN]->(l);
MATCH (u:User {name: 'Carla'}), (l:Location {city: 'São Paulo'}) CREATE (u)-[:LIVES_IN]->(l);
MATCH (u:User {name: 'Daniel'}), (l:Location {city: 'Recife'}) CREATE (u)-[:LIVES_IN]->(l);
MATCH (u:User {name: 'Elisa'}), (l:Location {city: 'São Paulo'}) CREATE (u)-[:LIVES_IN]->(l);
MATCH (u:User {name: 'Fabio'}), (l:Location {city: 'São Paulo'}) CREATE (u)-[:LIVES_IN]->(l);
MATCH (u:User {name: 'Gabi'}), (l:Location {city: 'Porto'}) CREATE (u)-[:LIVES_IN]->(l);
MATCH (u:User {name: 'Hugo'}), (l:Location {city: 'Porto'}) CREATE (u)-[:LIVES_IN]->(l);
MATCH (u:User {name: 'Mariana'}), (l:Location {city: 'Recife'}) CREATE (u)-[:LIVES_IN]->(l);


// Conectar usuários às empresas
MATCH (u:User {name: 'Ana'}), (c:Company {name: 'TechCorp'}) CREATE (u)-[:WORKS_AT]->(c);
MATCH (u:User {name: 'Bruno'}), (c:Company {name: 'TechCorp'}) CREATE (u)-[:WORKS_AT]->(c);
MATCH (u:User {name: 'Carla'}), (c:Company {name: 'InovaSoft'}) CREATE (u)-[:WORKS_AT]->(c);
MATCH (u:User {name: 'Daniel'}), (c:Company {name: 'InovaSoft'}) CREATE (u)-[:WORKS_AT]->(c);
MATCH (u:User {name: 'Elisa'}), (c:Company {name: 'InovaSoft'}) CREATE (u)-[:WORKS_AT]->(c);
MATCH (u:User {name: 'Fabio'}), (c:Company {name: 'TechCorp'}) CREATE (u)-[:WORKS_AT]->(c);
MATCH (u:User {name: 'Gabi'}), (c:Company {name: 'TechCorp'}) CREATE (u)-[:WORKS_AT]->(c);
// Hugo e Mariana não trabalham em empresas listadas

// Conectar usuários às instituições de ensino
MATCH (u:User {name: 'Ana'}), (un:University {name: 'UFPE'}) CREATE (u)-[:STUDIED_AT]->(un);
MATCH (u:User {name: 'Bruno'}), (un:University {name: 'UFPE'}) CREATE (u)-[:STUDIED_AT]->(un);
MATCH (u:User {name: 'Carla'}), (un:University {name: 'USP'}) CREATE (u)-[:STUDIED_AT]->(un);
MATCH (u:User {name: 'Daniel'}), (s:School {name: 'Colégio Exemplo'}) CREATE (u)-[:STUDIED_AT]->(s);
MATCH (u:User {name: 'Elisa'}), (un:University {name: 'USP'}) CREATE (u)-[:STUDIED_AT]->(un);
MATCH (u:User {name: 'Fabio'}), (un:University {name: 'USP'}) CREATE (u)-[:STUDIED_AT]->(un);
MATCH (u:User {name: 'Gabi'}), (s:School {name: 'Colégio Exemplo'}) CREATE (u)-[:STUDIED_AT]->(s);
MATCH (u:User {name: 'Hugo'}), (un:University {name: 'UFPE'}) CREATE (u)-[:STUDIED_AT]->(un);
MATCH (u:User {name: 'Mariana'}), (un:University {name: 'UFPE'}) CREATE (u)-[:STUDIED_AT]->(un);


// Criar amizades (relacionamento mútuo)
MATCH (a:User {name: 'Ana'}), (b:User {name: 'Bruno'}) CREATE (a)-[:FRIENDS_WITH]->(b), (b)-[:FRIENDS_WITH]->(a);
MATCH (a:User {name: 'Ana'}), (b:User {name: 'Carla'}) CREATE (a)-[:FRIENDS_WITH]->(b), (b)-[:FRIENDS_WITH]->(a);
MATCH (a:User {name: 'Bruno'}), (b:User {name: 'Daniel'}) CREATE (a)-[:FRIENDS_WITH]->(b), (b)-[:FRIENDS_WITH]->(a);
MATCH (a:User {name: 'Carla'}), (b:User {name: 'Elisa'}) CREATE (a)-[:FRIENDS_WITH]->(b), (b)-[:FRIENDS_WITH]->(a);
MATCH (a:User {name: 'Elisa'}), (b:User {name: 'Fabio'}) CREATE (a)-[:FRIENDS_WITH]->(b), (b)-[:FRIENDS_WITH]->(a);
MATCH (a:User {name: 'Gabi'}), (b:User {name: 'Hugo'}) CREATE (a)-[:FRIENDS_WITH]->(b), (b)-[:FRIENDS_WITH]->(a);
MATCH (a:User {name: 'Daniel'}), (b:User {name: 'Gabi'}) CREATE (a)-[:FRIENDS_WITH]->(b), (b)-[:FRIENDS_WITH]->(a);
