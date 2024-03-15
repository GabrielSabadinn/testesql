-- Database: provadeSQL

-- DROP DATABASE IF EXISTS "provadeSQL";

CREATE DATABASE "provadeSQL"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	
	CREATE TABLE EMPRESA 
( 
    id_empresa   SERIAL PRIMARY KEY, 
    razao_social VARCHAR(255) NOT NULL, 
    inativo      BOOLEAN      NOT NULL 
); 

CREATE TABLE PRODUTOS 
( 
    id_produto SERIAL PRIMARY KEY, 
    descricao  VARCHAR(255) NOT NULL, 
    inativo    BOOLEAN      NOT NULL 
); 

CREATE TABLE VENDEDORES 
( 
    id_vendedor   SERIAL PRIMARY KEY, 
    nome          VARCHAR(255)   NOT NULL, 
    cargo         VARCHAR(100)   NOT NULL, 
    salario       DECIMAL(10, 2) NOT NULL, 
    data_admissao DATE           NOT NULL, 
    inativo       BOOLEAN        NOT NULL 
); 

CREATE TABLE CONFIG_PRECO_PRODUTO 
( 
    id_config_preco_produto SERIAL PRIMARY KEY, 
    id_vendedor             INTEGER REFERENCES VENDEDORES (id_vendedor), 
    id_empresa              INTEGER REFERENCES EMPRESA (id_empresa), 
    id_produto              INTEGER REFERENCES PRODUTOS (id_produto), 
    preco_minimo            DECIMAL(10, 2) NOT NULL, 
    preco_maximo            DECIMAL(10, 2) NOT NULL 
); 

CREATE TABLE CLIENTES 
( 
    id_cliente    SERIAL PRIMARY KEY, 
    razao_social  VARCHAR(255) NOT NULL, 
    data_cadastro DATE         NOT NULL, 
    id_vendedor   INTEGER REFERENCES VENDEDORES (id_vendedor), 
    id_empresa    INTEGER REFERENCES EMPRESA (id_empresa), 
    inativo       BOOLEAN      NOT NULL 
); 

CREATE TABLE PEDIDO 
( 
    id_pedido    SERIAL PRIMARY KEY, 
    id_empresa   INTEGER REFERENCES EMPRESA (id_empresa), 
    id_cliente   INTEGER REFERENCES CLIENTES (id_cliente), 
    valor_total  DECIMAL(10, 2) NOT NULL, 
    data_emissao DATE           NOT NULL, 
    situacao     VARCHAR(50)    NOT NULL 
); 

CREATE TABLE ITENS_PEDIDO 
( 
    id_item_pedido  SERIAL PRIMARY KEY, 
    id_pedido       INTEGER REFERENCES PEDIDO (id_pedido), 
    id_produto      INTEGER REFERENCES PRODUTOS (id_produto), 
    preco_praticado DECIMAL(10, 2) NOT NULL, 
    quantidade      INTEGER        NOT NULL 
); 

-- Criação das Tabelas acima
-- inserts abaixo

INSERT INTO EMPRESA (razao_social, inativo) 
VALUES ('Empresa A', FALSE), 
       ('Empresa B', FALSE); 

INSERT INTO PRODUTOS (descricao, inativo) 
VALUES ('Produto 1', FALSE), 
       ('Produto 2', FALSE); 

INSERT INTO VENDEDORES (nome, cargo, salario, data_admissao, inativo) 
VALUES ('Vendedor 1', 'Cargo 1', 5000.00, '2022-01-01', FALSE), 
       ('Vendedor 2', 'Cargo 2', 6000.00, '2022-02-01', FALSE); 

INSERT INTO CLIENTES (razao_social, data_cadastro, id_vendedor, id_empresa, inativo) 
VALUES ('Cliente A', '2022-01-15', 1, 1, FALSE), 
       ('Cliente B', '2022-02-01', 2, 2, FALSE); 

INSERT INTO CONFIG_PRECO_PRODUTO (id_vendedor, id_empresa, id_produto, preco_minimo, preco_maximo) 
VALUES (1, 1, 1, 50.00, 100.00), 
       (2, 2, 2, 60.00, 120.00); 

-- insercao dos 20 pedidos
INSERT INTO PEDIDO (id_pedido, id_empresa, id_cliente, valor_total, data_emissao, situacao) 
VALUES (1, 1, 1, 120.00, '2022-03-03', 'Fechado'), 
       (2, 1, 2, 45.50, '2022-03-04', 'Aberto'), 
       (3, 2, 1, 80.00, '2022-03-05', 'Fechado'), 
       (4, 2, 2, 60.25, '2022-03-06', 'Fechado'), 
       (5, 1, 1, 35.75, '2022-03-07', 'Aberto'), 
       (6, 2, 2, 55.50, '2022-03-08', 'Aberto'), 
       (7, 1, 1, 95.25, '2022-03-09', 'Aberto'), 
       (8, 2, 2, 42.00, '2022-03-10', 'Fechado'), 
       (9, 1, 1, 75.50, '2022-03-11', 'Fechado'), 
       (10, 1, 2, 60.00, '2022-03-12', 'Aberto'), 
       (11, 2, 1, 110.75, '2022-03-13', 'Fechado'), 
       (12, 2, 2, 38.25, '2022-03-14', 'Fechado'), 
       (13, 1, 1, 88.50, '2022-03-15', 'Aberto'), 
       (14, 1, 2, 70.00, '2022-03-16', 'Aberto'), 
       (15, 2, 1, 50.25, '2022-03-17', 'Aberto'), 
       (16, 2, 2, 65.75, '2022-03-18', 'Fechado'), 
       (17, 1, 1, 42.00, '2022-03-19', 'Fechado'), 
       (18, 1, 2, 90.50, '2022-03-20', 'Aberto'), 
       (19, 2, 1, 55.25, '2022-03-21', 'Aberto'), 
       (20, 2, 2, 78.00, '2022-03-22', 'Fechado'); 


