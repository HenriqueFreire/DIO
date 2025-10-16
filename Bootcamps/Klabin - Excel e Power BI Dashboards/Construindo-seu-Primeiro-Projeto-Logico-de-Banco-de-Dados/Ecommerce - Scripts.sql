-- Apaga o banco de dados se ele já existir, para um ambiente de testes limpo.
DROP DATABASE IF EXISTS ecommerce;
-- CRIANDO AS TABELAS

create database ecommerce;
use ecommerce;

-- criação tabela cliente
create table client(
    idClient int auto_increment primary key,
    Fname varchar(30),
    Minit char(3), 
    Lname varchar(20),
    CPF char(11),
    CNPJ char(14),
    Address varchar(255),
    ClientType enum('PF', 'PJ') not null,
    constraint unique_cpf_client unique (CPF),
    constraint unique_cnpj_client unique (CNPJ),
    constraint chk_client_type check (
        (ClientType = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR
        (ClientType = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL)
    )
);

-- criação tabela produto
create table product(
    idProduct int auto_increment primary key,
    Pname varchar(40) not null,
    classification_kids boolean default false,
    category enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    rating decimal(3,1) default 0,
    size varchar(20)
);

-- criação tabela pagamento
create table payment(
    idPayment int auto_increment primary key,
    idClient int,
    typePayment enum('Boleto','Cartão','Dois Cartões'),
    limitAvailable decimal(10,2),
    constraint fk_payment_client foreign key (idClient) references client(idClient) on delete cascade
);

-- criação tabela pedido
create table orders(
    idOrder int auto_increment primary key,
    idClient int,
    idPayment int,
    orderStatus enum('Cancelado','Confirmado','Em Processamento') default 'Em Processamento',
    orderDescription varchar(255),
    sendValue decimal(10,2) default 10.00,
    paymentCash boolean default false,
    trackingCode varchar(50),
    constraint fk_orders_client foreign key (idClient) references client(idClient) on delete restrict,
    constraint fk_orders_payment foreign key (idPayment) references payment(idPayment) on delete restrict
);

-- criação tabela fornecedor
create table supplier(
    idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(14) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- criação tabela vendedor
create table seller(
    idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(14),
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF),
    constraint chk_seller_doc check (CNPJ is not null or CPF is not null)
);

-- criação tabela vendedor terceiros
create table productSeller(
    idPseller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller) on delete cascade,
    constraint fk_product_product foreign key (idProduct) references product(idProduct) on delete cascade
);

-- criação tabela product order
create table productOrder(
    idPoProduct int,
    idPorder int,
    poQuantity int default 1,    
    primary key (idPoProduct, idPorder),
    constraint fk_productorder_product foreign key (idPoProduct) references product(idProduct) on delete restrict,
    constraint fk_productorder_order foreign key (idPorder) references orders(idOrder) on delete restrict
);

-- INSERINDO REGISTROS
-- Inserindo dados na tabela client
insert into client (Fname, Minit, Lname, CPF, Address, ClientType) values
('João', 'A', 'Silva', '12345678901', 'Rua A, 123', 'PF'),
('Maria', 'B', 'Oliveira', '23456789012', 'Rua B, 456', 'PF'),
('Carlos', 'C', 'Santos', '34567890123', 'Rua C, 789', 'PF'),
('Ana', 'D', 'Costa', '45678901234', 'Rua D, 101', 'PF'),
('Pedro', 'E', 'Ferreira', '56789012345', 'Rua E, 202', 'PF'),
('Lucas', 'F', 'Martins', '67890123456', 'Rua F, 303', 'PF'),
('Julia', 'G', 'Almeida', '78901234567', 'Rua G, 404', 'PF'),
('Mariana', 'H', 'Lima', '89012345678', 'Rua H, 505', 'PF'),
('Rafael', 'I', 'Gomes', '90123456789', 'Rua I, 606', 'PF'),
('Fernanda', 'J', 'Ribeiro', '01234567890', 'Rua J, 707', 'PF');

-- Inserindo dados na tabela product
insert into product (Pname, classification_kids, category, rating, size) values
('Laptop', false, 'Eletronico', 4.5, 'Médio'),
('Camiseta', false, 'Vestimenta', 4.0, 'Grande'),
('Boneca', true, 'Brinquedos', 4.8, 'Pequeno'),
('Smartphone', false, 'Eletronico', 4.7, 'Pequeno'),
('Calça', false, 'Vestimenta', 4.2, 'Médio'),
('Carrinho', true, 'Brinquedos', 4.9, 'Grande'),
('TV', false, 'Eletronico', 4.6, 'Grande'),
('Sapato', false, 'Vestimenta', 4.3, 'Pequeno'),
('Jogo', true, 'Brinquedos', 4.5, 'Médio'),
('Mesa', false, 'Móveis', 4.4, 'Grande');

