-----------------------------------
-- Criação do banco de dados ERP --
-----------------------------------
CREATE DATABASE ERP;

-- Setar o banco como padrão
USE ERP;

-------------------------
-- Criação das tabelas --
-------------------------
-- Criação da Tabela de Vendedores
CREATE TABLE TbVendedor (
   CdVdd int primary key,
   NmVdd varchar(20),
   SxVdd int,
   PercComissao decimal(19,2)
); -- DROP TABLE tbvendedor;

-- Criação da Tabela de Vendas
CREATE TABLE TbVendas (
   CdVen int primary key,
   DtVen datetime,
   CdCli int,
   NmCli varchar(100),
   Cidade varchar(45),
   Estado varchar(45),
   Pais varchar(45),
   CdPro int,
   NmPro varchar(45),
   TpPro varchar(5),
   Qtd int,
   Und varchar(5),
   VrUnt decimal(19,2),
   CdVdd int,
   CdCanalVendas int,
   NmCanalVendas varchar(20),
   status varchar(15),
   deletado char -- 1 deletado
); -- DROP TABLE tbvendas;

-- Adicionando foreign key - relacionamento
ALTER TABLE tbvendas ADD CONSTRAINT `fk_vendas_vendedor` FOREIGN KEY ( CdVdd ) REFERENCES tbvendedor ( CdVdd );

-- Criação da Tabela Dependente
CREATE TABLE TbDependente (
   CdDep int primary key,
   NmDep varchar(20),
   DtNasc datetime,
   SxDep varchar(10),
   CdVdd int,
   InepEscola varchar(10) -- Enriquecimento de dado
); -- DROP TABLE tbdependente

-- Adicionando foreign key - relacionamento
ALTER TABLE tbdependente ADD CONSTRAINT `fk_vendedor_dependente` FOREIGN KEY ( CdVdd ) REFERENCES tbvendedor ( CdVdd );

-- Criação da Tabela Estoque de Produtos
CREATE TABLE TbEstoqueProduto (
   CdPro  int primary key,
   QtdPro int, 
   Status varchar(15)
); -- DROP TABLE TbEstoqueProduto

-- Adicionando foreign key - relacionamento (vendas com EstoqueProduto)
ALTER TABLE tbvendas ADD CONSTRAINT `fk_vendas_produto_estoque` FOREIGN KEY ( CdPro ) REFERENCES TbEstoqueProduto ( CdPro );

------------------------
-- Populando  tabelas --
------------------------

-- Estoque Produto
INSERT INTO tbestoqueproduto VALUES (1, 20000, 'Ativo');
INSERT INTO tbestoqueproduto VALUES (2, 5000, 'Ativo');
INSERT INTO tbestoqueproduto VALUES (3, 2000, 'Ativo');
INSERT INTO tbestoqueproduto VALUES (4, 30000, 'Ativo');
INSERT INTO tbestoqueproduto VALUES (5, 2000, 'Ativo');
INSERT INTO tbestoqueproduto VALUES (6, 1000, 'MVP - validação');

-- Visualizando os dados
SELECT * FROM tbestoqueproduto;

-- Vendedores
INSERT INTO tbvendedor VALUES ( 1, 'Vendedor 1'   , 1, 1);
INSERT INTO tbvendedor VALUES ( 2, 'Vendedor 2  ' , 1, 1);
INSERT INTO tbvendedor VALUES ( 3, 'Vendedor 3'   , 1, 1);
INSERT INTO tbvendedor VALUES ( 4, 'Vendedor 4'   , 1, 0.5);
INSERT INTO tbvendedor VALUES ( 5, 'Vendedor 5'   , 0, 0.5);
INSERT INTO tbvendedor VALUES ( 6, 'Vendedor  6  ', 0, 0.5);
INSERT INTO tbvendedor VALUES ( 7, 'Vendedor 7'   , 0, 0.5);
INSERT INTO tbvendedor VALUES ( 8, 'Vendedor 8'   , 0, 0.5);
INSERT INTO tbvendedor VALUES ( 9, 'Vendedor 9'   , 0, 0.5);
INSERT INTO tbvendedor VALUES (10, 'Vendedor 10'  , 0, 0.5);

-- Visualizando os dados
SELECT * FROM tbvendedor;