-- insercao dos 20 intens para os 20pedidos
INSERT INTO ITENS_PEDIDO (id_pedido, id_produto, preco_praticado, quantidade) 
VALUES 
    --Pedido 1 
    (1, 1, 75.00, 2), 

    --2 
    (2, 2, 90.00, 1), 

    --3 
    (3, 1, 55.00, 3), 
    (3, 2, 65.50, 2), 

    --4 
    (4, 2, 30.25, 1), 
    (4, 1, 50.75, 4), 

    --5 
    (5, 1, 20.50, 2), 

    --6 
    (6, 2, 45.25, 3), 
    (6, 1, 10.00, 1), 

    --7 
    (7, 1, 75.00, 5), 

    --8 
    (8, 2, 20.50, 2), 
    (8, 1, 21.50, 1), 

    --9 
    (9, 1, 30.00, 2), 
    (9, 2, 45.50, 3), 

    --10 
    (10, 2, 30.25, 1), 
    (10, 1, 30.75, 4), 

    --11 
    (11, 1, 45.50, 3), 

    --12 
    (12, 2, 25.25, 2), 
    (12, 1, 40.00, 1), 

    -- 13 
    (13, 1, 55.75, 4), 

    --
    (14, 2, 30.00, 2), 
    (14, 1, 40.50, 1), 

    --15
    (15, 1, 35.50, 3), 

    --16
    (16, 2, 15.25, 2), 
    (16, 1, 35.00, 1), 

    --17 
    (17, 1, 50.00, 5), 

    -- 18 
    (18, 2, 25.50, 2), 
    (18, 1, 40.25, 1), 

    --  19 
    (19, 1, 30.75, 3), 
    (19, 2, 59.50, 2), 

    --20 
    (20, 2, 40.00, 1), 
    (20, 1, 38.50, 4); 
--oque foi pedido abaixo
--Lista de funcionários ordenando pelo salário decrescente:
SELECT * FROM VENDEDORES ORDER BY salario DESC;

--Lista de pedidos de vendas ordenado por data de emissão.
SELECT * FROM PEDIDO ORDER BY data_emissao;

--Valor de faturamento por cliente.
SELECT id_cliente, SUM(valor_total) AS faturamento
FROM PEDIDO
GROUP BY id_cliente;

--Valor de faturamento por empresa.
SELECT id_empresa, SUM(valor_total) AS faturamento
FROM PEDIDO
GROUP BY id_empresa;

--Valor de faturamento por vendedor.
SELECT id_vendedor, SUM(valor_total) AS faturamento
FROM PEDIDO
JOIN CLIENTES ON PEDIDO.id_cliente = CLIENTES.id_cliente
GROUP BY id_vendedor;

--consultas de juncao eu vou escrever o codigo e abaixo dele vai tar a explicacao de oque eu fiz:

WITH UltimosPedidos AS (
    SELECT 
        id_cliente,
        id_pedido,
        ROW_NUMBER() OVER (PARTITION BY id_cliente ORDER BY data_emissao DESC) AS num_linha
    FROM PEDIDO
)
SELECT 
    CP.id_produto, --Id do produto em questão;
    PR.descricao, --Descrição do produto;
    C.id_cliente, --Id do cliente do pedido;
    C.razao_social AS cliente_razao_social, --Razão social do cliente;
    C.id_empresa, --Id da empresa do pedido;
    E.razao_social AS empresa_razao_social, ---Razão social da empresa;
    C.id_vendedor, -- Id do vendedor do pedido;
    V.nome AS nome_vendedor, --Nome do vendedor;
    CP.preco_minimo, --Preço mínimo e máximo da configuração de preço;
    CP.preco_maximo, --Preço base do produto conforme a regra.
    IP.preco_praticado AS preco_base
FROM UltimosPedidos AS UP
JOIN PEDIDO AS P ON UP.id_pedido = P.id_pedido
JOIN ITENS_PEDIDO AS IP ON P.id_pedido = IP.id_pedido
JOIN CLIENTES AS C ON P.id_cliente = C.id_cliente
JOIN EMPRESA AS E ON P.id_empresa = E.id_empresa
JOIN CONFIG_PRECO_PRODUTO AS CP ON 
    IP.id_produto = CP.id_produto 
    AND C.id_vendedor = CP.id_vendedor
    AND P.id_empresa = CP.id_empresa
JOIN VENDEDORES AS V ON CP.id_vendedor = V.id_vendedor
JOIN PRODUTOS AS PR ON IP.id_produto = PR.id_produto 
WHERE UP.num_linha = 1;


--with  ultimospedidos to usando o with para criar a subconsulta, essa subconsulta pega cada pedido de cliente e 
--atribui um numero de linha, comeca pelo numero 1 o pedido mais recente 
--select eu escrevi do lado enfim to dando um "select nos itens" 
-- o from eu uso pra afirmar que os dados sao relacionados a partir da subconsulta que eu fiz
--join faco a juncao das tabelas pra pegar os dados
--where eu filtro apenas os pedidos que tem o numero 1 de linha
-- acredito que essa nao seja a melhor maneira de fazer isso porem foi a menor e mais otimizada que eu achei
