// Limpa o banco de dados para garantir que começaremos do zero
MATCH (n) DETACH DELETE n;

// --- CRIAÇÃO DOS NÓS ---

// Gêneros
MERGE (:Genre {name: 'Rock'});
MERGE (:Genre {name: 'Grunge'});
MERGE (:Genre {name: 'Pop'});
MERGE (:Genre {name: 'Soul'});

// Artistas
MERGE (:Artist {name: 'Queen'});
MERGE (:Artist {name: 'Led Zeppelin'});
MERGE (:Artist {name: 'Nirvana'});
MERGE (:Artist {name: 'Bob Dylan'});
MERGE (:Artist {name: 'John Lennon'});
MERGE (:Artist {name: 'Michael Jackson'});
MERGE (:Artist {name: 'Eagles'});
MERGE (:Artist {name: 'Marvin Gaye'});

// Compositores
MERGE (:Composer {name: 'Freddie Mercury'});
MERGE (:Composer {name: 'Jimmy Page'});
MERGE (:Composer {name: 'Kurt Cobain'});
MERGE (:Composer {name: 'Bob Dylan'});
MERGE (:Composer {name: 'John Lennon'});
MERGE (:Composer {name: 'Michael Jackson'});
MERGE (:Composer {name: 'Don Felder'});
MERGE (:Composer {name: 'Marvin Gaye'});

// Álbuns
MERGE (:Album {name: 'A Night at the Opera'});
MERGE (:Album {name: 'Led Zeppelin IV'});
MERGE (:Album {name: 'Nevermind'});
MERGE (:Album {name: 'Highway 61 Revisited'});
MERGE (:Album {name: 'Imagine'});
MERGE (:Album {name: 'Thriller'});
MERGE (:Album {name: 'Hotel California'});
MERGE (:Album {name: 'What\'s Going On'});

// Músicas
MERGE (:Music {name: 'Bohemian Rhapsody'});
MERGE (:Music {name: 'Stairway to Heaven'});
MERGE (:Music {name: 'Smells Like Teen Spirit'});
MERGE (:Music {name: 'Like a Rolling Stone'});
MERGE (:Music {name: 'Imagine'});
MERGE (:Music {name: 'Billie Jean'});
MERGE (:Music {name: 'Hotel California'});
MERGE (:Music {name: 'What\'s Going On'});

// Usuários
MERGE (:User {name: 'Henrique'});
MERGE (:User {name: 'Beatriz'});
MERGE (:User {name: 'Carlos'});
MERGE (:User {name: 'Diana'});


// --- CRIAÇÃO DOS RELACIONAMENTOS ---

// Relacionamentos para 'Bohemian Rhapsody'
MATCH (m:Music {name: 'Bohemian Rhapsody'}), (g:Genre {name: 'Rock'}), (ar:Artist {name: 'Queen'}), (al:Album {name: 'A Night at the Opera'}), (c:Composer {name: 'Freddie Mercury'})
MERGE (ar)-[:PERFORMED]->(m)
MERGE (m)-[:PART_OF]->(al)
MERGE (ar)-[:RELEASED]->(al)
MERGE (m)-[:BELONGS_TO_GENRE]->(g)
MERGE (c)-[:WROTE]->(m);

// Relacionamentos para 'Stairway to Heaven'
MATCH (m:Music {name: 'Stairway to Heaven'}), (g:Genre {name: 'Rock'}), (ar:Artist {name: 'Led Zeppelin'}), (al:Album {name: 'Led Zeppelin IV'}), (c:Composer {name: 'Jimmy Page'})
MERGE (ar)-[:PERFORMED]->(m)
MERGE (m)-[:PART_OF]->(al)
MERGE (ar)-[:RELEASED]->(al)
MERGE (m)-[:BELONGS_TO_GENRE]->(g)
MERGE (c)-[:WROTE]->(m);

// Relacionamentos para 'Smells Like Teen Spirit'
MATCH (m:Music {name: 'Smells Like Teen Spirit'}), (g:Genre {name: 'Grunge'}), (ar:Artist {name: 'Nirvana'}), (al:Album {name: 'Nevermind'}), (c:Composer {name: 'Kurt Cobain'})
MERGE (ar)-[:PERFORMED]->(m)
MERGE (m)-[:PART_OF]->(al)
MERGE (ar)-[:RELEASED]->(al)
MERGE (m)-[:BELONGS_TO_GENRE]->(g)
MERGE (c)-[:WROTE]->(m);

