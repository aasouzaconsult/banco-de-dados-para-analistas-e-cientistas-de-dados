/*
Bibliografia
    - Sistemas de Banco de Dados
        - R. Elmasri e S.B. Navathe
        - 7º Edição - Editora Pearson, 2019
    - Manual de Referência
        - MySQL (https://dev.mysql.com/doc/)
*/

-- #############################################################################################
-- Linguagem SQL - DDL (Data Defition Language - link: https://techlib.wiki/definition/ddl.html)
-- #############################################################################################
/*  DDL - Data Definition Language - Linguagem de Definição de Dados.
    - São os comandos que interagem com os objetos do banco.
    - São comandos DDL : CREATE, ALTER e DROP */
-- -----------------
-- Banco de dados --
-- -----------------
-- create database (link: https://dev.mysql.com/doc/refman/8.0/en/create-database.html)
create database db_aula;
use db_aula;

-- alter database
-- alter database db_aula read only = 0; -- somente leitura (1 ativado - 0 desativado)

-- drop database
-- drop database db_aula;

-- ----------
-- Tabelas --
-- ----------
-- Alguns tipos de dados suportados pelo SQL 92
    -- char(n) - string de caracteres de tamanho fixo n
    -- varchar(n) - string de caracteres de tamanho variável (máximo n)
    -- integer
    -- smallint
    -- decimal(p,d) - numérico com p dígitos, dos p dígitos, d dígitos representam casas decimais após a vírgula
    -- date - data de calendário
    -- *atenção a questão da tipagem dos dados
    -- *tipos do mysql (https://dev.mysql.com/doc/refman/8.0/en/data-types.html)

-- create table (link: https://dev.mysql.com/doc/refman/8.0/en/create-table.html)
create table tbproduto (
    cdPro smallint PRIMARY KEY
  , nmPro char(30) 
  , vrUni decimal(18,2));

-- alter table (altera propriedades da tabela)
alter table tbproduto modify cdPro int;

-- drop table
-- Remove as tuplas da tabela e sua definição do catálogo
-- primeiro deve ser deletado todas as tabelas que referenciam a tabela a ser deletada ou deletar as restrições do tipo foreign key
-- 
drop table tbproduto;

-- ------------------------------------------------    
-- Criando tabelas com restrições de integridade --
-- ------------------------------------------------
-- 1. Restrição de domínio
-- -----------------------
-- O valor de cada atributo A tem que ser um valor atômico de dom(A)
alter table tbproduto ADD CONSTRAINT codigoMenor40 CHECK (cdPro < 40);

-- Exemplo:
-- Inserindo dados
insert into tbproduto values (1, 'Produto 1', 19.90);
insert into tbproduto values (2, 'Produto 2', 19.90);
insert into tbproduto values (3, 'Produto 3', 29.90);
insert into tbproduto values (40, 'Produto 4', 39.90);

-- Consultando dados
select * from tbproduto;

-- 2. Restrição de entidade
-- ------------------------
-- Tuplas de uma relação têm que serem distintas entre si
    -- Primary key
    -- Unique key
-- Exemplo:
-- Inserindo um novo Produto
insert into tbproduto values (3, 'Produto 5', 49.90);
                
-- Criação uma nova Tabela: tabela de cliente
create table tbcliente (
    cdCli  int primary key NOT NULL AUTO_INCREMENT
  , dsCPF  bigint unique
  , nmCli  char(50)
  , estado varchar(15));

-- Consultando tbCliente
select * from tbcliente;

-- Inserindo dados
insert into tbcliente (dsCPF, nmCli, estado) values (11111111111, 'Cliente 1', 'Ceará');
insert into tbcliente (dsCPF, nmCli, estado) values (11111111112, 'Cliente 2', 'Ceará');
insert into tbcliente (dsCPF, nmCli, estado) values (11111111113, 'Cliente 3', 'São Paulo');
insert into tbcliente (dsCPF, nmCli, estado) values (11111111114, 'Cliente 4', 'Rio de Janeiro');
insert into tbcliente (dsCPF, nmCli, estado) values (11111111112, 'Cliente 5', 'Bahia');

-- 3. Restrição de integridade referencial
-- ---------------------------------------
-- Um conjunto de atributos FK de uma tabela R é chave estrangeira (foreign key) se os atributos em FK têm o mesmo domínio que a chave primária PK
-- de uma tabela S, e um valor de FK em uma tupla t1 de R ou ocorre como valor de PK para uma tupla t2 em S ou é nulo :(

-- Exemplo:
-- Criação da Tabela de Venda
-- --------------------------------------------------------------------------------------------------------------------------------
-- Não se pode permitir a remoção de Produtos e Cliente para os quais ainda existam Vendas para aquele produto ou cliente (on delete no action)* default
-- --------------------------------------------------------------------------------------------------------------------------------
create table tbvendas (
       cdVen        int primary key
     , dtVen        datetime
     , cdCli        int
     , cdPro        int
     , qtPro        int
     , constraint fk_cli FOREIGN KEY (cdCli) REFERENCES TbCliente (CdCli) ON DELETE NO ACTION
     , constraint fk_pro FOREIGN KEY (cdPro) REFERENCES TbProduto (CdPro) ON DELETE NO ACTION
                                                                       -- ON DELETE CASCADE (Remover o Produto e suas respectivas vendas, caso existam - use com muita moderação)
                                                                       -- ON UPDATE CASCADE (Atualizar o Produto e suas respectivas vendas, caso existam) útil quando se quer mudar todo o histórico de algo
);

-- inserindo dados           cdVen, dtVen, cdCli   , cdPro, qtPro
insert into tbvendas values (1    , now(),    3    ,    1 , 10);
insert into tbvendas values (2    , now(),    3    ,    2 , 20);
insert into tbvendas values (3    , now(),    1    ,    3 , 30);
insert into tbvendas values (3    , now(),    2    , null , 30);
insert into tbvendas values (4    , now(),    2    , null , null);
insert into tbvendas values (5    , now(),    2    ,   99 , null);
insert into tbvendas values (6    , '2013-02-02 00:00:00',    2    ,   2 , 25);
insert into tbvendas values (7    , '2019-03-18 08:00:00',    3    ,   2 , 32);
insert into tbvendas values (8    , '2021-03-18 08:00:00',    3    ,   2 , 32);
insert into tbvendas values (9    , now(),    3    ,    2 , 20);
insert into tbvendas values (10   , '2013-05-12 01:00:00',    2    ,   2 , 25);

-- consultando
select * from tbvendas;

-- Testes (drop)
drop table tbproduto; -- deixará apagar a tabela?
drop table tbcliente; -- deixará apagar a tabela?
drop table tbvendas;  -- deixará apagar a tabela?
             
-- consultando antes/depois de deletar
select * from tbproduto;
select * from tbvendas;
                
-- rodando o delete
delete from tbproduto where cdPro = 1;

-- ++++++++++++++++++++
-- Exercício para Fixar
-- ++++++++++++++++++++
-- dropar a base e fazer novamente até a linha 126
-- Criaremos mais duas entidades (tabelas) que se relacionam, a de Vendedores e a de Dependentes, favor criar conforme descrito abaixo e fazer a referência entre elas
-- Criar uma tabela de Vendedor (cdVendedor (pk), nomeVendedor, dtNascVendedor, sexoVendedor, estadoVendedor)
-- Criar uma tabela de Dependente (cdDependente (pk), nomeDependente, dtNascDependente, sexoDependente, cdVendedor(fk))
-- Criar o relacionamento entre elas
create table tbVendedor (
       cdVendedor     int primary key
     , nomeVendedor   varchar(50)
     , dtNascVendedor date
     , sexoVendedor   char(1)
     , estadoVendedor varchar(25));
-- drop table tbVendedor;

create table tbDependente (
       cdDependente     int primary key
     , nomeDependente   varchar(50)
     , dtNascDependente date
     , sexoDependente   char(1)
     , CdVendedor       int
     , inepEscola       varchar(10));
-- drop table tbDependente;

-- criando o relacionamento
-- ------------------------
alter table tbDependente
  add constraint fk_dep foreign key (cdVendedor) references tbVendedor (cdVendedor);

-- consultando 
select * from tbvendedor;
select * from tbdependente;

-- Populando as tabelas
insert into tbVendedor values (1, 'Vendedor 1', '19810412', 'M', 'Ceará');
insert into tbVendedor values (2, 'Vendedor 2', '19710515', 'F', 'Ceará');
insert into tbVendedor values (3, 'Vendedor 3', '19881230', 'F', 'Bahia');

insert into tbDependente values (1, 'Dependente A' , '20200105', 'M', 1, '11001887');
insert into tbDependente values (2, 'Dependente B' , '20210425', 'M', 3, '11001364');
insert into tbDependente values (3, 'Dependente AA', '20180816', 'F', 1, '11001887');
insert into tbDependente values (4, 'Dependente C' , '20150312', 'F', 2, '11001666');
-- insert into tbDependente values (5, 'Dependente C' , '20150312', 'F', 4, '11001666');

-- ----------------------------
-- Definição de Esquemas SQL --
-- ----------------------------
-- Alterando tabelas (https://dev.mysql.com/doc/refman/8.0/en/alter-table.html)
select * from tbvendas;

-- adicionando a coluna de código de vendedor na tabela de vendas (para saber quem foi o vendedor daquela venda)
alter table tbvendas
   add cdVendedor int;

-- criando o relacionamento entre a tabela vendas e a tabela de vendedores
alter table tbvendas
   add constraint fk_vendedor FOREIGN KEY (cdVendedor) REFERENCES tbvendedor (cdVendedor) ON DELETE NO ACTION;

-- -----------------------
-- Modelagem Relacional --
-- -----------------------
-- Desenho da arquitetura criada 
-- utilizar Engenharia reversa* (Database > Reverse Engineer...)

-- ################################################
-- Linguagem SQL - DML (Data Manipulation Language)
-- ################################################
-- (https://social.technet.microsoft.com/wiki/contents/articles/34477.sql-server-commands-dml-ddl-dcl-tcl.aspx)

/*  DML - Data Manipulation Language - Linguagem de Manipulação de Dados.
    - São os comandos que interagem com os dados dentro das tabelas.
    - São comandos DML : INSERT, DELETE e UPDATE */

-- ---------
-- INSERT --
-- ---------
-- Inserindo tuplas em uma tabela (https://dev.mysql.com/doc/refman/8.0/en/insert.html)
insert into tbproduto values (5 , 'Produto 5' , 29.90);
insert into tbproduto values (6 , 'Produto 6' , 19.90);
insert into tbproduto values (7 , 'Produto 7' , 59.90);
insert into tbproduto values (8 , 'Produto 8 ', null);
insert into tbproduto values (9 , ' Produto 9', null);
insert into tbproduto values (10, ' Prodotu 10', 1.99);

-- Consultando
select * from tbproduto;

-- Inserindo tuplas em uma tabela com base em um select
-- Criando uma tabela auxiliar de produtos
create table tbproduto_auxiliar as
select * from tbproduto;

-- consultando
select * from tbproduto_auxiliar;

-- inserindo mais dados
insert into tbproduto_auxiliar
 select cdPro + 100
      , concat(nmPro, ' - teste') -- concatenar texto
      , vrUni * 3
   from tbproduto;

-- consultando
select * from tbproduto_auxiliar;

-- ---------
-- UPDATE --
-- ---------
-- Atualizando tuplas em uma tabela (https://dev.mysql.com/doc/refman/8.0/en/update.html)
-- Atualizar o valor unitário do produto 8 para 49.90
update tbproduto
   set vrUni = 49.90
 where cdPro = 9; -- Muito importante

-- Consultando
select * from tbproduto;

-- ---------
-- DELETE --
-- ---------
-- Deletando tuplas em uma entidade (https://dev.mysql.com/doc/refman/8.0/en/delete.html)
-- Deletar o produto de código 
delete 
  from tbproduto
 where cdPro = 10; -- Muito importante

-- consultando
select * from tbproduto;

insert into tbproduto values (10, 'Produto teste', 59.90);

-- --------------------
-- TRUNCATE (SIMULANDO)
-- --------------------
-- https://dev.mysql.com/doc/refman/8.0/en/example-auto-increment.html
CREATE TABLE animals (
     id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     PRIMARY KEY (id)
);

INSERT INTO animals (name) VALUES
    ('dog'),('cat'),('penguin'),
    ('lax'),('whale'),('ostrich');

SELECT * FROM animals;

-- Realizando um delete de todos os registros
-- MySQL não deixa delete sem where (GENIAL!)
delete from animals 
where id < 1000;

-- Inserindo após um delete (a numeração da chave primária continua)
INSERT INTO animals (name) VALUES
    ('teste');

-- Realizando um truncate na tabela
-- --------------------------------
-- https://dev.mysql.com/doc/refman/8.0/en/truncate-table.html
truncate animals;

-- Inserindo após um delete (a numeração da chave primária reinicia)
INSERT INTO animals (name) VALUES
    ('teste');

# Diferença entre delete e truncate
# - quando tem uma coluna primary key, o trucante zera a numeração da chave 
# o delete não, continua a numeração

-- #########################################
-- Linguagem SQL - DQL (Data Query Language)
-- #########################################
/*  DQL - Data Query Language - Linguagem de Consulta de dados.
    - São os comandos de consulta.
    - São comandos DQL : SELECT (é o comando de consulta)
    - *Aqui cabe um parenteses. Em alguns livros o SELECT fica na DML em outros tem esse grupo próprio (DQL). */

-- ---------
-- SELECT --
-- ---------
-- Consultando tuplas em uma tabela (https://dev.mysql.com/doc/refman/8.0/en/select.html)
    -- Consulta simples em SQL
        -- Três cláusulas: SELECT, FROM, WHERE
            -- SELECT: define os valores que constituem cada linha do resultado
            -- FROM: define as tabelas das quais o resultado é produzido
            -- WHERE: define a condição de seleção que será satisfeita para as tuplas que formam o resultado

-- Exemplo: recuperar nome e data nascimento dos Vendedores do sexo feminino
select * from tbvendedor limit 100;

select nomeVendedor   as nome
     , dtNascVendedor as "data nascimento"
  from tbvendedor
 where sexoVendedor = 'F';

-- **************************************
-- Construção de Consultas e Subconsultas
-- **************************************
-- ------------------------------
-- * (retorna todas os atributos)
-- ------------------------------
-- sempre procure ser o mais específico possível, evite o * (limitação das colunas)
select * from tbproduto;

-- ----------------------------------------------
-- distinct (retorna apenas tuplas\linhas não repetidas)
-- ----------------------------------------------
-- Estados da tabela de cliente
select Estado from tbcliente;
select distinct Estado from tbcliente;

-- ---------------------------------------------
-- as (alias, dar nomes a atributos/campo e entidades/tabelas)
-- ---------------------------------------------
select prd.nmPro as Produto
     , prd.vrUni as Valor
  from tbproduto as prd;

-- ------------------------------------------------
-- limit ou top (retornar os primeiros n registros)
-- ------------------------------------------------
select prd.nmPro as Produto
     , prd.vrUni as "Valor Unitário"
  from tbProduto as prd
 limit 2; -- retorna os 2 primeiros registros

-- -----------------
-- condições (where)
-- -----------------
-- mostrar os produtos com valor maior que 40
select prd.nmPro as Produto
     , prd.vrUni as Valor
  from tbproduto as prd
 where prd.vrUni > 40;
 
-- -----------------------------------
-- Converter dados (cast ou convert)
-- -----------------------------------
-- Converter o CPF do cliente para texto (apenas na consulta)
select dsCPF from tbcliente;

select dsCPF
     , cast(dsCPF as char) as CPF
  from tbcliente;
 
 -- ---------------------------------------------
-- isnull (verifica se um atributo/valor é nulo)
-- ---------------------------------------------
select * 
  from tbvendas;

-- Listar todas as vendas que o Código do Produto é nulo:
select * 
  from tbvendas 
 where cdPro is null;

-- Listar todas as vendas que o Código do Produto não é nulo:
select * 
  from tbvendas 
 where cdPro is not null;

-- ------------------------------------------------
--  Between (valor que esteja entre outros valores)
-- ------------------------------------------------
select * from tbproduto;

-- retornar o nome dos produtos com código entre 5 e 8
select nmPro      as nome
  from tbproduto
 where cdPro between 5 and 8;

-- --------------------------------------------------------------------------------
-- Order By - Ordena o resultado de uma consulta, de acordo com uma ou mais colunas
-- --------------------------------------------------------------------------------
select * from tbproduto;

-- Ordernar a tbproduto por valor unitário
select *
  from tbproduto
 order by vrUni;

select *
  from tbproduto
 order by vrUni desc; -- decrescente

-- ++++++++++++++++++++
-- Exercício para Fixar
-- ++++++++++++++++++++
-- mostrar as vendas com quantidade menor que 30
select * from tbvendas;
-- ???

-- ----------------------------------------------------------------- 
-- Vamos montar 2 tabelas para demonstração dos próximos comandos --
-- -----------------------------------------------------------------
create table tbfornecedores_locais (
     cdFor int primary key
   , nmFor varchar(50)
   , dspro varchar(50)
);

insert into tbfornecedores_locais values (1, 'Fornecedor ABC', 'Produto A');
insert into tbfornecedores_locais values (2, 'Fornecedor ACB', 'Produto B');
insert into tbfornecedores_locais values (3, 'Fornecedor BAC', 'Produto B');
insert into tbfornecedores_locais values (4, 'Fornecedor BCA', 'Produto C');
insert into tbfornecedores_locais values (5, 'Fornecedor BBA', 'Produto A');

create table tbfornecedores_nacionais (
     cdFor int primary key
   , nmFor varchar(50)
   , dspro varchar(50) 
);

insert into tbfornecedores_nacionais values (1, 'Fornecedor ABC', 'Produto A');
insert into tbfornecedores_nacionais values (2, 'Fornecedor ABB', 'Produto B');
insert into tbfornecedores_nacionais values (3, 'Fornecedor BAA', 'Produto B');
insert into tbfornecedores_nacionais values (4, 'Fornecedor BCA', 'Produto C');
insert into tbfornecedores_nacionais values (5, 'Fornecedor BBA', 'Produto A');

-- consultando
select * from tbfornecedores_locais;
select * from tbfornecedores_nacionais;

-- ------------------------------------
-- Consultas com o operador de União --
-- ------------------------------------
-- UNION - União de duas relações (consultas) - Sem repetições
select * from tbfornecedores_locais
UNION
select * from tbfornecedores_nacionais order by cdFor;

-- UNION ALL - União de duas relações - Com repetições
select * from tbfornecedores_locais
UNION ALL
select * from tbfornecedores_nacionais order by cdFor;

-- -----------------------------------------------------
-- Consultas com o operador de interseção e diferença --
-- -----------------------------------------------------
-- INTERSECT - Interseção entre duas relações (consultas) - Sem repetições
-- INTERSECT ALL - Interseção entre duas relações - Com repetições
SELECT a.*
  FROM tbfornecedores_locais a
 INNER JOIN tbfornecedores_nacionais b
 USING (nmFor);
 
-- EXCEPT - Diferença entre duas relações (consultas) - Sem repetições
-- EXCEPT ALL - Diferença entre duas relações consultas) - Com repetições
SELECT t1.* 
  FROM      tbfornecedores_locais    AS t1
  LEFT JOIN tbfornecedores_nacionais AS t2 ON  t1.cdFor = t2.cdFor
                                           AND t1.nmFor = t2.nmFor
                                           AND t1.dsPro = t2.dsPro
 WHERE t2.cdFor IS NULL;
 
-- --------------
-- Agrupamento --
-- --------------
-- Quantidade de clientes por estado
select estado
     , count(*) as qtdclientes
 from tbcliente
group by estado;
 
-- ---------
-- Having --
-- ---------
-- Filtro de grupos
-- Quais os clientes que já compraram mais de 20 unidades de produtos
select * from tbvendas;

select cdcli
     , sum(qtPro)
  from tbvendas
 group by cdCli
having sum(qtPro) > 35; -- where não irá funcionar para agregação

-- *********************************
-- Funções de Manipulação de Strings
-- *********************************
-- -------------------------------------------------------------
-- operador "=" e like (Predicados com operações sobre strings)
-- -------------------------------------------------------------
select * from tbcliente;

-- Filtrar apenas Estado com o nome Ceará
select * 
  from tbcliente
 where estado = 'Ceará';

-- Filtrar estado que termina com a letra: o
select * 
  from tbcliente
 where Estado like '%o';

-- -------------------------------------
-- upper (deixa o atributo em maiúsculo)
-- -------------------------------------
select estado,
       upper(estado) 
  from tbcliente;

-- -------------------------------------
-- lower (deixa o atributo em minúsculo)
-- -------------------------------------
select lower(estado) from tbcliente;

-- -------------------------------------------
-- ltrim (remove espaço em branco a esquerda)
-- -------------------------------------------
select nmPro, 
       length(nmPro) 
  from tbproduto;

select ltrim(nmPro)
     , length(ltrim(nmPro)) 
  from tbproduto;

-- ------------------------------------------
-- rtrim (remove espaço em branco a direita)
-- ------------------------------------------
select nmPro, length(nmPro) from tbproduto;

select rtrim(nmPro), 
       length(rtrim(nmPro)) 
  from tbproduto;

-- ------------------------------
-- trim (remove espaço em branco)
-- ------------------------------
select nmPro, length(nmPro) from tbproduto;

select trim(nmPro), length(trim(nmPro)) from tbproduto;
    
-- ----------------------------------------------------
-- substring (retorna um trecho específico de um texto)
-- ----------------------------------------------------
select nmPro from tbproduto;

-- retornar os 5 primeiros caracteres (exemplo)
select nmPro
     , substring(nmPro, 1, 5) as nome_reduzido
     , substring(trim(nmPro), 1, 5) as nome_reduzido_semespaco
  from tbproduto;

-- ---------------------------------------
-- replace (substituir um texto por outro)
-- ---------------------------------------
-- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_replace
select nmPro from tbproduto;

select nmPro,
       replace(trim(nmPro), 'Produto', 'Produtos') as nome_plural 
  from tbproduto;

-- ---------------------------------------
-- reverse (inverte)
-- ---------------------------------------
select nmPro
     , reverse(nmPro) invertido
  from tbproduto;
  
-- ---------------------------------------
-- RIGHT e LEFT
-- ---------------------------------------
select nmPro
     , right(trim(nmPro), 2)
     , left(trim(nmPro), 4)
  from tbproduto;

-- --------------------------------------
-- lpad (ou o replicate de outros sgbds)
-- --------------------------------------
-- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_lpad
-- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_rpad

-- O código do produto deve ter 3 digitos (zeros a esquerda), exemplo: 1 seria 001 e assim por diante
select cdPro
     , lpad(cdPro, 3, 0) CodigoProduto
  from tbproduto;

-- ******************
-- Operações com Data 
-- ****************** 
select dtVen                              as Data
     , day(dtVen)                         as Dia
     , month(dtVen)                       as Mes
     , year(dtVen)                        as Ano
     , hour(dtVen)                        as Hora
     , minute(dtVen)                      as Minuto
     , date_format(dtVen, '%Y%m%d')       as AnoMesDia
     , date_format(dtVen, '%b %Y')        as Mes_Ano
     , dtVen - interval '3' hour          as "Data-3hs"
     , dtVen - interval '3' day           as "Data-3days"
     , localtimestamp()                   as hora_atual
     , localtimestamp - interval '3' hour as "DataAtual-3hs"
  from tbvendas;
  
-- -------------------------------------
-- DIFF
-- -------------------------------------
-- Diferença entre datas
-- https://www.w3schools.com/sql/func_mysql_datediff.asp

select DtVen as DataVenda
     , now() as Hoje
     , DATEDIFF(now(), dtVen) as diferenca_em_dias
  from tbvendas;

-- -------------------------------------
-- Date_add -- Adiciona dias
-- -------------------------------------
-- https://www.w3schools.com/sql/func_mysql_date_add.asp

-- adicionando 10 dias na data de vendas (previsão de entrega)
select DtVen as DataVenda
     , DATE_ADD(DtVen, INTERVAL 10 DAY) as previsao_entrega 
  from tbvendas;

-- ********************
-- Funções de agregação
-- ********************
-- Funções embutidas (built-in) aplicadas sobre uma coleção de valores (colunas) do banco de dados
    -- sum - Retorna o somatório dos valores de uma coleção
    -- avg - Retorna a média dos valores de uma coleção
    -- max - Retorna o maior valor de uma coleção de valores
    -- min - Retorna o menor valor de uma coleção
    -- count - Retorna o número de elementos de uma coleção
    -- Não podem ser utilizados na cláusula WHERE*

-- --------------------------------------------
-- Somatório da quantidade de produtos vendidos
-- --------------------------------------------
select * from tbvendas;

select sum(qtPro) as quantidade_venda
  from tbvendas;
-- ----------------------------------------
-- Média da quantidade de produtos vendidos
-- ----------------------------------------
select avg(qtPro) as media_quantidade_venda
  from tbvendas;
  
-- -------------------------------------
-- Maior quantidade de produtos vendidos
-- -------------------------------------
select max(qtPro) as maior_quantidade_venda
  from tbvendas;

-- -------------------------------------
-- Menor quantidade de produtos vendidos
-- -------------------------------------
select min(qtPro) as menor_quantidade_venda
  from tbvendas;

-- ------------------------------------------------------------
-- Contagem de produtos (quantos produtos temos na nossa base?)
-- ------------------------------------------------------------
select * from tbProduto;

select count(cdPro) as qtd_produtos
  from tbProduto;

-- ++++++++++++++++++++
-- Exercício para Fixar
-- ++++++++++++++++++++
-- Quantos clientes temos na nossa base que são do estado do Ceará?
select * from tbcliente;
-- ???

-- ************************************
-- Relacionamento entre tabelas (joins)
-- *************************************
-- Operação que permite buscar informações de duas ou mais tabelas que estão relacionadas.
-- https://blogdozouza.wordpress.com/2011/11/29/entendendo-os-tipos-de-joins/

-- -------------
-- Inner Join --
-- -------------
-- O Inner Join é o método de junção mais conhecido e retorna os registros que são comuns às duas tabelas.
select * from tbvendas;
select * from tbproduto;

select ven.CdVen as codigo
     , ven.DtVen as data
     , pro.nmPro as produto
     , ven.qtPro as qtdProduto
  from       tbvendas  ven
 inner join tbproduto pro on pro.cdPro = ven.cdPro;

-- -------------
-- Left Join --
-- -------------
-- O Left Join tem como resultado todos os registros que estão na tabela A (mesmo que não estejam na tabela B) 
-- e os registros da tabela B que são comuns à tabela A.
select * from tbvendas;
select * from tbproduto;

select *
  from      tbvendas ven
  left join tbproduto pro on pro.cdPro = ven.cdPro;

-- -------------
-- Right Join --
-- -------------
-- Usando o Right Join teremos como resultado todos os registros que estão na tabela B (mesmo que não estejam na tabela A) 
-- e os registros da tabela A que são comuns à tabela B.

select * from tbvendas;
select * from tbproduto;

select *
  from       tbvendas ven
  right join tbproduto pro on  pro.cdPro = ven.cdPro;
                        -- and pro.ano   = ven.ano (apenas demonstração)

-- -------------
-- Outer Join --
-- -------------
-- O Outer Join (também conhecido por Full Outer Join ou Full Join) tem como resultado todos os registros que estão na tabela A e todos os registros da tabela B.
-- No MySQL não tem nativamente

select * from tbvendas;
select * from tbproduto;

select *
  from            tbvendas ven
  left outer join tbproduto pro on pro.cdPro = ven.cdPro
union
select *
  from            tbvendas ven
 right outer join tbproduto pro on pro.cdPro = ven.cdPro;

-- ************
-- Subconsultas (não aconselhável, performance...)
-- ************
-- with ou CTE
-- https://dev.mysql.com/doc/refman/8.0/en/with.html

-- views materializadas
-- - muito utilizadas consultas que não necessita de informações constantemente atualizadas

select *
     , (select nmPro from tbproduto where cdpro = ven.cdPro) as produto
  from tbvendas                                              ven
  join (select cdPro, nmPro from tbproduto where cdPro >= 2) pro on pro.cdPro = ven.cdPro;

-- Usando CTE (dica para melhorar a performance)
with cte1 as (select cdPro, nmPro from tbproduto where cdPro >= 2),
     cte2 as (select * from tbvendas)
select *
  from cte2 t2 
  join cte1 t1 on t1.cdPro = t2.cdPro;

-- *****
-- Views
-- *****
-- Gera uma visualização com base em uma consulta 
-- Muita vezes utilizada para restringir o acesso a determinados atributos
select * from tbvendas;
select * from tbcliente;
select * from tbproduto;

-- Um determinado usuário precisa da data de venda, nome do cliente e o nome do produto vendido
create or replace view vwvendas_resumida_qtd as
select ven.dtVen as Data
     , cli.nmCli as Cliente
     , pro.nmPro as Produto
     , ven.qtPro as Qtd
  from tbvendas  ven
  join tbcliente cli on cli.cdCli = ven.cdCli
  join tbproduto pro on pro.cdPro = ven.cdPro;
  
create or replace view vwvendas_resumida as
select ven.dtVen as Data
     , cli.nmCli as Cliente
     , pro.nmPro as Produto
  from tbvendas  ven
  join tbcliente cli on cli.cdCli = ven.cdCli
  join tbproduto pro on pro.cdPro = ven.cdPro;

-- consultando
select * from vwvendas_resumida_qtd;
select * from vwvendas_resumida;

-- *****************************
-- Comandos de Controle de Fluxo
-- *****************************
-- Brindes para dependentes (consulta que mostre a relação de vendedores e seus dependentes, e se o dependente for menino ganhará uma bola A e menina uma bola B.

-- IF
-- https://dev.mysql.com/doc/refman/8.0/en/flow-control-functions.html#function_if
select vnd.nomeVendedor
     , dep.nomeDependente
     , dep.sexoDependente
     , if (dep.sexoDependente = 'F', 'bola B', 'bola A') as Brinde
  from tbdependente dep
  join tbvendedor   vnd on vnd.cdvendedor = dep.cdvendedor;

-- CASE
-- Faixa de valores (ordenação)
select vnd.nomeVendedor
     , dep.nomeDependente
     , dep.sexoDependente
     , case when dep.sexoDependente = 'F' then 'bola B'
            when dep.sexoDependente = 'M' then 'bola A'
       else 'bola C' end   as Brinde
  from tbdependente dep
  join tbvendedor   vnd on vnd.cdvendedor = dep.cdvendedor;

-- IFNULL
-- Se o código do vendedor estiver nulo, colocar o vendedor 1

select CdVen
     , cdVendedor
     , IFNULL(cdVendedor, 1) as codigoVendedor
 from tbvendas;

-- **********************************************
-- Relacionamento entre bancos de dados distintos
-- **********************************************
-- Enriquecimento de dados
select * from censo2020.escolas limit 10;

select * from db_aula.tbdependente dep;

select dep.*
     , esc.NO_ENTIDADE as nomeescola
  from db_aula.tbdependente dep
  join censo2020.escolas    esc on esc.CO_ENTIDADE = dep.inepescola;
  
-- **********************************************
-- Window Functions
-- **********************************************
-- https://dev.mysql.com/doc/refman/8.0/en/window-functions-usage.html
-- Quantidade de produto total por cliente - detalhar por ano - quero saber tb a quantidade total de vendas (relatório detalhado)
SELECT cdcli                                            AS Codigocliente,
       year(dtven)                                      AS Ano, 
       cdpro                                            AS Codigoproduto,
       qtpro                                            AS Quantidade,
       SUM(qtpro) OVER(PARTITION BY cdcli)              AS Quantidade_por_cliente,
       SUM(qtpro) OVER(PARTITION BY cdcli, year(dtven)) AS Quantidade_por_cliente_ano,
       SUM(qtpro) OVER()                                AS Quantidade_total
  FROM db_aula.tbvendas
 ORDER BY cdcli, year(dtven), cdpro;

SELECT * FROM db_aula.tbvendas;

-- #############
-- Boas práticas
-- #############
-- Utizem comentários (https://dev.mysql.com/doc/refman/8.0/en/comments.html)
-- Indentação
-- Escrita limpa
-- Padronização
-- Evite o * no select


-- ########################
-- Extra - muitos registros 
-- ########################
-- https://generatedata.com/generator
use db_aula;

DROP TABLE IF EXISTS `myTable`;

CREATE TABLE `myTable` (
  `name` varchar(255) default NULL,
  `phone` varchar(500) default NULL,
  `email` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `postalZip` varchar(100) default NULL,
  `region` varchar(500) default NULL
);

INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Ivory Maldonado","(727) 557-7850","rhoncus.nullam@outlook.edu","Ap #754-5971 Habitant St.","811297","Bắc Kạn"),
  ("Darrel Larsen","1-314-225-7546","tristique@protonmail.org","Ap #635-6626 Vel Av.","566249","Mizoram"),
  ("Orson Pierce","(326) 731-1412","nunc.sed.libero@aol.com","Ap #384-1485 Libero St.","60088","Trà Vinh"),
  ("Russell Reese","(376) 426-8854","quis@yahoo.org","1135 Nunc, Rd.","81764","North Gyeongsang"),
  ("Carson Singleton","(447) 702-5785","sed.turpis.nec@yahoo.ca","Ap #312-5148 Semper, Avenue","184783","Nordrhein-Westphalen"),
  ("Francis Glenn","(479) 434-5711","vehicula.et@protonmail.org","568-2473 Tincidunt Street","60423-21544","North Region"),
  ("Raymond Hendrix","(781) 962-1142","porttitor@hotmail.org","2466 Purus. Avenue","2849","Paraíba"),
  ("Malachi Benton","(615) 791-2076","eu@outlook.net","Ap #359-7679 Nunc St.","98000","Cajamarca"),
  ("Jelani Wolfe","(684) 518-1866","vulputate@outlook.edu","Ap #692-3442 Lacinia Rd.","53128","Principado de Asturias"),
  ("Keaton Stephenson","(666) 563-6215","vel.venenatis@outlook.couk","791-2239 Amet, Street","235551","Wielkopolskie");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Giselle Oneal","(878) 268-6988","a.neque.nullam@outlook.ca","Ap #672-3349 Orci, Street","5337","West Region"),
  ("Maite Hampton","1-773-653-9358","imperdiet.dictum@google.net","866-6949 Fringilla St.","31682","İzmir"),
  ("Rhona Barton","(275) 337-1425","tempor.est@icloud.edu","P.O. Box 589, 7939 Integer St.","H3R 7V1","North Jeolla"),
  ("Nehru Bailey","(836) 348-6137","eu.dolor.egestas@outlook.ca","P.O. Box 137, 749 Ornare, Road","196824","Azad Kashmir"),
  ("Jamalia Underwood","1-267-164-4253","dolor.quisque@outlook.couk","7674 Scelerisque St.","5931 HR","Kemerovo Oblast"),
  ("Orla Wilson","(352) 444-9035","vulputate.risus@google.net","P.O. Box 945, 9239 Pulvinar Ave","88511","Belgorod Oblast"),
  ("Gregory Whitehead","(767) 478-1718","adipiscing@protonmail.edu","Ap #827-8468 Laoreet Av.","47-533","Bayern"),
  ("Kato Oliver","1-636-663-5875","tortor.nibh.sit@hotmail.org","Ap #838-1550 Ipsum Street","92799-247","Bangka Belitung Islands"),
  ("Quinlan Gates","1-513-926-7493","purus.gravida.sagittis@outlook.net","P.O. Box 905, 3372 Risus. Rd.","536767","Bicol Region"),
  ("Ray Vasquez","1-741-855-7748","lacus.quisque@icloud.couk","Ap #410-4188 Fringilla St.","24244-71226","Saskatchewan");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Iona Ross","1-555-406-2746","ornare@protonmail.net","886-7310 Luctus Road","2421 FG","East Nusa Tenggara"),
  ("Tyrone Church","1-539-168-8775","velit.quisque@protonmail.edu","P.O. Box 606, 2788 In Rd.","41552","Nuevo León"),
  ("Malcolm Gross","1-732-581-8277","sit@protonmail.couk","P.O. Box 763, 5401 Ipsum. Rd.","28167","Kharkiv oblast"),
  ("Sawyer Haney","1-634-525-2528","fermentum.fermentum.arcu@outlook.com","Ap #927-8159 Tortor. Ave","85-85","North Island"),
  ("Maxine Rhodes","1-604-743-5868","tellus.nunc@hotmail.edu","P.O. Box 169, 7981 Amet, Av.","8137","Khánh Hòa"),
  ("Tanisha Parrish","1-845-874-6623","faucibus.morbi.vehicula@hotmail.edu","P.O. Box 838, 1816 Quam Rd.","16568","Connecticut"),
  ("Lyle Sheppard","(534) 328-2865","ultrices.posuere.cubilia@google.net","8446 Quam. St.","844632","Gaziantep"),
  ("Iona Black","1-487-792-3865","odio.auctor@google.org","Ap #136-1533 Eu, St.","3657","Lakshadweep"),
  ("Angelica Avila","(702) 264-2784","lacus@protonmail.couk","315-9655 Nisl. Street","411879","East Region"),
  ("Rogan Mcbride","1-461-435-3618","duis.elementum.dui@yahoo.ca","Ap #771-5307 Dui, Ave","4832","Lazio");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Lance Whitfield","(371) 230-3714","phasellus@yahoo.edu","P.O. Box 930, 6777 Hendrerit St.","442416","Karnataka"),
  ("Imogene Gutierrez","1-970-513-4976","nisi.dictum@icloud.org","471-2411 Sed Av.","9263","Magallanes y Antártica Chilena"),
  ("Clare Waters","(380) 488-1324","morbi.neque@hotmail.org","5831 Malesuada Street","A3J 9E1","Sicilia"),
  ("Avram Langley","1-608-488-3330","tincidunt.donec@hotmail.com","3767 Placerat, Rd.","1373","Lorraine"),
  ("Priscilla Copeland","1-352-631-5873","penatibus.et@outlook.net","Ap #902-7392 Pede. Ave","45143","Ancash"),
  ("Linda Joseph","(770) 846-2061","arcu@icloud.com","358-2649 Sed Ave","669332","Papua"),
  ("Shea Johns","1-336-802-2258","posuere.at.velit@yahoo.ca","121-9325 Est, Av.","82479","Zuid Holland"),
  ("Sade Strickland","(367) 170-1613","nulla.vulputate@outlook.ca","968-7403 Vestibulum St.","593365","Valparaíso"),
  ("Megan Wheeler","1-843-611-2471","dis.parturient@outlook.ca","691-7907 Donec Ave","91908","Leinster"),
  ("Micah Whitfield","(128) 327-8948","orci@aol.com","P.O. Box 252, 7336 Duis St.","31249","Flevoland");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Ava Ferguson","(963) 672-6321","quis@protonmail.com","Ap #680-2481 Nulla Av.","7727","Berlin"),
  ("Hanae Shelton","1-530-861-9222","cum.sociis.natoque@outlook.com","641-2829 Mattis St.","21258-738","Davao Region"),
  ("Berk Lowery","1-242-561-5251","et.tristique.pellentesque@google.couk","Ap #494-1802 Adipiscing Street","973701","Prince Edward Island"),
  ("Thaddeus Austin","1-663-650-4185","nunc.risus@yahoo.couk","973-7525 Nec Road","9606","Zaporizhzhia oblast"),
  ("Vincent Fox","(212) 681-9626","elementum.at.egestas@outlook.edu","671-2453 Vulputate, St.","78241","Limburg"),
  ("Zeus Hardin","1-785-153-4855","sapien.nunc@yahoo.ca","Ap #998-7719 Nullam Avenue","826465","Basse-Normandie"),
  ("Jin Gilmore","(871) 826-9733","ullamcorper.velit@icloud.net","449-4164 Fringilla St.","36527","Đồng Tháp"),
  ("Clarke Tran","1-236-686-3663","vivamus.nibh@icloud.edu","P.O. Box 993, 6073 Pellentesque Rd.","618868","Calabarzon"),
  ("Hakeem Patton","(437) 168-2135","vel@protonmail.org","Ap #899-6397 Justo Rd.","27198","New Brunswick"),
  ("Irene Haynes","1-636-351-8391","nunc.commodo@hotmail.com","Ap #742-9639 Nunc Ave","4252","Sindh");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Avye Bennett","(701) 395-4385","odio.tristique@protonmail.couk","P.O. Box 146, 8370 Adipiscing, St.","5744","Hòa Bình"),
  ("Sylvia Todd","(785) 718-4194","feugiat.nec@hotmail.org","278-3008 Vulputate, St.","3299","Assam"),
  ("Holmes Fernandez","1-993-608-7562","erat.eget@icloud.edu","Ap #412-1081 Faucibus Av.","838751","Punjab"),
  ("Cheyenne Molina","1-617-341-7980","urna.nullam@yahoo.ca","639-4889 Nibh. St.","97660-387","Poitou-Charentes"),
  ("Vernon Massey","1-790-325-7571","pede@outlook.org","Ap #691-367 Rhoncus. St.","270803","Victoria"),
  ("Walker Weiss","1-265-415-3382","magna@icloud.couk","P.O. Box 408, 9650 Libero Road","882858","Connacht"),
  ("Nelle Frederick","1-765-126-8368","at.velit@yahoo.edu","481-8530 Amet Av.","0655 OE","Amazonas"),
  ("Leilani Hinton","(314) 224-7311","id@aol.ca","P.O. Box 475, 4261 Ullamcorper Avenue","981931","Ross-shire"),
  ("Baxter Gibson","1-492-778-5358","auctor.velit@icloud.net","P.O. Box 954, 1968 Aliquam Avenue","8735","Arunachal Pradesh"),
  ("Geoffrey Crane","1-723-886-8954","quam@google.ca","Ap #626-9401 Nulla. Rd.","8932 FF","Västra Götalands län");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Lyle Cruz","(637) 612-7358","metus.vitae.velit@yahoo.com","Ap #360-1828 Quisque Rd.","41713","San Luis Potosí"),
  ("Amity Levine","(874) 173-4886","nisi.aenean@hotmail.net","6077 In Street","792648","Tyrol"),
  ("Janna Macias","(740) 144-9417","amet@icloud.org","Ap #934-3106 Imperdiet St.","995661","Gangwon"),
  ("Reed Vaughan","(421) 242-8132","purus.in.molestie@google.org","P.O. Box 221, 8934 Ligula Rd.","77727","Jambi"),
  ("Tyler Christensen","1-828-678-9484","eu.placerat@icloud.net","167-5880 Nam St.","17431","Pernambuco"),
  ("Andrew Yang","(349) 761-7305","id.erat.etiam@outlook.org","189-9418 Mauris Av.","V86 4GL","Adana"),
  ("Giacomo Wooten","(303) 916-9108","quisque@aol.com","1542 Fermentum St.","3663","Chernihiv oblast"),
  ("Ivor Bryant","1-571-795-3868","ac.sem@yahoo.org","Ap #624-4641 Etiam Avenue","95186","Western Visayas"),
  ("Karina Anderson","1-962-237-6847","interdum.enim@yahoo.couk","680-800 Donec St.","7871","Östergötlands län"),
  ("Micah Dennis","1-772-426-8401","augue.malesuada@hotmail.couk","Ap #701-6489 Nam St.","442951","Burgenland");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Brian Hess","(888) 887-3677","congue@google.net","495-213 Mauris Road","274777","Sumy oblast"),
  ("Hu Bowers","1-505-471-7946","mauris.sit@hotmail.edu","694-4566 In Av.","3112","Lombardia"),
  ("Jessica Carpenter","1-438-388-1070","vel.quam@protonmail.org","6296 Arcu Rd.","58368-55648","Nunavut"),
  ("Nola Franks","(232) 312-5181","aliquam.gravida@protonmail.ca","422-6925 Cursus Rd.","03617","Central Luzon"),
  ("Bernard Avila","(694) 428-5654","ridiculus.mus@protonmail.com","8845 Pede St.","8747","Alsace"),
  ("Adena Kim","1-777-695-0636","ipsum.dolor@aol.com","Ap #969-3799 Sed St.","2851-7385","Yukon"),
  ("Chanda Blanchard","(473) 723-8951","pharetra.ut@outlook.edu","P.O. Box 481, 4831 Eu St.","986755","Burgenland"),
  ("Merrill Harper","1-210-737-2198","nunc.quis@outlook.net","Ap #821-3996 Aliquet St.","29-050","Georgia"),
  ("Desirae Wilcox","1-821-351-0487","ac@icloud.couk","Ap #465-7379 Orci. Rd.","54085","Molise"),
  ("Kevin Tran","(617) 860-8017","fusce.fermentum@hotmail.org","707-973 Viverra. Street","2523","Lombardia");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Patrick Hanson","(250) 731-2537","phasellus.dolor@google.edu","418-6281 Augue Road","35-87","Queensland"),
  ("Whilemina Barrera","1-973-722-4693","sapien.imperdiet@yahoo.org","Ap #773-4875 Sollicitudin Street","31275","Ancash"),
  ("Sophia Young","(584) 777-6648","consequat.lectus.sit@icloud.edu","3458 Urna. Ave","3742","Paraná"),
  ("Miriam Hodge","1-776-278-2253","interdum@aol.ca","Ap #591-2685 Dignissim Av.","0625-9121","Punjab"),
  ("Nash Travis","(561) 139-2624","dui.lectus@google.net","3253 Placerat, Avenue","50105","North Gyeongsang"),
  ("Tashya Jacobs","1-851-674-9313","morbi@icloud.ca","359 Elit Avenue","3264 NJ","South Jeolla"),
  ("Lenore Lowery","(511) 264-7254","vitae.mauris@outlook.edu","567-107 Est, Av.","9241","Valle d'Aosta"),
  ("Francesca Carter","1-535-232-2254","in@protonmail.net","Ap #914-1008 Eu Road","7148 TG","Hessen"),
  ("Naomi Mcleod","1-141-963-5785","a@aol.ca","Ap #719-3787 Sapien Ave","56816","Bengkulu"),
  ("Galvin Martin","1-501-766-7882","cras@aol.net","2107 Non, St.","517728","Bạc Liêu");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Branden Everett","(457) 153-5148","nam.nulla@aol.edu","9511 Cursus St.","51769","Northern Cape"),
  ("Zenia Holden","1-683-148-3198","class.aptent@google.net","586-7839 Vel St.","22-672","Khyber Pakhtoonkhwa"),
  ("Omar Rodriquez","1-674-744-5840","mauris@icloud.edu","P.O. Box 626, 1862 Nec, Avenue","83175-92972","Bolívar"),
  ("Francis Salas","(429) 729-0997","at.libero.morbi@protonmail.edu","Ap #454-5179 Donec Road","22236","Paraná"),
  ("Melodie Dejesus","1-227-128-7437","nec.leo@hotmail.com","Ap #318-255 Sem Ave","350274","Manipur"),
  ("Angelica Knight","(388) 836-9754","hendrerit@aol.couk","760-7496 Gravida St.","2873","Lower Austria"),
  ("Declan Hansen","1-178-304-0569","suspendisse.ac.metus@outlook.com","1129 Arcu St.","684618","Kirovohrad oblast"),
  ("Cecilia Kinney","1-328-269-3736","eros.non@icloud.edu","507 Ligula St.","4372","North-East Region"),
  ("Hammett Ingram","(938) 542-2708","tincidunt.nunc.ac@yahoo.org","P.O. Box 307, 8878 Dictum Avenue","368938","Paraná"),
  ("Rosalyn O'donnell","(186) 334-4273","magna.lorem.ipsum@outlook.couk","P.O. Box 109, 5150 Tortor, Av.","635383","Agder");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Amir Cherry","1-127-767-8383","lacus.nulla@icloud.ca","6120 Ipsum Avenue","3890 CY","Zeeland"),
  ("Nicholas Aguilar","(876) 201-3240","dolor.sit@yahoo.couk","8105 Augue Rd.","958019","Salzburg"),
  ("Carl Brewer","1-222-867-4234","in.hendrerit@protonmail.couk","937-2339 Nulla Av.","91A 2W8","Tennessee"),
  ("Timon Burns","1-646-717-3564","nibh.donec@yahoo.net","845-2181 Lobortis Rd.","24268","Gangwon"),
  ("Dorian Atkins","1-872-321-5866","amet.risus@protonmail.net","P.O. Box 823, 5501 Egestas Avenue","3865","Thanh Hóa"),
  ("Melvin Hood","(558) 236-3812","aliquam.gravida@aol.edu","P.O. Box 939, 7678 Sem Rd.","7245-5268","Azad Kashmir"),
  ("Deirdre Bright","1-213-563-8249","enim.mi.tempor@hotmail.edu","P.O. Box 132, 7362 A, Ave","17428","Tomsk Oblast"),
  ("Avye Mccarty","(466) 441-5732","in.ornare@hotmail.net","1583 Aliquet Av.","7184","North Island"),
  ("Hedy Carroll","(541) 482-3492","amet@aol.edu","Ap #591-7057 Sapien. Road","341270","Arkansas"),
  ("Kathleen Johns","(757) 616-0354","amet.massa.quisque@google.ca","659 Interdum Road","265491","Washington");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Kieran Stuart","(254) 238-9518","accumsan.interdum.libero@aol.edu","6045 Justo St.","804538","Wyoming"),
  ("Bert Dominguez","(250) 830-2704","magnis@yahoo.org","102-3304 Scelerisque Ave","34624","North Chungcheong"),
  ("Amber Harding","1-638-425-6684","est.vitae@google.org","Ap #226-6629 Class Road","44-161","Cartago"),
  ("Ivy Leonard","1-282-444-7688","nisl.maecenas@outlook.com","583-2375 Sed, Rd.","52214","Stockholms län"),
  ("Mufutau Gillespie","(934) 940-5824","nibh@protonmail.com","P.O. Box 971, 8783 Id St.","M7V 1RK","Vestfold og Telemark"),
  ("Quentin Cote","(659) 782-3122","morbi.vehicula@protonmail.ca","263-9622 Sed Street","V7 5FB","Upper Austria"),
  ("Yasir Mccarthy","(694) 526-8665","dolor.nulla@outlook.org","Ap #614-2371 Pulvinar Road","34712","İzmir"),
  ("Gil Myers","1-859-700-3586","nunc.nulla@hotmail.org","P.O. Box 237, 1097 Ut St.","686765","Los Lagos"),
  ("Brenda Warren","(624) 284-9733","ornare.facilisis@protonmail.couk","P.O. Box 256, 9146 Sed Rd.","9183-0134","Jeju"),
  ("Chanda Chaney","1-559-827-4725","dolor.nulla@google.edu","P.O. Box 902, 3020 In St.","5847","Dalarnas län");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Felicia Schneider","(104) 546-9552","donec@google.edu","Ap #105-6851 Luctus Rd.","5797","Östergötlands län"),
  ("Lance Booth","1-632-578-9181","mauris.id@icloud.ca","651-8101 Phasellus Avenue","699469","New Brunswick"),
  ("Reece Good","(652) 720-2684","auctor.velit.eget@outlook.edu","Ap #853-4144 Amet, St.","48229","Tabasco"),
  ("William Franklin","1-325-253-4335","cras.sed.leo@google.ca","452-9665 Dictum Ave","7114","Northern Cape"),
  ("Carlos Webster","1-745-418-4522","tincidunt@google.org","486-6374 Lacus Av.","349146","Heredia"),
  ("Cooper Levy","1-584-493-0072","turpis.aliquam@hotmail.ca","502-3829 Id St.","866116","Mpumalanga"),
  ("Brian O'connor","(414) 237-3176","proin@google.com","P.O. Box 404, 1750 Mauris Road","53909","Noord Holland"),
  ("Yetta Murray","1-848-384-6456","eu.eros.nam@aol.couk","Ap #192-2719 Lectus. Ave","198281","Wyoming"),
  ("Abigail Avila","(568) 250-9801","quisque.imperdiet@aol.couk","Ap #741-3652 Maecenas Rd.","40303","Yukon"),
  ("Laith Puckett","(489) 778-5783","eu@aol.org","2474 Erat Rd.","74623-91092","Lviv oblast");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Clarke Hall","(579) 637-8493","felis@yahoo.net","381-5849 Proin Road","21303","Konya"),
  ("Clarke Nunez","1-758-585-3481","vehicula.aliquet.libero@google.ca","Ap #641-3361 Id, Av.","85835","Aragón"),
  ("Hyacinth Mcintosh","(740) 664-8740","urna.nec@protonmail.ca","820-8872 Curabitur St.","6527","Manitoba"),
  ("Jason Jenkins","1-671-452-2095","penatibus.et.magnis@google.com","Ap #260-7819 Dui Ave","7310","Delaware"),
  ("Kevin Fulton","1-577-120-5884","tempus@hotmail.edu","726-4034 Cum Ave","567657","Dnipropetrovsk oblast"),
  ("Felicia Carpenter","(829) 310-0213","lobortis.tellus@aol.ca","Ap #865-4432 Tincidunt Av.","336225","Troms og Finnmark"),
  ("Margaret Clay","(733) 768-2757","eu@aol.couk","P.O. Box 617, 9497 In Av.","2426-3964","Punjab"),
  ("Mollie Schwartz","1-672-329-9775","arcu.aliquam.ultrices@hotmail.couk","931-1368 Rutrum St.","R2G 7C7","Rio Grande do Sul"),
  ("Joan Puckett","(784) 621-1242","mauris@hotmail.com","251-5625 Elit, Street","5275","Australian Capital Territory"),
  ("Brent Ewing","(936) 372-5373","nulla.facilisi.sed@aol.org","Ap #501-6676 Dolor Street","68769","Jönköpings län");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Lareina Sykes","(212) 431-2835","vulputate@icloud.ca","Ap #811-6831 Eu St.","11558","Oyo"),
  ("Vance Mccarthy","(341) 253-2129","turpis.nec@protonmail.org","Ap #604-2011 Nonummy. St.","31-753","Oaxaca"),
  ("Lunea Davidson","1-829-903-2855","enim.diam@aol.com","P.O. Box 156, 9978 Netus Street","443139","South Island"),
  ("Dorian Parker","1-721-338-8774","luctus.aliquet@outlook.net","485 Ac Rd.","57762","New South Wales"),
  ("Samson Hanson","1-135-345-0176","mus.proin@yahoo.com","Ap #522-1865 Adipiscing. Ave","2880","South Sulawesi"),
  ("Quinlan Flowers","(778) 918-7183","fusce@aol.ca","Ap #720-7751 Eget Rd.","677512","Jammu and Kashmir"),
  ("Ulric Tanner","(981) 240-9755","dictum.eu.eleifend@aol.com","3440 Et Road","659495","North-East Region"),
  ("Damian Gamble","(370) 797-4628","egestas.blandit.nam@hotmail.com","845-560 Urna. Av.","136321","Gaziantep"),
  ("Paula Roth","1-340-465-4288","integer.vulputate@google.couk","811-4554 Sit Rd.","954931","Corse"),
  ("Ulla Herrera","1-483-468-9341","suscipit.nonummy@protonmail.com","P.O. Box 352, 9428 Vitae Av.","73451","South Island");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Vielka Harris","(474) 949-7542","diam.luctus@icloud.net","P.O. Box 785, 1073 Tellus St.","3320","Zuid Holland"),
  ("Steel Langley","1-667-696-2575","mauris.rhoncus.id@icloud.net","4466 Malesuada Avenue","7877","Vlaams-Brabant"),
  ("Daphne Knox","(858) 294-1487","duis.at@aol.net","P.O. Box 845, 2481 Duis Rd.","3080-0570","Balochistan"),
  ("Imogene Mays","1-732-671-3473","malesuada@outlook.net","942-2076 Magna. Rd.","03846","Lancashire"),
  ("Lillian Rosales","1-788-638-6661","odio.semper.cursus@protonmail.ca","Ap #793-7382 Donec Street","38563","Osun"),
  ("Alexander Lucas","1-236-326-8784","luctus@outlook.net","6395 Ipsum. St.","9126","Glamorgan"),
  ("Ori Beasley","1-588-382-5089","elit.nulla@protonmail.ca","2341 Nibh. Street","L12 7VJ","Quảng Ngãi"),
  ("Akeem Terry","1-454-388-2509","massa@outlook.org","858-649 Suspendisse Rd.","216884","Mersin"),
  ("Lucius Crosby","1-724-880-3657","ac.sem@icloud.couk","Ap #871-5149 A, Street","329343","Drenthe"),
  ("Yardley Berger","(784) 235-5542","pede.blandit@hotmail.edu","Ap #937-3949 Convallis, Avenue","7623","Santa Catarina");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Boris Garcia","(536) 782-6585","nulla.magna.malesuada@aol.org","941-9011 Risus Road","237822","Kano"),
  ("Reuben Blackwell","1-851-866-6565","luctus.vulputate@icloud.couk","2743 Luctus St.","21245","São Paulo"),
  ("Pamela Sawyer","1-808-795-8478","vitae.aliquam@icloud.org","661-6419 Elit. Rd.","4747-5511","Dalarnas län"),
  ("Tarik Thompson","1-355-147-4587","curabitur.vel@aol.org","937-7429 Amet Rd.","531353","Vermont"),
  ("Phelan Howell","(402) 745-7744","sem.egestas.blandit@icloud.couk","Ap #558-641 Leo, Road","4657-8881","Khánh Hòa"),
  ("Felix Farmer","(933) 469-2764","augue@yahoo.net","8395 Ligula. Avenue","Y2C 8X1","Puno"),
  ("Kathleen Wyatt","(752) 427-5194","elementum.at@yahoo.ca","637-2839 Nunc Rd.","48893","Piemonte"),
  ("Chanda Pierce","1-863-482-7262","egestas.lacinia@hotmail.com","Ap #317-1780 Dolor Rd.","176054","Volgograd Oblast"),
  ("Sara Taylor","(325) 675-8723","consectetuer.rhoncus@hotmail.edu","Ap #366-1592 Proin Rd.","82782","South Island"),
  ("Daniel Shannon","(893) 533-0052","ipsum.porta.elit@protonmail.couk","Ap #125-961 Tempor Rd.","67620","Franche-Comté");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Allistair Wright","1-360-697-6862","malesuada.fringilla@icloud.com","Ap #301-8478 Nunc Avenue","13821","San José"),
  ("India Ware","(114) 415-5631","cursus@aol.org","Ap #517-4714 Proin St.","13025","Molise"),
  ("Russell Frazier","(242) 815-0743","semper@icloud.com","340-2778 Augue Av.","57L 9R1","Connacht"),
  ("Celeste Lester","1-877-101-3650","ullamcorper.velit@protonmail.org","Ap #856-3786 Sit Rd.","5681","Goiás"),
  ("Ahmed Valenzuela","(875) 653-2128","duis@google.edu","3123 In Ave","5112-1371","Cherkasy oblast"),
  ("Jin Castillo","(164) 173-6366","quis.arcu.vel@yahoo.ca","7965 Nam Avenue","582151","South Island"),
  ("Wesley Bradford","1-338-907-0646","ac.mi@protonmail.org","P.O. Box 848, 4961 Vitae, Rd.","32612","Sachsen"),
  ("Dominic Bradford","(942) 840-2971","ullamcorper.eu.euismod@yahoo.org","506 Donec Street","165957","West Region"),
  ("Regina Miles","(527) 351-0860","pede.blandit@outlook.couk","Ap #590-9608 Et, Rd.","4833","Ceuta"),
  ("Susan Richardson","(687) 847-8387","fringilla.porttitor.vulputate@yahoo.net","761-7314 Auctor Ave","659245","Newfoundland and Labrador");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Ifeoma Harvey","1-885-565-4467","velit@yahoo.com","6492 Tincidunt Av.","444724","Novgorod Oblast"),
  ("Deirdre Hendrix","1-548-642-7238","cras.sed@aol.net","Ap #209-3624 Lorem, Street","13622","South Island"),
  ("Selma Robertson","1-107-384-9844","ante.bibendum@aol.ca","403-410 Libero Av.","764389","North-East Region"),
  ("Nathan Wynn","(216) 278-7182","enim.sit.amet@protonmail.edu","4051 Libero Av.","52660","Veracruz"),
  ("Kathleen Shaffer","1-636-752-7552","a.nunc.in@yahoo.com","Ap #957-7530 Quam Road","55059","Pernambuco"),
  ("Adara Albert","1-698-378-3461","nunc@google.org","P.O. Box 521, 1966 Ut, Road","45754","Kahramanmaraş"),
  ("Brett Sears","1-952-653-5754","risus.donec.egestas@outlook.ca","P.O. Box 206, 3303 At Rd.","5707","Bicol Region"),
  ("Zelda Maddox","(468) 437-2093","eu.placerat.eget@hotmail.net","Ap #199-8945 Et Road","3168","Bourgogne"),
  ("Darryl Duke","(456) 666-0554","ut.nec@icloud.net","6434 Scelerisque St.","5640","Istanbul"),
  ("Upton Cohen","(768) 858-2271","lacinia.orci@aol.couk","581-3009 Et Rd.","8552","West Sumatra");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Benedict Morales","(266) 226-1498","euismod.in.dolor@aol.couk","Ap #648-2319 Quisque Ave","3922","Gävleborgs län"),
  ("Uma Dickson","(677) 326-7018","natoque.penatibus.et@outlook.net","P.O. Box 355, 5313 Tempus Road","4797-7334","Istanbul"),
  ("Cadman Roach","(886) 469-3077","eros.nam@protonmail.couk","P.O. Box 890, 9345 Risus Avenue","34347","Auvergne"),
  ("Ezra Webster","(544) 928-7721","lobortis.nisi.nibh@google.com","Ap #125-5186 Sit Road","41213","North Gyeongsang"),
  ("Vernon Houston","1-671-909-7364","aenean.eget@outlook.com","Ap #213-7091 Pede St.","45444","Arequipa"),
  ("Joy Townsend","1-317-522-1360","ut.dolor.dapibus@icloud.net","106-911 Elit, Street","21566","Gyeonggi"),
  ("Phelan Santana","(384) 375-0591","maecenas@protonmail.edu","823-8215 Sem. Rd.","96-111","Saskatchewan"),
  ("Lacota Armstrong","(751) 305-1584","a@google.net","Ap #353-7773 Pede Rd.","792872","Podkarpackie"),
  ("Brennan Blankenship","1-894-125-4772","dui@outlook.edu","Ap #303-1678 Vel Av.","7250","Catalunya"),
  ("Jocelyn Stephenson","(435) 886-3783","ipsum.donec@outlook.net","Ap #970-2354 Ornare Avenue","3658","Kahramanmaraş");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Illana Burns","(375) 453-5511","mollis@icloud.couk","739 Ipsum Av.","02726","North Jeolla"),
  ("Dillon Byers","1-228-168-5768","magna@outlook.com","545-1410 Nulla. Av.","2121-1681","Quebec"),
  ("Tamara Mckay","(968) 672-2972","luctus.et.ultrices@aol.net","Ap #144-2815 Curae Rd.","8727","Gävleborgs län"),
  ("Wayne Arnold","1-656-674-2394","ipsum.cursus.vestibulum@google.net","636-4004 Donec Street","582263","Cundinamarca"),
  ("Yetta Roberts","1-224-740-4396","odio.sagittis@aol.com","Ap #980-4670 Metus St.","32698","Luxemburg"),
  ("Nomlanga Rosales","(329) 548-8885","penatibus.et@icloud.edu","245-3762 Duis Road","S1Q 1BJ","Punjab"),
  ("Zahir Sims","(277) 951-2705","tincidunt.tempus@aol.org","1679 Consequat St.","7652","Metropolitana de Santiago"),
  ("Dai Marquez","1-534-337-8627","velit.quisque@protonmail.net","Ap #250-3087 Nullam Road","35114","Vlaams-Brabant"),
  ("Lee Gill","1-875-246-0578","nunc@icloud.couk","290 Aenean Av.","452226","Piura"),
  ("Brynn Allen","1-460-543-2156","blandit.at.nisi@protonmail.com","P.O. Box 833, 9791 Tellus Rd.","776746","Ilocos Region");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Cole Downs","1-555-795-6453","nec.orci@hotmail.com","941-1635 Et, Road","31715","Şanlıurfa"),
  ("Solomon Wilkins","1-214-116-3670","id.ante.nunc@protonmail.org","Ap #363-4969 Erat, Street","02594-36553","Osun"),
  ("Luke Wells","(555) 414-0229","purus@outlook.net","Ap #209-3237 Id Av.","4285","Jharkhand"),
  ("Michael Bonner","(738) 399-5227","sed.eu@google.edu","Ap #781-2596 Sodales. Rd.","75481","Western Cape"),
  ("Harriet Harding","1-900-303-4878","euismod.ac@hotmail.ca","Ap #995-2582 Lorem St.","558227","Vlaams-Brabant"),
  ("Orlando Shepherd","1-511-144-0315","duis.a@yahoo.org","547-5127 Pretium St.","6521","Gauteng"),
  ("Aidan Bryant","(620) 636-1265","suspendisse.ac@icloud.com","P.O. Box 308, 8003 Viverra. Av.","258683","Styria"),
  ("Noelani Stark","1-353-265-1628","molestie.tellus.aenean@google.ca","425-3177 Et Rd.","453689","Gorontalo"),
  ("Knox Russo","(266) 256-6814","ornare@google.net","773-7716 Praesent Avenue","6720","Zhōngnán"),
  ("Rajah Kelly","(411) 754-4493","velit@aol.net","Ap #789-6714 Ut, Rd.","2534","Cardiganshire");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Maya Mcpherson","1-527-855-1502","integer.urna@google.net","P.O. Box 181, 6170 Felis. St.","8852","Illes Balears"),
  ("TaShya Koch","1-937-463-3965","vivamus.euismod.urna@aol.net","Ap #830-4684 Dolor, Road","629764","Sicilia"),
  ("Graiden Robles","(456) 237-6158","dignissim.lacus@protonmail.com","Ap #913-8114 Donec Av.","4533","Queensland"),
  ("Glenna Alexander","(610) 251-3141","ante.vivamus@hotmail.edu","Ap #174-8872 Est. Rd.","425942","Vorarlberg"),
  ("Cade Reynolds","(393) 259-4485","vehicula.et@hotmail.org","268-9301 Dui, Av.","293425","Central Region"),
  ("Caesar Rowland","(678) 313-7049","in@icloud.edu","Ap #631-6665 Arcu St.","582531","Aberdeenshire"),
  ("Melinda Cook","1-635-881-6409","in.hendrerit@aol.org","167-9795 Lectus St.","716942","Oregon"),
  ("Lee Bender","1-951-433-8167","dolor.dapibus@google.edu","Ap #266-638 Fringilla Road","2341","Huádōng"),
  ("Grace Sherman","(454) 168-1881","orci.lobortis.augue@yahoo.edu","589-6512 Vitae Ave","47051","Jönköpings län"),
  ("Trevor Langley","1-158-748-4231","fermentum.fermentum@google.ca","Ap #946-1616 A, St.","455448","Lower Austria");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Adara Dickerson","(205) 433-7148","enim@yahoo.couk","559-7334 Velit. St.","34526","Volgograd Oblast"),
  ("Bryar Vazquez","(647) 552-3837","id@google.net","1646 Luctus St.","99874-736","Drenthe"),
  ("Raymond Delacruz","1-886-206-5644","donec.dignissim@yahoo.net","385-392 Est, St.","882747","Andhra Pradesh"),
  ("Kibo Smith","(658) 130-2725","cursus.diam.at@hotmail.ca","Ap #991-2406 Morbi Avenue","6803","Bến Tre"),
  ("Whoopi Herman","(589) 467-5680","ac.mattis@outlook.ca","P.O. Box 293, 7764 Et, St.","36-186","Veneto"),
  ("Plato Frazier","(291) 154-3007","semper.cursus@aol.net","Ap #338-461 Tincidunt, Rd.","3248","Luxemburg"),
  ("Edan Yates","(745) 683-6842","sit@aol.couk","6617 Urna. St.","75505","Lorraine"),
  ("Dana Cochran","1-531-857-7527","eget@yahoo.net","Ap #300-1260 Velit Rd.","6127","New South Wales"),
  ("Judith Tyler","(846) 213-3855","pellentesque.habitant@yahoo.edu","258-3731 Nulla St.","40014","Suffolk"),
  ("Knox Curry","1-851-689-4407","donec@aol.com","Ap #368-8937 Egestas Rd.","K1K 1A6","Tasmania");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Deacon Jordan","(186) 735-9657","massa@google.com","P.O. Box 165, 9531 Nisi. Rd.","16668","Adana"),
  ("Phelan Henry","1-423-632-1518","mus@icloud.com","P.O. Box 478, 4536 Magna. Road","8040","East Java"),
  ("Grady Bass","1-707-573-5146","augue@icloud.com","2610 Adipiscing Rd.","57T 1E9","Sonora"),
  ("Ocean Kinney","1-324-712-5312","dictum.augue@aol.org","P.O. Box 522, 4799 Nisi. Av.","34876","Innlandet"),
  ("Rachel Hutchinson","(788) 786-9477","quisque@outlook.org","Ap #992-2377 Est. St.","736877","Lambayeque"),
  ("Halee Flores","1-605-440-6967","tellus.suspendisse@icloud.ca","Ap #995-2760 Ligula Ave","504571","Northern Territory"),
  ("Clio Kemp","1-387-613-7218","velit@google.ca","5038 Nunc St.","19657","Campania"),
  ("Ralph Ray","1-588-716-3512","et@protonmail.edu","Ap #134-5461 Tortor. Av.","13573","Trentino-Alto Adige"),
  ("Isadora Hubbard","1-227-270-5391","a@outlook.couk","1654 Dictum. Av.","61672","Bayern"),
  ("Jena Duncan","(775) 792-6733","sem.vitae@yahoo.org","8581 Felis Av.","15183-585","Akwa Ibom");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Odysseus Stephenson","(760) 348-1523","curabitur.consequat@google.org","P.O. Box 800, 9318 Eleifend Ave","33116-83146","Sicilia"),
  ("Kasimir Mccarty","(265) 356-9875","elit@yahoo.net","853-220 Amet, Ave","A2N 3H6","Marche"),
  ("Burton Branch","1-320-425-5357","odio@google.ca","5500 Risus. Ave","73348","Northern Cape"),
  ("Nathan Benjamin","(734) 788-3281","lobortis.augue@aol.ca","P.O. Box 439, 5370 Porttitor Road","08240-39868","Piura"),
  ("Elvis Delgado","(721) 851-9572","montes.nascetur@icloud.net","335-6309 Magna. Street","308528","Alajuela"),
  ("Abraham Joyner","1-478-784-8507","non@protonmail.net","Ap #335-1873 Ornare. Road","378965","Oslo"),
  ("Steven Morris","1-548-752-0587","amet.nulla@google.couk","Ap #550-2537 Curabitur Avenue","2677","East Region"),
  ("Illana Bowman","(417) 411-8886","arcu.curabitur@icloud.org","338-5797 Id Ave","83-37","Sachsen-Anhalt"),
  ("Judith Hancock","1-830-515-6659","nullam.ut@protonmail.ca","P.O. Box 105, 3691 Convallis St.","25588","Meta"),
  ("Thomas Wagner","(874) 356-5410","non.egestas@protonmail.org","Ap #531-6919 Eu St.","11421","Zhytomyr oblast");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Leandra Mcfarland","1-966-543-1282","cras.dolor.dolor@google.net","P.O. Box 158, 124 Non Av.","6731 XC","Anambra"),
  ("Roth Owens","1-786-448-3673","tortor.nibh@protonmail.com","813-4656 Scelerisque Rd.","20813","Salzburg"),
  ("Hadassah Mcdaniel","(277) 209-7568","vitae.erat@outlook.com","P.O. Box 467, 4419 Aenean St.","68278-89975","Gävleborgs län"),
  ("Joelle Webb","(512) 587-7433","est.nunc@yahoo.net","705-474 Suspendisse St.","482755","Konya"),
  ("Noelle Dominguez","(625) 233-5451","lacinia@yahoo.couk","140 Quam Road","51-15","North Gyeongsang"),
  ("Dawn Hill","(861) 627-6213","pellentesque.eget@yahoo.org","P.O. Box 591, 5572 Tellus Street","17-273","Minnesota"),
  ("Theodore Caldwell","1-674-549-1188","vel.venenatis@hotmail.net","453-1521 Non St.","1111 CR","Đồng Nai"),
  ("Ciara Berg","(856) 627-2775","massa@icloud.couk","P.O. Box 962, 7886 Ac St.","7898","Andhra Pradesh"),
  ("Gage Salas","1-853-914-8527","vel.pede@google.ca","P.O. Box 210, 5948 Neque Road","2715","Victoria"),
  ("Jacob Hunt","1-968-527-3474","nibh.vulputate.mauris@google.edu","876-4466 Est Street","23-34","Basilicata");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Randall Estrada","1-948-268-4866","nullam.enim.sed@outlook.org","Ap #365-3194 Et Av.","64479","Trentino-Alto Adige"),
  ("Naida Levy","1-918-353-4595","ultrices.duis@yahoo.org","Ap #302-1642 Dolor Ave","67615-577","West Papua"),
  ("Kylie Mason","1-615-416-4103","proin.dolor@aol.couk","P.O. Box 350, 587 Eget St.","7859","East Region"),
  ("Dahlia Stephenson","(138) 371-3721","pretium.aliquet.metus@aol.ca","682-7500 Dolor Avenue","515548","Newfoundland and Labrador"),
  ("Sasha Roth","1-472-595-5708","lacus.quisque.purus@google.org","840-3160 Nec, Rd.","942279","Gilgit Baltistan"),
  ("Carla Valenzuela","(365) 981-7921","non.dapibus@hotmail.com","9839 Nam Street","301158","Ulster"),
  ("Lunea Villarreal","1-718-165-6947","magna@outlook.net","9011 Tellus St.","45666-43827","Kherson oblast"),
  ("Gregory Callahan","(756) 578-6138","lobortis.mauris.suspendisse@outlook.couk","Ap #463-6683 Dapibus Rd.","28825","Trentino-Alto Adige"),
  ("Lani Turner","(884) 659-6827","non@outlook.com","Ap #635-6427 Felis. Ave","89443","Banten"),
  ("Quinn Fuentes","1-832-653-4792","laoreet.ipsum@hotmail.couk","Ap #154-9648 Enim, Street","43114-45962","Şanlıurfa");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Alika Garner","1-856-237-3125","ut.tincidunt@protonmail.edu","673-6749 Mi. Rd.","364439","Friuli-Venezia Giulia"),
  ("Gareth Heath","(718) 780-4861","turpis.vitae@icloud.couk","Ap #354-5259 Laoreet St.","15-053","Mazowieckie"),
  ("Rogan Banks","1-342-266-5333","euismod.enim@aol.edu","2231 Pharetra Road","6879 JK","Tyrol"),
  ("Evan Osborn","1-268-636-4634","donec.nibh.quisque@yahoo.edu","P.O. Box 877, 9456 Bibendum Ave","8843-1641","Canarias"),
  ("Drake Chavez","1-366-238-6076","ornare.libero@google.net","610-5257 Risus. Av.","98622","South Chungcheong"),
  ("Chadwick Tate","1-225-136-6256","neque.nullam@icloud.net","P.O. Box 200, 9195 Sit Rd.","855156","Gävleborgs län"),
  ("Tyler Ball","1-807-882-2190","id@outlook.com","Ap #961-2041 Montes, Avenue","15642","Ulster"),
  ("Joseph Myers","(919) 619-4664","in@google.org","Ap #225-9077 Fermentum Rd.","2646","Quảng Bình"),
  ("Whitney Lowe","(660) 674-1635","pulvinar.arcu.et@yahoo.couk","354-1789 Non, Ave","27-82","Xīběi"),
  ("Harlan Harding","1-389-466-0349","ligula.aliquam@protonmail.ca","183-3697 Eu, Avenue","95927","Zhōngnán");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Echo Hines","(484) 466-9760","vitae.mauris.sit@protonmail.ca","Ap #287-3460 Lorem Av.","81618","Limón"),
  ("Angelica Norton","1-269-813-1597","sed.facilisis.vitae@aol.net","1849 Mauris, Road","4719 AN","Rivers"),
  ("Dacey Brennan","(214) 320-3347","nascetur@hotmail.ca","Ap #160-6313 Sed St.","92111","Thừa Thiên–Huế"),
  ("Xavier Conner","1-821-774-2218","rutrum.justo.praesent@hotmail.net","Ap #300-9132 Integer Avenue","86-883","Noord Brabant"),
  ("Guinevere French","(905) 393-0666","nunc@icloud.ca","357-7886 Dolor Avenue","5576","Sokoto"),
  ("Joelle Sandoval","(373) 474-5767","placerat.cras@icloud.edu","Ap #602-3542 Auctor, Ave","5942","Guanacaste"),
  ("Acton Sykes","1-388-986-7817","erat.in@outlook.org","Ap #771-8632 Consectetuer Rd.","68232-845","Zakarpattia oblast"),
  ("Abigail Matthews","(474) 806-5666","orci@outlook.com","426-9815 Turpis. Ave","7408","Lower Austria"),
  ("Jordan Kemp","1-674-337-8369","sem.mollis@icloud.couk","P.O. Box 698, 2493 At, St.","782358","Zeeland"),
  ("Mollie Shaw","(653) 773-4781","nec.diam.duis@yahoo.edu","Ap #922-7528 Nec Street","16886","Bahia");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Ralph Alston","(526) 676-6126","mauris.sapien.cursus@protonmail.org","Ap #959-586 Pede St.","N5 6WG","Stockholms län"),
  ("Hanae Noel","(221) 289-7264","aliquam.gravida@icloud.org","538 A, Rd.","54664-73483","Mpumalanga"),
  ("Lawrence Simon","(527) 363-8775","erat.eget.tincidunt@protonmail.com","P.O. Box 814, 8371 Mi Avenue","55166-78882","Sumy oblast"),
  ("Chantale Glenn","1-747-196-5676","integer@yahoo.net","158-6711 Mollis Street","40585-525","Overijssel"),
  ("Rashad Perry","1-744-243-5521","dictum@hotmail.org","2575 Ut Rd.","38286","Osun"),
  ("Carla Ochoa","(951) 305-5416","a.facilisis@aol.com","416-4044 Felis St.","30404","Punjab"),
  ("Jin Harrison","1-646-401-8351","suspendisse@hotmail.com","Ap #225-8420 Pharetra Ave","2676","Lagos"),
  ("Shea Noble","1-451-340-5980","auctor.odio.a@protonmail.couk","Ap #691-5403 Tincidunt Ave","50116","Van"),
  ("Rose Kirk","(441) 992-2747","massa.mauris.vestibulum@protonmail.org","Ap #467-4863 Ut St.","818550","Illes Balears"),
  ("Audra Nieves","1-860-294-8895","semper@google.org","570-3061 At, St.","3887","Osun");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Rebekah Richmond","(303) 708-6274","pharetra@outlook.com","Ap #892-2670 Magna. Rd.","8166","Noord Holland"),
  ("Reese Pitts","1-389-702-1166","euismod.mauris@aol.ca","887-3487 Semper Rd.","0186","Yukon"),
  ("Rhiannon Park","1-515-981-6654","nunc@hotmail.couk","3936 Tortor. Rd.","63535","Los Lagos"),
  ("Madaline Hewitt","(668) 964-7670","nulla.at.sem@yahoo.com","Ap #707-4586 In St.","3324","Gangwon"),
  ("Eaton Rogers","1-273-274-8943","sollicitudin.commodo@outlook.com","712-2169 Consectetuer Rd.","676858","Baden Württemberg"),
  ("Kaitlin Rice","1-264-728-2358","scelerisque.lorem@outlook.com","938-9858 Natoque Rd.","6414","Flevoland"),
  ("Kevyn Barton","(676) 674-8184","aliquam.rutrum@yahoo.ca","P.O. Box 424, 6497 Lacus. Street","41205","Zachodniopomorskie"),
  ("Orla Meyer","1-862-600-4276","faucibus.morbi.vehicula@protonmail.couk","876-1888 A, Ave","79324","Saarland"),
  ("Barbara Silva","(931) 483-9663","ipsum.nunc@protonmail.org","Ap #656-6839 Massa. Ave","6720","Xīnán"),
  ("Talon Marquez","1-685-434-8783","ut.nisi@aol.com","Ap #888-8713 At, St.","2680","Worcestershire");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Henry Day","1-230-787-1687","velit@icloud.com","593-9673 Diam Rd.","822594","Xīnán"),
  ("Reece Carroll","(827) 501-7221","natoque@aol.org","238-691 Cursus Avenue","33832","Cajamarca"),
  ("Amber Whitaker","(966) 884-5123","faucibus.lectus@icloud.net","174-2415 Nullam St.","6513","Bangsamoro"),
  ("Dora Gates","(461) 438-1940","adipiscing.lobortis.risus@protonmail.couk","594-2448 Nec Rd.","16766","South Island"),
  ("Xantha Levy","1-327-941-3085","etiam@google.couk","P.O. Box 858, 3552 Lacinia St.","12113","Caldas"),
  ("Martina Mercer","(742) 665-8855","dolor.elit@yahoo.couk","9960 Felis. St.","36256007","Rheinland-Pfalz"),
  ("Candace Mason","(681) 137-4220","cras.interdum.nunc@aol.org","Ap #740-7578 Enim St.","697943","Liguria"),
  ("Hollee Garza","1-799-755-3403","euismod.est@yahoo.net","P.O. Box 659, 5818 Quam Avenue","475878","Gelderland"),
  ("Natalie Morgan","1-262-314-7415","donec.tincidunt@icloud.net","138-2042 Fusce Rd.","33127","Punjab"),
  ("Tyrone Bond","(735) 711-0632","nunc.mauris.sapien@google.net","552-7437 Fermentum Street","228696","South Australia");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Erin Tillman","(355) 141-5732","est@aol.com","177-5204 Luctus Avenue","652647","Nunavut"),
  ("Ferdinand Marquez","(738) 565-8944","nonummy.ipsum.non@icloud.net","Ap #669-773 Adipiscing Street","641774","Valle del Cauca"),
  ("Heidi Wolf","(624) 313-3191","amet.risus.donec@hotmail.com","Ap #551-5913 Pede St.","637331","Northwest Territories"),
  ("Tanisha Mays","1-583-818-3538","iaculis.nec.eleifend@google.couk","Ap #932-8761 Feugiat Rd.","842604","Jambi"),
  ("Gwendolyn Cotton","1-562-679-1359","nullam.velit.dui@yahoo.net","P.O. Box 755, 4329 Sit Rd.","30853166","Sinaloa"),
  ("Lev Lindsey","1-381-458-2960","vitae.velit@outlook.ca","9882 A Av.","8850","Atlántico"),
  ("James Morton","(392) 355-4547","sit@icloud.couk","Ap #245-2935 Malesuada. Ave","866561","New South Wales"),
  ("Michelle Barron","(770) 686-2288","phasellus.dapibus@hotmail.net","Ap #547-8987 Arcu Street","44443","Mazowieckie"),
  ("Jerry Montoya","1-454-750-7931","ornare.lectus.ante@aol.edu","977-8019 Auctor Rd.","9611","Victoria"),
  ("Arden Payne","(669) 172-2558","faucibus.ut.nulla@aol.edu","P.O. Box 976, 250 Congue, Rd.","57669","Eastern Cape");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Graiden Benjamin","1-234-718-2246","congue@google.couk","P.O. Box 391, 4814 Tincidunt Av.","9284-8211","Podkarpackie"),
  ("Jaime Sykes","(237) 866-5472","feugiat.non.lobortis@google.net","811-4649 Quis St.","45458","Điện Biên"),
  ("Cody Meadows","1-146-763-6778","hendrerit.consectetuer@icloud.couk","290-389 Vel Avenue","52087","Konya"),
  ("Neville Harding","(239) 759-2248","fringilla.donec.feugiat@protonmail.net","4700 Morbi Avenue","84876","Comunitat Valenciana"),
  ("Guinevere York","(440) 374-7171","suspendisse@aol.net","237-6806 Blandit Ave","0815","Västra Götalands län"),
  ("Erin Newman","1-535-495-3312","et.magnis.dis@outlook.com","Ap #461-1451 Gravida Avenue","2347","Banten"),
  ("Camille Franco","1-795-978-3084","quam@hotmail.org","Ap #928-1764 Accumsan Avenue","11617","Victoria"),
  ("Abigail Adkins","(852) 151-8449","turpis.aliquam@hotmail.net","208-2415 Amet Avenue","55285","Akwa Ibom"),
  ("Sylvia Clarke","(968) 813-2188","lobortis.mauris@google.edu","P.O. Box 706, 3596 Suspendisse Rd.","6263-8974","Limón"),
  ("Vernon Wolfe","1-573-291-2910","mi.duis.risus@aol.org","5817 Netus Rd.","6241","Dōngběi");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Yael Matthews","1-624-523-7852","erat@outlook.couk","P.O. Box 160, 3158 Facilisis. Rd.","2544","Limón"),
  ("Brittany Atkinson","(551) 875-6158","lectus.pede@icloud.couk","P.O. Box 905, 981 Blandit Avenue","87077","Oost-Vlaanderen"),
  ("Kermit Morris","(803) 517-8512","fusce.aliquam@hotmail.com","Ap #231-2090 Sit Ave","8588","Murcia"),
  ("Gisela Russo","1-534-478-5884","lacus.quisque@yahoo.edu","938-5015 Dictum. Avenue","7128","Manitoba"),
  ("Jocelyn Mitchell","(744) 645-5324","erat.volutpat@protonmail.com","P.O. Box 409, 4273 Velit Street","97-55","Vladimir Oblast"),
  ("Vernon Barber","1-338-525-7278","imperdiet@icloud.org","501-1627 Pulvinar Rd.","141477","South Kalimantan"),
  ("Omar Shepard","1-546-776-0464","dolor.dapibus.gravida@google.com","Ap #219-7293 Eu Rd.","7504","Møre og Romsdal"),
  ("Eleanor Wise","(377) 141-7751","adipiscing.elit@hotmail.com","236 Interdum Ave","4787","Western Visayas"),
  ("Ezra Cochran","(637) 850-3843","elit.dictum@icloud.edu","P.O. Box 827, 7329 Netus St.","14998-16705","Pomorskie"),
  ("Jonah French","(849) 577-4561","quis.turpis.vitae@yahoo.couk","Ap #295-2497 Luctus. Rd.","32-65","Assam");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Neville Mathis","(370) 477-2123","commodo@aol.org","642-721 Donec St.","848877","Dōngběi"),
  ("Wendy Workman","(427) 435-5457","nec@yahoo.ca","P.O. Box 227, 9818 Ante Rd.","12031","National Capital Region"),
  ("Buffy Mayo","(760) 250-2666","vivamus.euismod.urna@hotmail.ca","525-4374 Augue. Ave","59-75","Bourgogne"),
  ("Gretchen Bradshaw","1-561-738-9785","ac@google.org","Ap #526-6223 Mus. Road","S1K 6C1","Munster"),
  ("Diana Valenzuela","(789) 617-6488","posuere@icloud.net","627-1300 Semper Street","925357","Nebraska"),
  ("Cara Hart","1-253-212-9826","erat.eget.tincidunt@hotmail.com","226-3093 Lorem Road","773788","Central Region"),
  ("Akeem Robertson","(445) 631-3720","morbi.metus.vivamus@google.org","P.O. Box 521, 8718 Sociosqu Rd.","6744","Bourgogne"),
  ("Alma Sargent","1-942-741-5650","ornare.fusce@protonmail.edu","P.O. Box 635, 109 Nibh St.","56801","San José"),
  ("Lionel Russell","1-737-580-4107","aenean@hotmail.com","P.O. Box 680, 2860 Aliquam Av.","4515","Overijssel"),
  ("Ferris Black","1-307-268-3923","orci.adipiscing@icloud.net","Ap #647-3070 Cursus Av.","778216","North West");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Caldwell Parks","(687) 385-6527","ac.ipsum@icloud.org","9029 Urna. Rd.","831470","Lorraine"),
  ("Kathleen Payne","1-368-221-6862","nulla.eget@aol.com","4950 Tincidunt, Av.","53C 7T9","Dalarnas län"),
  ("Tallulah Mendez","1-626-690-8862","nunc.sed@yahoo.couk","Ap #359-7996 Dolor St.","422143","Santander"),
  ("Colton Hess","1-891-265-2772","vitae.orci@outlook.org","Ap #552-6580 Tempus, Road","37087","Kayseri"),
  ("Axel Velazquez","1-483-708-2686","aliquam.auctor.velit@icloud.ca","P.O. Box 316, 116 A, Ave","50118","Amazonas"),
  ("Neil Barron","1-748-511-4254","lacinia.at@protonmail.ca","Ap #270-6989 Sit St.","872871","Umbria"),
  ("Tarik Nieves","(777) 281-8043","dapibus@outlook.org","P.O. Box 392, 7637 Tortor St.","112324","Oslo"),
  ("Rudyard Wallace","1-425-944-6666","a@yahoo.ca","179-3044 A Street","84971","Friesland"),
  ("Portia Pennington","(104) 769-9453","mauris.molestie@aol.edu","Ap #461-4873 Nec, Rd.","43371","Gorontalo"),
  ("Deirdre Wheeler","1-167-884-3213","orci@outlook.net","Ap #393-9576 Sed St.","6793","Namen");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Rashad Schroeder","(225) 728-2255","suspendisse@hotmail.net","1480 Ligula Rd.","8436","Bình Định"),
  ("Hamilton Lester","(554) 222-0326","adipiscing.elit@protonmail.net","Ap #403-8012 Sed Rd.","12414","Rogaland"),
  ("Mari Ashley","1-705-888-8628","magna.nam@aol.ca","711-7864 Consequat Rd.","780131","Nizhny Novgorod Oblast"),
  ("Yetta Kirk","(856) 656-0582","nascetur@aol.com","Ap #708-9601 Lobortis Ave","125762","North Chungcheong"),
  ("Peter Everett","1-648-849-4236","urna@aol.couk","Ap #965-9004 Pede Av.","20133","Tula Oblast"),
  ("Celeste Brooks","(295) 628-8678","lobortis.mauris@protonmail.com","1433 Lectus. St.","2287","Free State"),
  ("Leah George","(891) 666-2680","vulputate.lacus@yahoo.ca","275-8825 Vivamus St.","67236","Corse"),
  ("Mira Atkins","1-882-146-6798","senectus.et@yahoo.org","Ap #601-345 Habitant St.","50912","Ogun"),
  ("Uta Graves","(567) 236-1481","et.netus@outlook.couk","936-4706 Quam. Street","513171","Kaluga Oblast"),
  ("Kimberly Mathis","1-433-657-1334","ultrices@outlook.com","349-5261 Luctus Avenue","83551","Gangwon");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Rooney Ramirez","1-553-153-2986","duis.sit@icloud.ca","P.O. Box 348, 631 Eu St.","47302","An Giang"),
  ("Karyn Hinton","1-222-778-4583","feugiat@icloud.edu","Ap #694-7772 Interdum Avenue","502665","Cantabria"),
  ("Christine Oliver","(567) 208-6566","mus.donec@hotmail.com","Ap #911-7316 Eros. Av.","T4R 0K8","Bryansk Oblast"),
  ("George Yates","(555) 819-3268","turpis.in@icloud.net","247-3094 Volutpat Avenue","2757","Alsace"),
  ("Damian Clements","(918) 511-6175","magna.nec.quam@yahoo.ca","719-9665 Risus. St.","28-26","West Sumatra"),
  ("Eaton Harper","(430) 133-7154","commodo.hendrerit@yahoo.edu","522-1341 Urna. Rd.","E4 5CR","West Region"),
  ("Alfonso O'Neill","1-165-342-7362","at@yahoo.com","858-1707 Tempor, Street","DZ8 3QZ","Bremen"),
  ("Cain Richards","(267) 542-3042","sodales.mauris.blandit@hotmail.ca","9331 Iaculis St.","976656","Osun"),
  ("Nevada Christian","1-286-659-7171","lacus@hotmail.net","Ap #248-6876 A, St.","67616","Dolnośląskie"),
  ("Preston Mcmillan","1-744-218-1807","condimentum@yahoo.couk","P.O. Box 855, 5251 Nisi. Ave","364802","Languedoc-Roussillon");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Miranda Malone","(596) 342-1733","vitae.mauris@google.edu","P.O. Box 812, 8090 Lacus. Road","15666","Valle d'Aosta"),
  ("Pascale Wiggins","1-260-717-1210","donec.dignissim@yahoo.net","5966 Et Avenue","42258","Huádōng"),
  ("Mannix Lyons","(680) 431-5842","rutrum.magna@outlook.ca","215-6771 Nibh. St.","940138","Azad Kashmir"),
  ("Lilah Sheppard","1-405-847-3693","elit@aol.ca","Ap #105-910 Vel Rd.","EN23 7KU","Kent"),
  ("Ezekiel Cervantes","(676) 514-8873","metus.in.nec@hotmail.ca","994-4694 Integer Ave","5556","KwaZulu-Natal"),
  ("Lev Whitley","(573) 419-3348","natoque.penatibus@icloud.edu","9441 Scelerisque Road","673541","Cantabria"),
  ("Regan Gould","(277) 637-9211","suscipit.est@icloud.couk","8143 Eu St.","431442","Castilla - La Mancha"),
  ("Noel Soto","1-761-235-8021","aliquam.rutrum@google.net","Ap #210-7563 Fermentum Avenue","1849","Donetsk oblast"),
  ("Heidi Gilliam","(994) 581-3424","mauris.sit@outlook.edu","823-1604 Ut Street","9116","Luik"),
  ("Baxter Hamilton","1-868-665-3934","montes@icloud.net","454-8180 Sollicitudin Rd.","3437","Henegouwen");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Oliver Jenkins","1-870-434-8042","luctus.aliquet@protonmail.com","Ap #239-4385 Cras Ave","EO8L 9AW","Oyo"),
  ("Eve Webb","(385) 343-7687","ut.dolor@yahoo.com","Ap #568-388 Vitae, Street","7583","Valle del Cauca"),
  ("Dara Rollins","(416) 620-9556","sodales.purus@aol.com","P.O. Box 824, 9284 Lacinia St.","44822","Punjab"),
  ("Ulla Bright","(745) 802-6524","nulla.aliquet@protonmail.org","Ap #546-8523 Tincidunt Ave","5277","Jambi"),
  ("Todd Ramos","(568) 511-7512","phasellus.fermentum.convallis@hotmail.com","7991 A, Rd.","214649","Oost-Vlaanderen"),
  ("Amal Huffman","(630) 541-1513","suspendisse.commodo.tincidunt@aol.edu","P.O. Box 322, 4311 Elit, Rd.","866343","Mpumalanga"),
  ("Amery Reese","1-435-755-6418","viverra.maecenas@aol.couk","430-2146 Lectus Rd.","591692","Sóc Trăng"),
  ("Vernon Hayden","(445) 655-4171","rhoncus.donec@outlook.net","883-9289 Mollis Av.","34123","Galicia"),
  ("Brenna Webster","1-883-353-1435","dolor.fusce@hotmail.edu","7126 Facilisis Ave","419861","Zaporizhzhia oblast"),
  ("Mannix May","(786) 768-8016","sapien@outlook.org","417-9397 Imperdiet St.","30113","Punjab");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Angela Valentine","1-688-928-3303","quis.massa.mauris@outlook.org","4455 Nec, Av.","47-68","Opolskie"),
  ("Theodore Camacho","(202) 168-6743","pede.ultrices@yahoo.org","Ap #788-4017 Sem Ave","8737","Gävleborgs län"),
  ("Lester Velazquez","(245) 211-7432","dictum@icloud.edu","819-3389 A Av.","1979 TL","Bahia"),
  ("Tyrone Harrell","1-453-465-0824","amet.consectetuer@icloud.couk","Ap #242-4125 Morbi Street","1684","Flevoland"),
  ("Blake Lyons","1-567-529-1642","cras.dictum.ultricies@protonmail.couk","Ap #791-1308 Nulla Rd.","6121","Vestland"),
  ("Lana Gross","(666) 862-8743","nam.consequat@icloud.ca","340-6174 Augue Avenue","795816","North-East Region"),
  ("Demetria Garza","1-864-207-7606","vel.venenatis@icloud.edu","Ap #142-5035 Risus Road","377535","Buckinghamshire"),
  ("Aurora Woodard","(199) 766-9166","enim.commodo@icloud.edu","Ap #584-6580 Nulla Rd.","5947","Distrito Capital"),
  ("Tanya Casey","(571) 832-7135","ornare.lectus@outlook.ca","248-5798 Velit. Av.","666147","Tyrol"),
  ("Tarik Sullivan","(237) 632-0861","iaculis.odio.nam@google.couk","269 Nam Rd.","9567 OI","Luik");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Marvin Ortega","1-685-669-5983","lectus.nullam.suscipit@google.org","9196 A Avenue","781546","Suffolk"),
  ("Darrel Willis","1-760-824-6835","sodales.nisi.magna@google.ca","383-4196 Placerat Road","348694","Magdalena"),
  ("Julian Schneider","1-763-865-4487","odio.vel@icloud.net","5647 Vulputate Av.","307625","Paraíba"),
  ("Barclay Pitts","1-382-296-8306","vitae.risus@aol.edu","993 Pharetra St.","270310","Delta"),
  ("Ray Petty","(428) 855-2875","integer.id@outlook.couk","707-4030 Turpis. Road","6468","Murmansk Oblast"),
  ("Aiko Coffey","1-127-550-5147","nisl.quisque@hotmail.couk","Ap #659-7151 Ridiculus Av.","145739","Innlandet"),
  ("Davis Gould","(167) 612-1894","elementum.sem@hotmail.edu","832-6724 Luctus. Street","33428","New Brunswick"),
  ("Illiana Hopper","1-718-533-3751","mauris.eu.elit@hotmail.org","Ap #984-1328 Ac Street","3412","Cantabria"),
  ("Allistair Fry","(715) 318-3955","mauris.id.sapien@icloud.edu","Ap #787-108 Ipsum Road","MG87 4TQ","Yaroslavl Oblast"),
  ("Rogan Patton","(444) 358-2577","dui@outlook.net","764-1790 Dictum Street","41146","Riau Islands");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Tara Patterson","(281) 697-0271","donec.tempor@hotmail.com","P.O. Box 889, 4427 Amet, Avenue","9270","Victoria"),
  ("Nissim Murphy","(117) 670-0102","ligula.nullam.feugiat@aol.ca","Ap #754-8213 Pharetra. Rd.","8393","Lubelskie"),
  ("Amelia Lynn","1-743-846-1700","enim.sed@google.edu","694-9101 Nulla St.","3954121","Piemonte"),
  ("MacKenzie Contreras","(762) 726-2485","sollicitudin.adipiscing@protonmail.couk","P.O. Box 417, 8232 Mi Road","28411","Rio Grande do Sul"),
  ("Gemma Bray","1-358-773-6313","dignissim.tempor@icloud.couk","P.O. Box 515, 731 Integer Ave","536134","Pomorskie"),
  ("Renee Carpenter","1-176-548-7419","feugiat@hotmail.edu","479-5838 Mollis Rd.","4871","Stockholms län"),
  ("Shana Rodriquez","1-865-931-7877","vestibulum.neque@aol.net","Ap #800-7080 Nulla St.","429352","Gaziantep"),
  ("Lilah Contreras","1-826-123-9724","ipsum.donec@outlook.couk","827-2074 Mauris Av.","267842","Maranhão"),
  ("Violet Koch","(906) 620-5440","rutrum.justo@icloud.couk","Ap #139-8583 Ac, St.","2131","Swiętokrzyskie"),
  ("Hadley Hopper","1-175-613-7271","egestas.nunc@protonmail.com","Ap #414-6435 Non Street","113888","Azad Kashmir");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Cairo Mayer","1-217-571-7826","nostra.per@protonmail.com","Ap #643-1079 Tincidunt. Rd.","561522","North Island"),
  ("Lev Rivers","(838) 721-9256","felis@outlook.ca","Ap #307-360 Nisl. Rd.","36608-71356","North Island"),
  ("Brynn Carey","(484) 386-6650","non.justo@icloud.ca","Ap #492-8352 Cum Av.","266852","Kentucky"),
  ("Elton Schneider","(521) 334-8817","auctor@hotmail.net","Ap #751-3943 Ultricies Street","29417","Overijssel"),
  ("Leandra Aguilar","1-282-278-4237","fringilla.donec@yahoo.net","P.O. Box 929, 2758 Integer St.","6353-1002","La Libertad"),
  ("Nigel Webb","1-244-859-3588","luctus.ipsum@protonmail.ca","342-963 Dolor Rd.","58-87","Oryol Oblast"),
  ("Vera Avila","(769) 117-6411","sem.nulla@yahoo.org","738-675 Fringilla, Rd.","55-24","Kemerovo Oblast"),
  ("Wendy Haney","1-371-574-1656","integer@protonmail.com","354-7483 Elit Street","256624","Lviv oblast"),
  ("Ciara English","(822) 338-5579","consectetuer@google.edu","814-1675 Magna Rd.","157866","North Chungcheong"),
  ("Wallace Mosley","1-293-572-5302","quis.pede@aol.ca","Ap #412-2875 Cum St.","51925","Morelos");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Nevada Noble","1-761-894-7479","neque.pellentesque@yahoo.net","8578 Nunc Ave","4192","Aydın"),
  ("Jenna Mcintosh","1-333-115-3226","velit.pellentesque@outlook.com","Ap #665-466 Non Avenue","81-92","Oost-Vlaanderen"),
  ("Palmer Mayo","(576) 478-3334","cum@outlook.com","8205 Natoque St.","816264","Aisén"),
  ("Miriam Burks","1-724-328-0606","est.ac.mattis@icloud.ca","341-4698 Lacus. Road","3848","Dalarnas län"),
  ("Cyrus Lowery","1-954-280-5566","enim.commodo@protonmail.net","464-2848 At, St.","27167","Ceará"),
  ("Justina Houston","(185) 428-7642","mauris.eu@google.org","P.O. Box 175, 8058 Sed Road","53038-898","Carinthia"),
  ("Dacey Knowles","(607) 487-4262","molestie.dapibus@yahoo.couk","Ap #226-7151 In Rd.","63678","Troms og Finnmark"),
  ("Camille Watkins","(514) 677-8798","velit@aol.net","P.O. Box 109, 3425 Eget Street","N2Q 5FV","Lviv oblast"),
  ("Plato Wilcox","1-961-329-9252","erat.eget@hotmail.com","Ap #234-3423 Eget St.","46063","National Capital Region"),
  ("Talon Pace","1-370-476-3732","ultricies.adipiscing@aol.ca","P.O. Box 319, 2045 Cum Road","4761-6781","Brussels Hoofdstedelijk Gewest");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Celeste Mendoza","(750) 875-8361","nulla.semper.tellus@outlook.ca","175-2577 Nibh St.","30704","Cusco"),
  ("Veda Gamble","1-815-325-3793","eget.dictum.placerat@aol.com","695-2879 Parturient Rd.","44549-441","Morelos"),
  ("Cole Christensen","(568) 986-0832","eleifend.nunc@hotmail.ca","323-3194 Erat Rd.","23954","Kogi"),
  ("Alexandra Gentry","(322) 944-5485","amet.ultricies@protonmail.org","P.O. Box 300, 2641 Vestibulum Road","Y4N 6M3","Los Ríos"),
  ("Raya Gilliam","(468) 257-5586","duis.dignissim@google.edu","150-5546 Nullam Road","857143","Victoria"),
  ("Moana Talley","(241) 236-3942","habitant@aol.couk","410-1117 Etiam Ave","433026","Upper Austria"),
  ("Bo Burks","(413) 603-0441","duis.a@outlook.couk","P.O. Box 409, 6203 Nunc Street","72-163","Baden Württemberg"),
  ("Prescott Payne","1-553-157-6867","magna@hotmail.edu","439-9360 Gravida Rd.","652295","Dalarnas län"),
  ("Gil Mclaughlin","1-148-312-0583","et.magnis@hotmail.com","171-4362 In Ave","67938","Hatay"),
  ("Kylie Dickson","(730) 569-7497","lorem@google.net","P.O. Box 185, 7417 Faucibus Avenue","32249","Baden Württemberg");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Tatum Wilkinson","(610) 352-3035","ut.molestie.in@outlook.edu","Ap #511-147 Iaculis St.","85422","Euskadi"),
  ("Farrah Hays","(448) 320-8106","sed@yahoo.couk","P.O. Box 754, 1785 Vulputate Avenue","8232","North-East Region"),
  ("Cedric Woodward","1-939-402-3405","mollis.vitae.posuere@outlook.edu","8685 Consequat, Rd.","420644","North Island"),
  ("Quintessa Guerra","1-672-367-2403","a.ultricies@aol.couk","Ap #810-224 Nec St.","4836","Chocó"),
  ("Breanna Vaughn","1-461-851-5792","nibh.enim.gravida@aol.couk","P.O. Box 923, 4872 Dis Av.","4240","Nairnshire"),
  ("Michelle Serrano","1-459-619-9630","et.tristique@google.ca","733-9914 Vitae Av.","7732","Tabasco"),
  ("Meghan Castro","(229) 404-5786","torquent.per.conubia@hotmail.couk","Ap #981-7002 Iaculis St.","L3R 7VF","Lazio"),
  ("Abraham Alexander","(543) 305-7552","mauris.a@hotmail.ca","648-6801 Praesent Rd.","432345","San José"),
  ("Diana Holcomb","1-361-304-7212","vitae.erat@hotmail.com","139-7007 Dolor Road","93885","North West"),
  ("Zahir Bradley","(564) 653-4882","eleifend.nunc@aol.edu","1365 Est St.","917042","Sikkim");
INSERT INTO `myTable` (`name`,`phone`,`email`,`address`,`postalZip`,`region`)
VALUES
  ("Phelan Hart","(266) 355-5108","tincidunt@icloud.ca","216-2638 Enim St.","64055","Pernambuco"),
  ("Suki Adams","(526) 879-0747","sed.malesuada.augue@protonmail.org","Ap #686-4140 Dui, St.","978407","Connacht"),
  ("Mira Flores","(217) 535-3119","elit.erat.vitae@outlook.ca","Ap #529-4794 Mauris Rd.","19478","Uttarakhand"),
  ("Quail Everett","1-459-729-9828","dis.parturient@yahoo.com","965-3317 Convallis Rd.","821854","Kursk Oblast"),
  ("Martena Hoffman","(622) 632-4616","sapien@icloud.net","Ap #251-5169 Justo. Avenue","12365","Konya"),
  ("Mannix Lewis","1-282-571-4200","non.vestibulum@outlook.ca","407-1623 Sit Road","644526","Oost-Vlaanderen"),
  ("Merritt Bentley","1-138-633-6664","leo@aol.couk","Ap #345-6221 Nunc. Ave","00803","Kaluga Oblast"),
  ("Lane Mccoy","1-186-413-4580","eu.eleifend@hotmail.net","Ap #728-6849 A, St.","82024","Castilla y León"),
  ("Vivian Holland","(214) 616-8865","egestas@google.ca","3783 Facilisis St.","22618","Tula Oblast"),
  ("Mark Bauer","1-512-960-5573","morbi@hotmail.org","P.O. Box 642, 9263 Ullamcorper Av.","S2E 7DV","Goiás");
  
select count(*) from mytable;
select max(id) from mytable;

-- rodar 15x
INSERT INTO `myTable`
	SELECT name, phone, email, address, postalZip, region FROM db_aula.mytable;

-- rodar 30x
INSERT INTO `myTable`
	SELECT name, phone, email, address, postalZip, region FROM db_aula.mytable limit 100000;

-- rodar 5x
INSERT INTO `myTable`
	SELECT name, phone, email, address, postalZip, region FROM db_aula.mytable limit 1000000;
    
select * from mytable -- 11.000.000 - 14.188seg