-- Vendas
INSERT INTO tbvendas VALUES (1, '20100201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  4000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (3, '20100201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  4200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (4, '20100202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (5, '20100203', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (7, '20100305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (8, '20100306', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 12000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (9, '20100407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 17500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (11,'20111208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 7000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (12,'20121208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 8000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (13,'20131208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 8000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (14,'20141208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 9000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (15,'20151208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 9000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (16,'20161208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 10000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (17,'20171208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 10000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (18,'20181208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 11000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (19,'20191208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 11000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (20,'20201208', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 12000, 'KG', 0.34, 9, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (21,'20210109', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 5000, 'KG', 0.34, 9, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (22,'20210307', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 5000, 'KG', 0.34, 9, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (38,'20210407', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 10000, 'KG', 0.34, 9, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (23,'20210807', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 20000, 'KG', 0.34, 9, 2, 'Ecommerce', 'Em aberto', 1);
INSERT INTO tbvendas VALUES (24,'20210808', 2,  'Cliente EF', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A', 25000, 'KG', 0.34, 9, 1, 'Matriz', 'Cancelado', 0);
INSERT INTO tbvendas VALUES (25, '20100407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 9000, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (26, '20110407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 9500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (27, '20120407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 9500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (28, '20130407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 9500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (29, '20140407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 9500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (30, '20140407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 9500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (31, '20150407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 10500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (32, '20160407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 11500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (33, '20170407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (34, '20180407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 13500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (35, '20190407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 14500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (36, '20200407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 15500, 'KG', 0.34, 3, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (37, '20210407', 8,  'Cliente EE', 'Natal'          , 'Rio Grande do Norte', 'Brasil', 1, 'Produto A', 'A', 17500, 'KG', 0.34, 3, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (39, '20110201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  4000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (40, '20120201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  14000, 'KG', 0.34, 2, 1, 'Matriz', 'Em aberto', 0);
INSERT INTO tbvendas VALUES (41, '20130201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  24000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (42, '20140201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  34000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (43, '20150201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  44000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (45, '20170201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  4000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (46, '20180201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  4000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (47, '20190201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  4000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (48, '20200201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  4000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (49, '20210201', 1,  'Cliente AA', 'Florianópolis'  , 'Santa Catarina'     , 'Brasil', 1, 'Produto A', 'A',  14000, 'KG', 0.34, 2, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (50, '20110201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  4200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (51, '20120201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  4200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (52, '20130201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  4200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (53, '20140201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  14200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (54, '20150201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  14200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (55, '20160201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  24200, 'KG', 0.34, 4, 1, 'Matriz', 'Em aberto', 1);
INSERT INTO tbvendas VALUES (56, '20170201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  24200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (57, '20180201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  24200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (58, '20190201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  24200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (59, '20200201', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  4200, 'KG', 0.34, 4, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (60, '20210807', 5,  'Cliente BB', 'Belo Horizonte' , 'Minas Gerais'       , 'Brasil', 1, 'Produto A', 'A',  4200, 'KG', 0.34, 4, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (61, '20110201', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (62, '20120203', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (63, '20130202', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (64, '20140203', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (65, '20150203', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (66, '20160203', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (67, '20170404', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 1, 'Matriz', 'Em aberto', 1);
INSERT INTO tbvendas VALUES (68, '20180505', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (69, '20190607', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (70, '20200707', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (71, '20210807', 4,  'Cliente CC', 'Fortaleza'      , 'Ceará'              , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 1, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (72, '20110305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (73, '20130305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (74, '20150305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (75, '20170305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (76, '20180305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (77, '20190305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (78, '20200305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (79, '20210305', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (80, '20210405', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (81, '20210807', 6,  'Cliente DD', 'Goiânia'        , 'Goiás'              , 'Brasil', 1, 'Produto A', 'A', 12500, 'KG', 0.34, 2, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (82, '20120306', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 12000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (83, '20140306', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 12000, 'KG', 0.34, 2, 1, 'Matriz', 'Cancelado', 0);
INSERT INTO tbvendas VALUES (84, '20160306', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 12000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (85, '20190306', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 12000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (86, '20200306', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 22000, 'KG', 0.34, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (87, '20210306', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 22000, 'KG', 0.34, 2, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (88, '20210606', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 42000, 'KG', 0.34, 2, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (89, '20210807', 7,  'Cliente DE', 'João Pessoa'    , 'Paraíba'            , 'Brasil', 1, 'Produto A', 'A', 52000, 'KG', 0.34, 2, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (90, '20110202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   11250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (91, '20120202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   12250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (92, '20130202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   13250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (93, '20140202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   14250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (94, '20150202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (95, '20160202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   16250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (96, '20170202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   17250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (97, '20180202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   18250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (98, '20190202', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   19250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (99, '20200302', 3,  'Cliente BC', 'Baturité'       , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   19250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (100, '20210702', 3,  'Cliente BC', 'Baturité'      , 'Ceará'              , 'Brasil', 2, 'Produto C', 'A',   19250, 'KG', 7.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (101, '20150202', 10,  'Cliente ABC', 'São Paulo'    , 'São Paulo'         , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 10, 1, 'Matriz', 'Cancelado', 0);
INSERT INTO tbvendas VALUES (102, '20160202', 10,  'Cliente ABC', 'São Paulo'    , 'São Paulo'         , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 10, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (103, '20170202', 10,  'Cliente ABC', 'São Paulo'    , 'São Paulo'         , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 10, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (104, '20180202', 10,  'Cliente ABC', 'São Paulo'    , 'São Paulo'         , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 10, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (105, '20190202', 10,  'Cliente ABC', 'São Paulo'    , 'São Paulo'         , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 10, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (106, '20200202', 10,  'Cliente ABC', 'São Paulo'    , 'São Paulo'         , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 10, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (107, '20210202', 10,  'Cliente ABC', 'São Paulo'    , 'São Paulo'         , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 10, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (108, '20210701', 10,  'Cliente ABC', 'São Paulo'    , 'São Paulo'         , 'Brasil', 2, 'Produto C', 'A',   15250, 'KG', 7.00, 10, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (110, '20150202', 9,  'Cliente BCA', 'Rio de Janeiro', 'Rio de Janeiro'    , 'Brasil', 2, 'Produto C', 'A',   25250, 'KG', 7.00, 8, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (112, '20160202', 9,  'Cliente BCA', 'Rio de Janeiro', 'Rio de Janeiro'    , 'Brasil', 2, 'Produto C', 'A',   25250, 'KG', 7.00, 8, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (114, '20170202', 9,  'Cliente BCA', 'Rio de Janeiro', 'Rio de Janeiro'    , 'Brasil', 2, 'Produto C', 'A',   25250, 'KG', 7.00, 8, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (115, '20180202', 9,  'Cliente BCA', 'Rio de Janeiro', 'Rio de Janeiro'    , 'Brasil', 2, 'Produto C', 'A',   25250, 'KG', 7.00, 8, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (116, '20180302', 9,  'Cliente BCA', 'Rio de Janeiro', 'Rio de Janeiro'    , 'Brasil', 2, 'Produto C', 'A',   25250, 'KG', 7.00, 8, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (117, '20200202', 9,  'Cliente BCA', 'Rio de Janeiro', 'Rio de Janeiro'    , 'Brasil', 2, 'Produto C', 'A',   25250, 'KG', 7.00, 8, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (118, '20210515', 9,  'Cliente BCA', 'Rio de Janeiro', 'Rio de Janeiro'    , 'Brasil', 2, 'Produto C', 'A',   25250, 'KG', 7.00, 8, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (120, '20100213', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (121, '20110203', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (122, '20120203', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (123, '20130103', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (124, '20140203', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (125, '20150203', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 6, 1, 'Matriz', 'Cancelado', 0);
INSERT INTO tbvendas VALUES (126, '20160203', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (127, '20170603', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (128, '20180803', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (129, '20190503', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (130, '20200103', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  34500, 'KG', 0.34, 6, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (131, '20210804', 11, 'Cliente CCC', 'Salvador'      , 'Bahia'             , 'Brasil', 1, 'Produto A', 'A',  44500, 'KG', 0.34, 6, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (140, '20110906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'           , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (141, '20120906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (142, '20130906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (143, '20140906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (144, '20150906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  4500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (145, '20160906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  14500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (146, '20180906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  34500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (147, '20190906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  44500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (148, '20200906', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  44500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (149, '20210515', 13, 'Cliente MAC', 'Maceió'        , 'Alagoas'            , 'Brasil', 1, 'Produto A', 'A',  44500, 'KG', 0.34, 7, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (150, '20100301', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B',   730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (151, '20110305', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B',  1730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (152, '20120501', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B',  2730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (153, '20130403', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B',  3730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (154, '20140701', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B',  4730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (155, '20150602', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B',  5730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (156, '20160729', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B',  7730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (157, '20170323', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B', 19730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (158, '20190217', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B', 19730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (159, '20200214', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B', 19730, 'KG', 2.00, 5, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (160, '20210702', 14, 'Cliente MGS', 'Campo Grande'  , 'Mato Grosso do Sul' , 'Brasil', 3, 'Produto E', 'B', 19730, 'KG', 2.00, 5, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (170, '20100521', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  10030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (171, '20121221', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  10030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (172, '20140201', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  10030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (173, '20160705', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  10030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (174, '20170811', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  10030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (175, '20180625', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  10030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (176, '20190528', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  20030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (177, '20200330', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  20030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (178, '20210401', 18, 'Cliente GRM', 'Gramado'       , 'Rio Grande do Sul'  , 'Brasil', 5, 'Produto CH', 'A',  20030, 'KG', 9.00, 2, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (180, '20100315', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',    750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (181, '20120430', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   1750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (182, '20131225', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   2750, 'KG', 0.50, 1, 1, 'Matriz', 'Cancelado', 0);
INSERT INTO tbvendas VALUES (183, '20141121', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   3750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (184, '20150316', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   4750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (185, '20170311', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   6750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (186, '20180605', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   5750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (187, '20190504', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   18750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (188, '20200702', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   19750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (189, '20210801', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   20750, 'KG', 0.50, 1, 1, 'Matriz', 'Concluído', 0);
INSERT INTO tbvendas VALUES (190, '20210803', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   20750, 'KG', 0.50, 1, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (191, '20210805', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   20750, 'KG', 0.50, 1, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (192, '20210807', 16, 'Cliente PIR', 'Piripiri'      , 'Piauí'              , 'Brasil', 4, 'Produto SL', 'A',   30750, 'KG', 0.50, 1, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (200, '20210315', 17, 'Cliente MTG', 'Palmas'        , 'Tocantins'          , 'Brasil', 6, 'Produto TN  ', 'C',   1750, 'KG', 0.25, 5, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (201, '20210405', 17, 'Cliente MTG', 'Palmas'        , 'Tocantins'          , 'Brasil', 6, 'Produto TN  ', 'C',  11750, 'KG', 0.25, 5, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (202, '20210515', 17, 'Cliente MTG', 'Palmas'        , 'Tocantins'          , 'Brasil', 6, 'Produto TN  ', 'C',  21750, 'KG', 0.25, 5, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (203, '20210516', 17, 'Cliente MTG', 'Palmas'        , 'Tocantins'          , 'Brasil', 6, 'Produto TN  ', 'C',  31750, 'KG', 0.25, 5, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (204, '20210701', 17, 'Cliente MTG', 'Palmas'        , 'Tocantins'          , 'Brasil', 6, 'Produto TN  ', 'C',  41750, 'KG', 0.25, 5, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (205, '20210715', 17, 'Cliente MTG', 'Palmas'        , 'Tocantins'          , 'Brasil', 6, 'Produto TN  ', 'C',  51750, 'KG', 0.25, 5, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (206, '20210801', 17, 'Cliente MTG', 'Palmas'        , 'Tocantins'          , 'Brasil', 6, 'Produto TN  ', 'C',  71750, 'KG', 0.25, 5, 2, 'Ecommerce', 'Concluído', 0);
INSERT INTO tbvendas VALUES (207, '20210807', 17, 'Cliente MTG', 'Palmas'        , 'Tocantins'          , 'Brasil', 6, 'Produto TN  ', 'C',  91750, 'KG', 0.25, 5, 2, 'Ecommerce', 'Cancelado', 0);

-- Visualizando os dados
SELECT * FROM tbvendas;

-- Dependente
-- truncate table tbdependente
INSERT INTO tbdependente VALUES (1, 'Dependente 1', '20100202', 'Masc', 1, '11000040');
INSERT INTO tbdependente VALUES (2, 'Dependente 2', '20120405', 'Masc', 3, '33110360');
INSERT INTO tbdependente VALUES (3, 'Dependente 3', '20130304', 'Fem' , 3, '33110360');
INSERT INTO tbdependente VALUES (4, 'Dependente 4', '20100505', 'Fem' , 4, '42154413');
INSERT INTO tbdependente VALUES (5, 'Dependente 5', '20190706', 'Masc', 4, '42154413');
INSERT INTO tbdependente VALUES (6, 'Dependente 6', '20180302', 'Fem' , 9, '53085000');

-- Visualizando os dados
SELECT * FROM tbdependente;