-- Inserindo dados na tabela payment
insert into payment (idClient, typePayment, limitAvailable) values
(1, 'Cartão', 5000.00),
(2, 'Boleto', 2000.00),
(3, 'Dois Cartões', 3000.00),
(4, 'Cartão', 4000.00),
(5, 'Boleto', 2500.00),
(6, 'Dois Cartões', 3500.00),
(7, 'Cartão', 4500.00),
(8, 'Boleto', 2200.00),
(9, 'Dois Cartões', 3300.00),
(10, 'Cartão', 4800.00);

-- Inserindo dados na tabela orders
insert into orders (idClient, idPayment, orderStatus, orderDescription, sendValue, paymentCash, trackingCode) values
(1, 1, 'Confirmado', 'Compra de um laptop', 15.00, false, 'TRK123456'),
(2, 2, 'Em Processamento', 'Compra de uma camiseta', 10.00, true, 'TRK234567'),
(3, 3, 'Cancelado', 'Compra de uma boneca', 12.00, false, 'TRK345678'),
(4, 4, 'Confirmado', 'Compra de um smartphone', 20.00, false, 'TRK456789'),
(5, 5, 'Em Processamento', 'Compra de uma calça', 8.00, true, 'TRK567890'),
(6, 6, 'Confirmado', 'Compra de um carrinho', 18.00, false, 'TRK678901'),
(7, 7, 'Cancelado', 'Compra de uma TV', 25.00, false, 'TRK789012'),
(8, 8, 'Em Processamento', 'Compra de um sapato', 7.00, true, 'TRK890123'),
(9, 9, 'Confirmado', 'Compra de um jogo', 15.00, false, 'TRK901234'),
(10, 10, 'Em Processamento', 'Compra de uma mesa', 30.00, true, 'TRK012345');

-- Inserindo dados na tabela supplier
insert into supplier (SocialName, CNPJ, contact) values
('Fornecedor A', '12345678000101', '11987654321'),
('Fornecedor B', '23456789000102', '11987654322'),
('Fornecedor C', '34567890000103', '11987654323'),
('Fornecedor D', '45678901000104', '11987654324'),
('Fornecedor E', '56789012000105', '11987654325'),
('Fornecedor F', '67890123000106', '11987654326'),
('Fornecedor G', '78901234000107', '11987654327'),
('Fornecedor H', '89012345000108', '11987654328'),
('Fornecedor I', '90123456000109', '11987654329'),
('Fornecedor J', '01234567000110', '11987654330');

-- Inserindo dados na tabela seller
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
('Vendedor A', 'VDA', '12345678000101', null, 'Rua D, 123', '11987654321'),
('Vendedor B', 'VDB', '23456789000102', null, 'Rua E, 456', '11987654322'),
('Vendedor C', 'VDC', '34567890000103', null, 'Rua F, 789', '11987654323'),
('Vendedor D', 'VDD', '45678901000104', null, 'Rua G, 101', '11987654324'),
('Vendedor E', 'VDE', '56789012000105', null, 'Rua H, 202', '11987654325'),
('Vendedor F', 'VDF', null, '67890123456', 'Rua I, 303', '11987654326'),
('Vendedor G', 'VDG', null, '78901234567', 'Rua J, 404', '11987654327'),
('Vendedor H', 'VDH', null, '89012345678', 'Rua K, 505', '11987654328'),
('Vendedor I', 'VDI', null, '90123456789', 'Rua L, 606', '11987654329'),
('Vendedor J', 'VDJ', null, '01234567890', 'Rua M, 707', '11987654330');

-- Inserindo dados na tabela productSeller
insert into productSeller (idPseller, idProduct, prodQuantity) values
(1, 1, 10),
(2, 2, 20),
(3, 3, 30),
(4, 4, 40),
(5, 5, 50),
(6, 6, 60),
(7, 7, 70),
(8, 8, 80),
(9, 9, 90),
(10, 10, 100);

-- Inserindo dados na tabela productOrder
insert into productOrder (idPoProduct, idPorder, poQuantity) values
(1, 1, 1),
(2, 2, 1),
(4, 4, 2),
(6, 6, 1);

-- QUERIES

-- Quantos pedidos foram feitos por cada cliente?
   
   select client.Fname, client.Lname, count(orders.idOrder) as TotalOrders
   from client 
   left join orders on client.idClient = orders.idClient
   group by client.idClient;
   

-- Algum vendedor também é fornecedor?
   
   select seller.SocialName as SellerName, supplier.SocialName as SupplierName
   from seller 
   join supplier on seller.CNPJ = supplier.CNPJ;
   