// Relacionamentos para 'Like a Rolling Stone'
MATCH (m:Music {name: 'Like a Rolling Stone'}), (g:Genre {name: 'Rock'}), (ar:Artist {name: 'Bob Dylan'}), (al:Album {name: 'Highway 61 Revisited'}), (c:Composer {name: 'Bob Dylan'})
MERGE (ar)-[:PERFORMED]->(m)
MERGE (m)-[:PART_OF]->(al)
MERGE (ar)-[:RELEASED]->(al)
MERGE (m)-[:BELONGS_TO_GENRE]->(g)
MERGE (c)-[:WROTE]->(m);

// Relacionamentos para 'Imagine'
MATCH (m:Music {name: 'Imagine'}), (g:Genre {name: 'Pop'}), (ar:Artist {name: 'John Lennon'}), (al:Album {name: 'Imagine'}), (c:Composer {name: 'John Lennon'})
MERGE (ar)-[:PERFORMED]->(m)
MERGE (m)-[:PART_OF]->(al)
MERGE (ar)-[:RELEASED]->(al)
MERGE (m)-[:BELONGS_TO_GENRE]->(g)
MERGE (c)-[:WROTE]->(m);

// Relacionamentos para 'Billie Jean'
MATCH (m:Music {name: 'Billie Jean'}), (g:Genre {name: 'Pop'}), (ar:Artist {name: 'Michael Jackson'}), (al:Album {name: 'Thriller'}), (c:Composer {name: 'Michael Jackson'})
MERGE (ar)-[:PERFORMED]->(m)
MERGE (m)-[:PART_OF]->(al)
MERGE (ar)-[:RELEASED]->(al)
MERGE (m)-[:BELONGS_to_genre]->(g)
MERGE (c)-[:WROTE]->(m);

// Relacionamentos para 'Hotel California'
MATCH (m:Music {name: 'Hotel California'}), (g:Genre {name: 'Rock'}), (ar:Artist {name: 'Eagles'}), (al:Album {name: 'Hotel California'}), (c:Composer {name: 'Don Felder'})
MERGE (ar)-[:PERFORMED]->(m)
MERGE (m)-[:PART_OF]->(al)
MERGE (ar)-[:RELEASED]->(al)
MERGE (m)-[:BELONGS_TO_GENRE]->(g)
MERGE (c)-[:WROTE]->(m);

// Relacionamentos para 'What\'s Going On'
MATCH (m:Music {name: 'What\'s Going On'}), (g:Genre {name: 'Soul'}), (ar:Artist {name: 'Marvin Gaye'}), (al:Album {name: 'What\'s Going On'}), (c:Composer {name: 'Marvin Gaye'})
MERGE (ar)-[:PERFORMED]->(m)
MERGE (m)-[:PART_OF]->(al)
MERGE (ar)-[:RELEASED]->(al)
MERGE (m)-[:BELONGS_TO_GENRE]->(g)
MERGE (c)-[:WROTE]->(m);


// --- RELACIONAMENTOS DE ESCUTA (LISTENED_TO) ---

// Henrique
MATCH (u:User {name: 'Henrique'}), (m1:Music {name: 'Bohemian Rhapsody'}), (m2:Music {name: 'Stairway to Heaven'}), (m3:Music {name: 'Smells Like Teen Spirit'})
MERGE (u)-[:LISTENED_TO]->(m1)
MERGE (u)-[:LISTENED_TO]->(m2)
MERGE (u)-[:LISTENED_TO]->(m3);

// Beatriz
MATCH (u:User {name: 'Beatriz'}), (m1:Music {name: 'Like a Rolling Stone'}), (m2:Music {name: 'Bohemian Rhapsody'}), (m3:Music {name: 'Imagine'})
MERGE (u)-[:LISTENED_TO]->(m1)
MERGE (u)-[:LISTENED_TO]->(m2)
MERGE (u)-[:LISTENED_TO]->(m3);

// Carlos
MATCH (u:User {name: 'Carlos'}), (m1:Music {name: 'Billie Jean'}), (m2:Music {name: 'Smells Like Teen Spirit'}), (m3:Music {name: 'Hotel California'})
MERGE (u)-[:LISTENED_TO]->(m1)
MERGE (u)-[:LISTENED_TO]->(m2)
MERGE (u)-[:LISTENED_TO]->(m3);

// Diana
MATCH (u:User {name: 'Diana'}), (m1:Music {name: 'What\'s Going On'}), (m2:Music {name: 'Like a Rolling Stone'}), (m3:Music {name: 'Imagine'})
MERGE (u)-[:LISTENED_TO]->(m1)
MERGE (u)-[:LISTENED_TO]->(m2)
MERGE (u)-[:LISTENED_TO]->(m3);

