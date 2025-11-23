// Remover Restrições
DROP CONSTRAINT constraint_42a79aaf IF EXISTS;
DROP CONSTRAINT constraint_53a37553 IF EXISTS;
DROP CONSTRAINT constraint_681a03be IF EXISTS;
DROP CONSTRAINT constraint_b3c936b8 IF EXISTS;
DROP CONSTRAINT constraint_fb9e331d IF EXISTS;

// Remover Índices de propriedade (pelos nomes)
DROP INDEX index_25fd2c50 IF EXISTS;
DROP INDEX index_5ffa2b0a IF EXISTS;
DROP INDEX index_65fd4c2a IF EXISTS;
DROP INDEX index_c16a0f53 IF EXISTS;

// Limpar todos os nós e relacionamentos
MATCH (n) DETACH DELETE n;
