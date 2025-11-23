// Comandos Cypher para criar restrições e índices (garantindo unicidade e otimizando buscas)

// Restrições de unicidade para nós
CREATE CONSTRAINT FOR (m:Movie) REQUIRE m.title IS UNIQUE;
CREATE CONSTRAINT FOR (u:User) REQUIRE u.username IS UNIQUE;
CREATE CONSTRAINT FOR (a:Actor) REQUIRE a.name IS UNIQUE;
CREATE CONSTRAINT FOR (d:Director) REQUIRE d.name IS UNIQUE;
CREATE CONSTRAINT FOR (g:Genre) REQUIRE g.name IS UNIQUE;

// Índices para propriedades frequentemente buscadas
CREATE INDEX FOR (m:Movie) ON (m.releaseYear);
CREATE INDEX FOR (u:User) ON (u.email);
CREATE INDEX FOR (a:Actor) ON (a.birthDate);
CREATE INDEX FOR (d:Director) ON (d.birthDate);

// Comandos Cypher para criar nós de exemplo

// Gêneros
MERGE (:Genre {name: 'Action'});
MERGE (:Genre {name: 'Sci-Fi'});
MERGE (:Genre {name: 'Drama'});
MERGE (:Genre {name: 'Comedy'});
MERGE (:Genre {name: 'Fantasy'});
MERGE (:Genre {name: 'Horror'});
MERGE (:Genre {name: 'Thriller'});
MERGE (:Genre {name: 'Animation'});
MERGE (:Genre {name: 'Documentary'});
MERGE (:Genre {name: 'Romance'});
MERGE (:Genre {name: 'Crime'});
MERGE (:Genre {name: 'Adventure'});
MERGE (:Genre {name: 'Family'});
MERGE (:Genre {name: 'Music'});

// Atores (10 ou mais)
MERGE (:Actor {name: 'Tom Hanks', birthDate: date('1956-07-09'), birthplace: 'Concord, California, USA'});
MERGE (:Actor {name: 'Meryl Streep', birthDate: date('1949-06-22'), birthplace: 'Summit, New Jersey, USA'});
MERGE (:Actor {name: 'Leonardo DiCaprio', birthDate: date('1974-11-11'), birthplace: 'Los Angeles, California, USA'});
MERGE (:Actor {name: 'Scarlett Johansson', birthDate: date('1984-11-22'), birthplace: 'New York City, New York, USA'});
MERGE (:Actor {name: 'Dwayne Johnson', birthDate: date('1972-05-02'), birthplace: 'Hayward, California, USA'});
MERGE (:Actor {name: 'Gal Gadot', birthDate: date('1985-04-30'), birthplace: 'Petah Tikva, Israel'});
MERGE (:Actor {name: 'Christian Bale', birthDate: date('1974-01-30'), birthplace: 'Haverfordwest, Pembrokeshire, Wales'});
MERGE (:Actor {name: 'Heath Ledger', birthDate: date('1979-04-04'), birthplace: 'Perth, Western Australia, Australia'});
MERGE (:Actor {name: 'Keanu Reeves', birthDate: date('1964-09-02'), birthplace: 'Beirut, Lebanon'});
MERGE (:Actor {name: 'Carrie-Anne Moss', birthDate: date('1967-08-21'), birthplace: 'Burnaby, British Columbia, Canada'});
MERGE (:Actor {name: 'Edward Norton', birthDate: date('1969-08-18'), birthplace: 'Boston, Massachusetts, USA'});
MERGE (:Actor {name: 'Brad Pitt', birthDate: date('1963-12-18'), birthplace: 'Shawnee, Oklahoma, USA'});
MERGE (:Actor {name: 'Russell Crowe', birthDate: date('1964-04-07'), birthplace: 'Wellington, New Zealand'});
MERGE (:Actor {name: 'Joaquin Phoenix', birthDate: date('1974-10-28'), birthplace: 'San Juan, Puerto Rico'});
MERGE (:Actor {name: 'Elijah Wood', birthDate: date('1981-01-28'), birthplace: 'Cedar Rapids, Iowa, USA'});
MERGE (:Actor {name: 'Viggo Mortensen', birthDate: date('1958-10-20'), birthplace: 'New York City, New York, USA'});
MERGE (:Actor {name: 'Ian McKellen', birthDate: date('1939-05-25'), birthplace: 'Burnley, Lancashire, England'});
MERGE (:Actor {name: 'J.K. Simmons', birthDate: date('1955-01-09'), birthplace: 'Grosse Pointe, Michigan, USA'});
MERGE (:Actor {name: 'Miles Teller', birthDate: date('1987-02-20'), birthplace: 'Downingtown, Pennsylvania, USA'});
MERGE (:Actor {name: 'Ryan Gosling', birthDate: date('1980-11-12'), birthplace: 'London, Ontario, Canada'});
MERGE (:Actor {name: 'Emma Stone', birthDate: date('1988-11-06'), birthplace: 'Scottsdale, Arizona, USA'});
MERGE (:Actor {name: 'Samuel L. Jackson', birthDate: date('1948-12-21'), birthplace: 'Washington, D.C., USA'});
MERGE (:Actor {name: 'John Travolta', birthDate: date('1954-02-18'), birthplace: 'Englewood, New Jersey, USA'});
MERGE (:Actor {name: 'Uma Thurman', birthDate: date('1970-04-29'), birthplace: 'Boston, Massachusetts, USA'});