-- Relação de produtos fornecedores e estoques
-- Esta query agora mostra o estoque disponível por vendedor.
   select p.Pname as ProductName, s.SocialName as SellerName, ps.prodQuantity as StockQuantity
   from product as p
   join productSeller as ps on p.idProduct = ps.idProduct
   join seller as s on ps.idPseller = s.idSeller
   order by p.Pname;
   

-- Relação de nomes dos fornecedores e nomes dos produtos
   
   select supplier.SocialName as SupplierName, product.Pname as ProductName
   from supplier
   join seller on supplier.CNPJ = seller.CNPJ
   join productSeller on seller.idSeller = productSeller.idPseller
   join product on productSeller.idProduct = product.idProduct;
   

-- Qual a quantidade total de cada produto em estoque?
-- Esta query agora soma o estoque de um produto em todos os vendedores.
   select p.Pname, sum(ps.prodQuantity) as TotalStock
   from product as p
   join productSeller as ps on p.idProduct = ps.idProduct
   group by p.idProduct;
   
-- Recuperações simples com SELECT Statement

   -- Recuperar todos os clientes
   select * from client;

   -- Recuperar todos os produtos
   select * from product;
  
-- Filtros com WHERE Statement
  
   -- Recuperar clientes com sobrenome 'Santos'
   select * from client
   where Lname = 'Santos';

   -- Recuperar produtos da categoria 'Eletronico'
   select * from product
   where category = 'Eletronico';

-- Crie expressões para gerar atributos derivados:

-- Calcular o valor total dos pedidos (sendValue + 10% de taxa) com apenas 2 dígitos
select idOrder, orderDescription, sendValue, round(sendValue * 1.10, 2) as TotalValue
from orders;

-- Calcular a média de avaliação dos produtos com apenas 2 dígitos
select category, round(avg(rating), 2) as AverageRating
from product
group by category;
  

-- Defina ordenações dos dados com ORDER BY:

   -- Ordenar clientes pelo sobrenome em ordem alfabética
   select * from client
   order by Lname;

   -- Ordenar produtos pelo preço (rating) em ordem decrescente
   select * from product
   order by rating desc;


-- Condições de filtros aos grupos – HAVING Statement:

-- Recuperar categorias de produtos com média de avaliação maior que 4.5, arredondada para 2 dígitos
select category, round(avg(rating), 2) as AverageRating
from product
group by category
having round(avg(rating), 2) > 4.5;
 
-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados:
   
   -- Recuperar informações dos pedidos junto com os dados dos clientes
   select orders.idOrder, orders.orderDescription, client.Fname, client.Lname
   from orders
   join client on orders.idClient = client.idClient;

   -- Recuperar informações dos produtos junto com os dados dos fornecedores
   select product.Pname, supplier.SocialName
   from product
   join productSeller on product.idProduct = productSeller.idProduct
   join seller on productSeller.idPseller = seller.idSeller
   join supplier on seller.CNPJ = supplier.CNPJ;

-- =================================================================================
-- LÓGICA DE NEGÓCIO COM STORED PROCEDURES
-- =================================================================================

-- Mudando o delimitador para poder criar a procedure
DELIMITER $$

CREATE PROCEDURE create_order(
    IN in_idClient INT,
    IN in_idProduct INT,
    IN in_quantity INT,
    IN in_idPayment INT
)
BEGIN
    DECLARE available_stock INT DEFAULT 0;
    DECLARE new_order_id INT;

    -- Inicia uma transação para garantir a atomicidade da operação
    START TRANSACTION;

    -- Verifica o estoque disponível na tabela productSeller
    SELECT prodQuantity INTO available_stock
    FROM productSeller
    WHERE idProduct = in_idProduct
    FOR UPDATE; -- Bloqueia a linha para evitar condições de corrida

    IF available_stock >= in_quantity THEN
        -- Se houver estoque, atualiza a quantidade
        UPDATE productSeller SET prodQuantity = prodQuantity - in_quantity WHERE idProduct = in_idProduct;

        -- Cria o novo pedido
        INSERT INTO orders (idClient, idPayment, orderStatus, orderDescription) 
        VALUES (in_idClient, in_idPayment, 'Em Processamento', CONCAT('Pedido de ', in_quantity, ' unidade(s) do produto ', in_idProduct));
        SET new_order_id = LAST_INSERT_ID();

        -- Associa o produto ao pedido
        INSERT INTO productOrder (idPoProduct, idPorder, poQuantity) VALUES (in_idProduct, new_order_id, in_quantity);

        COMMIT;
    ELSE
        -- Se não houver estoque, desfaz a transação e sinaliza um erro
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Estoque insuficiente para o produto solicitado.';
    END IF;
END$$

-- Retorna o delimitador ao padrão
DELIMITER ;
   