// Diretores (10)
MERGE (:Director {name: 'Steven Spielberg', birthDate: date('1946-12-18'), birthplace: 'Cincinnati, Ohio, USA'});
MERGE (:Director {name: 'Christopher Nolan', birthDate: date('1970-07-30'), birthplace: 'London, England'});
MERGE (:Director {name: 'Quentin Tarantino', birthDate: date('1963-03-27'), birthplace: 'Knoxville, Tennessee, USA'});
MERGE (:Director {name: 'Greta Gerwig', birthDate: date('1983-08-04'), birthplace: 'Sacramento, California, USA'});
MERGE (:Director {name: 'James Cameron', birthDate: date('1954-08-16'), birthplace: 'Kapuskasing, Ontario, Canada'});
MERGE (:Director {name: 'David Fincher', birthDate: date('1962-08-28'), birthplace: 'Denver, Colorado, USA'});
MERGE (:Director {name: 'Ridley Scott', birthDate: date('1937-11-30'), birthplace: 'South Shields, County Durham, England'});
MERGE (:Director {name: 'Peter Jackson', birthDate: date('1961-10-31'), birthplace: 'Pukerua Bay, New Zealand'});
MERGE (:Director {name: 'Hayao Miyazaki', birthDate: date('1941-01-05'), birthplace: 'Bunkyo, Tokyo, Japan'});
MERGE (:Director {name: 'Bong Joon-ho', birthDate: date('1969-09-14'), birthplace: 'Daegu, South Korea'});
MERGE (:Director {name: 'Damien Chazelle', birthDate: date('1985-01-19'), birthplace: 'Providence, Rhode Island, USA'});
MERGE (:Director {name: 'Lana Wachowski', birthDate: date('1965-06-21'), birthplace: 'Chicago, Illinois, USA'});
MERGE (:Director {name: 'Lilly Wachowski', birthDate: date('1967-12-29'), birthplace: 'Chicago, Illinois, USA'});
MERGE (:Director {name: 'Robert Zemeckis', birthDate: date('1952-06-14'), birthplace: 'Chicago, Illinois, USA'});
MERGE (:Director {name: 'Patty Jenkins', birthDate: date('1971-07-24'), birthplace: 'Victorville, California, USA'});


// Filmes (10)
MERGE (m1:Movie {title: 'Inception', releaseYear: 2010, duration: 148, synopsis: 'A thief who steals corporate secrets through use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.'});
MERGE (m2:Movie {title: 'The Dark Knight', releaseYear: 2008, duration: 152, synopsis: 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.'});
MERGE (m3:Movie {title: 'The Matrix', releaseYear: 1999, duration: 136, synopsis: 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.'});
MERGE (m4:Movie {title: 'Fight Club', releaseYear: 1999, duration: 139, synopsis: 'An insomniac office worker looking for a way to change his life crosses paths with a devil-may-care soap maker and they form an underground fight club that evolves into something much, much more.'});
MERGE (m5:Movie {title: 'Gladiator', releaseYear: 2000, duration: 155, synopsis: 'A Roman general is betrayed and his family murdered by an emperor\'s ambitious son. Reduced to slavery, he rises through the ranks of the gladiatorial arena to seek revenge.'});
MERGE (m6:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring', releaseYear: 2001, duration: 178, synopsis: 'A young hobbit, Frodo Baggins, inherits a magical ring that is the key to the survival or enslavement of the world. He embarks on an epic quest to destroy the Ring and save Middle-earth.'});
MERGE (m7:Movie {title: 'Spirited Away', releaseYear: 2001, duration: 125, synopsis: 'During her family\'s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.'});
MERGE (m8:Movie {title: 'Parasite', releaseYear: 2019, duration: 132, synopsis: 'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.'});
MERGE (m9:Movie {title: 'Whiplash', releaseYear: 2014, duration: 106, synopsis: 'A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are mentored by an instructor who will stop at nothing to realize a student\'s potential.'});
MERGE (m10:Movie {title: 'La La Land', releaseYear: 2016, duration: 128, synopsis: 'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.'});


// Usuários (10)
MERGE (u1:User {username: 'alice', email: 'alice@example.com', registrationDate: date('2023-01-15')});
MERGE (u2:User {username: 'bob', email: 'bob@example.com', registrationDate: date('2023-02-20')});
MERGE (u3:User {username: 'charlie', email: 'charlie@example.com', registrationDate: date('2023-03-10')});
MERGE (u4:User {username: 'david', email: 'david@example.com', registrationDate: date('2023-04-01')});
MERGE (u5:User {username: 'eve', email: 'eve@example.com', registrationDate: date('2023-05-05')});
MERGE (u6:User {username: 'frank', email: 'frank@example.com', registrationDate: date('2023-06-12')});
MERGE (u7:User {username: 'grace', email: 'grace@example.com', registrationDate: date('2023-07-21')});
MERGE (u8:User {username: 'heidi', email: 'heidi@example.com', registrationDate: date('2023-08-30')});
MERGE (u9:User {username: 'ivan', email: 'ivan@example.com', registrationDate: date('2023-09-18')});
MERGE (u10:User {username: 'judy', email: 'judy@example.com', registrationDate: date('2023-10-25')});


// Comandos Cypher para criar relacionamentos de exemplo

// Filmes e Gêneros
MATCH (m:Movie {title: 'Inception'}), (g:Genre {name: 'Sci-Fi'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Inception'}), (g:Genre {name: 'Action'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'The Dark Knight'}), (g:Genre {name: 'Action'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'The Dark Knight'}), (g:Genre {name: 'Crime'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'The Dark Knight'}), (g:Genre {name: 'Drama'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'The Matrix'}), (g:Genre {name: 'Sci-Fi'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'The Matrix'}), (g:Genre {name: 'Action'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Fight Club'}), (g:Genre {name: 'Drama'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Gladiator'}), (g:Genre {name: 'Action'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Gladiator'}), (g:Genre {name: 'Drama'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring'}), (g:Genre {name: 'Fantasy'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring'}), (g:Genre {name: 'Adventure'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Spirited Away'}), (g:Genre {name: 'Animation'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Spirited Away'}), (g:Genre {name: 'Adventure'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Spirited Away'}), (g:Genre {name: 'Family'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Parasite'}), (g:Genre {name: 'Comedy'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Parasite'}), (g:Genre {name: 'Drama'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Parasite'}), (g:Genre {name: 'Thriller'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Whiplash'}), (g:Genre {name: 'Drama'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'Whiplash'}), (g:Genre {name: 'Music'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'La La Land'}), (g:Genre {name: 'Drama'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'La La Land'}), (g:Genre {name: 'Music'}) MERGE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: 'La La Land'}), (g:Genre {name: 'Romance'}) MERGE (m)-[:HAS_GENRE]->(g);


// Filmes e Diretores
MATCH (m:Movie {title: 'Inception'}), (d:Director {name: 'Christopher Nolan'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'The Dark Knight'}), (d:Director {name: 'Christopher Nolan'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'The Matrix'}), (d:Director {name: 'Lana Wachowski'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'The Matrix'}), (d:Director {name: 'Lilly Wachowski'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'Fight Club'}), (d:Director {name: 'David Fincher'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'Gladiator'}), (d:Director {name: 'Ridley Scott'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring'}), (d:Director {name: 'Peter Jackson'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'Spirited Away'}), (d:Director {name: 'Hayao Miyazaki'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'Parasite'}), (d:Director {name: 'Bong Joon-ho'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'Whiplash'}), (d:Director {name: 'Damien Chazelle'}) MERGE (m)-[:DIRECTED_BY]->(d);
MATCH (m:Movie {title: 'La La Land'}), (d:Director {name: 'Damien Chazelle'}) MERGE (m)-[:DIRECTED_BY]->(d);


// Filmes e Atores
MATCH (m:Movie {title: 'Inception'}), (a:Actor {name: 'Leonardo DiCaprio'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'The Dark Knight'}), (a:Actor {name: 'Christian Bale'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'The Dark Knight'}), (a:Actor {name: 'Heath Ledger'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'The Matrix'}), (a:Actor {name: 'Keanu Reeves'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'The Matrix'}), (a:Actor {name: 'Carrie-Anne Moss'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'Fight Club'}), (a:Actor {name: 'Edward Norton'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'Fight Club'}), (a:Actor {name: 'Brad Pitt'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'Gladiator'}), (a:Actor {name: 'Russell Crowe'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'Gladiator'}), (a:Actor {name: 'Joaquin Phoenix'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring'}), (a:Actor {name: 'Elijah Wood'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring'}), (a:Actor {name: 'Viggo Mortensen'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring'}), (a:Actor {name: 'Ian McKellen'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'Whiplash'}), (a:Actor {name: 'Miles Teller'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'Whiplash'}), (a:Actor {name: 'J.K. Simmons'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'La La Land'}), (a:Actor {name: 'Ryan Gosling'}) MERGE (a)-[:ACTED_IN]->(m);
MATCH (m:Movie {title: 'La La Land'}), (a:Actor {name: 'Emma Stone'}) MERGE (a)-[:ACTED_IN]->(m);


// Usuários assistindo e avaliando
MATCH (u:User {username: 'alice'}), (m:Movie {title: 'Inception'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'alice'}), (m:Movie {title: 'Inception'}) MERGE (u)-[:RATED {rating: 5}]->(m);
MATCH (u:User {username: 'bob'}), (m:Movie {title: 'The Dark Knight'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'bob'}), (m:Movie {title: 'The Dark Knight'}) MERGE (u)-[:RATED {rating: 4}]->(m);
MATCH (u:User {username: 'charlie'}), (m:Movie {title: 'The Matrix'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'charlie'}), (m:Movie {title: 'The Matrix'}) MERGE (u)-[:RATED {rating: 5}]->(m);
MATCH (u:User {username: 'david'}), (m:Movie {title: 'Fight Club'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'david'}), (m:Movie {title: 'Fight Club'}) MERGE (u)-[:RATED {rating: 4}]->(m);
MATCH (u:User {username: 'eve'}), (m:Movie {title: 'Gladiator'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'eve'}), (m:Movie {title: 'Gladiator'}) MERGE (u)-[:RATED {rating: 5}]->(m);
MATCH (u:User {username: 'frank'}), (m:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'frank'}), (m:Movie {title: 'The Lord of the Rings: The Fellowship of the Ring'}) MERGE (u)-[:RATED {rating: 5}]->(m);
MATCH (u:User {username: 'grace'}), (m:Movie {title: 'Spirited Away'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'grace'}), (m:Movie {title: 'Spirited Away'}) MERGE (u)-[:RATED {rating: 4}]->(m);
MATCH (u:User {username: 'heidi'}), (m:Movie {title: 'Parasite'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'heidi'}), (m:Movie {title: 'Parasite'}) MERGE (u)-[:RATED {rating: 5}]->(m);
MATCH (u:User {username: 'ivan'}), (m:Movie {title: 'Whiplash'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'ivan'}), (m:Movie {title: 'Whiplash'}) MERGE (u)-[:RATED {rating: 4}]->(m);
MATCH (u:User {username: 'judy'}), (m:Movie {title: 'La La Land'}) MERGE (u)-[:WATCHED]->(m);
MATCH (u:User {username: 'judy'}), (m:Movie {title: 'La La Land'}) MERGE (u)-[:RATED {rating: 5}]->(m);


// Usuários e Gêneros Favoritos
MATCH (u:User {username: 'alice'}), (g:Genre {name: 'Sci-Fi'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'bob'}), (g:Genre {name: 'Action'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'charlie'}), (g:Genre {name: 'Sci-Fi'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'david'}), (g:Genre {name: 'Drama'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'eve'}), (g:Genre {name: 'Action'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'frank'}), (g:Genre {name: 'Fantasy'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'grace'}), (g:Genre {name: 'Animation'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'heidi'}), (g:Genre {name: 'Thriller'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'ivan'}), (g:Genre {name: 'Music'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);
MATCH (u:User {username: 'judy'}), (g:Genre {name: 'Romance'}) MERGE (u)-[:HAS_FAVORITE_GENRE]->(g);