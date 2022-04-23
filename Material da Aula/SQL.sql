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
 where cdPro = 8; -- Muito importante

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

select * from tbvendedor;

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
-- sempre procure ser o mais específico possível, evite o *
select * from tbproduto;

-- ----------------------------------------------
-- distinct (retorna apenas tuplas não repetidas)
-- ----------------------------------------------
-- Estados da tabela de cliente
select Estado from tbcliente;
select distinct Estado from tbcliente;

-- ---------------------------------------------
-- as (alias, dar nomes a atributos e entidades)
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
-- Converter dados (cast ou converter)
-- -----------------------------------
-- Converter o CPF do cliente para texto (apenas na consulta)
select dsCPF from tbcliente;

select dsCPF
     , cast(dsCPF as char) CPF
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
-- INTERSECT ALL - Interseção entre duas relações - Com repetiçõe
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
     , count(*) as qtd
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
having sum(qtPro) > 20;

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
select upper(estado) from tbcliente;

-- -------------------------------------
-- lower (deixa o atributo em minúsculo)
-- -------------------------------------
select lower(estado) from tbcliente;

-- -------------------------------------------
-- ltrim (remove espaço em branco a esquerda)
-- -------------------------------------------
select nmPro, length(nmPro) from tbproduto;
select ltrim(nmPro), length(ltrim(nmPro)) from tbproduto;

-- ------------------------------------------
-- rtrim (remove espaço em branco a direita)
-- ------------------------------------------
select nmPro, length(nmPro) from tbproduto;
select rtrim(nmPro), length(rtrim(nmPro)) from tbproduto;

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
select substring(nmPro, 1, 5) as nome_reduzido from tbproduto;

-- ---------------------------------------
-- replace (substituir um texto por outro)
-- ---------------------------------------
-- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_replace
select nmPro from tbproduto;
select replace(nmPro, 'Produto', 'Produtos') as nome_plural from tbproduto;

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
     , right(nmPro, 2)
     , left(nmPro, 4)
  from tbproduto;

-- --------------------------------------
-- lpad (ou o replicate de outros sgbds)
-- --------------------------------------
-- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_lpad
-- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_rpad

-- O código do produto deve ter 3 digitos (zeros a esquerda), exemplo: 1 seria 001 e assim por diante
select cdPro
  -- , lpad(cdPro, 3, 0) CodigoProduto
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

select *
  from       tbvendas ven
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
  right join tbproduto pro on pro.cdPro = ven.cdPro;

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
-- Subconsultas
-- ************
select *
     , (select nmPro from tbproduto where cdpro = ven.cdPro) as produto
  from tbvendas                                             ven
  join (select cdPro, nmPro from tbproduto where cdPro >= 2) pro on pro.cdPro = ven.cdPro;

-- *****
-- Views
-- *****
-- Gera uma visualização com base em uma consulta 
-- Muita vezes utilizada para restringir o acesso a determinados atributos
select * from tbvendas;
select * from tbcliente;
select * from tbproduto;

-- Um determinado usuário precisa da data de venda, nome do cliente e o nome do produto vendido
create or replace view vwvendas_resumida as
select ven.dtVen as Data
     , cli.nmCli as Cliente
     , pro.nmPro as Produto
  from tbvendas  ven
  join tbcliente cli on cli.cdCli = ven.cdCli
  join tbproduto pro on pro.cdPro = ven.cdPro;

-- consultando
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
select vnd.nomeVendedor
     , dep.nomeDependente
     , dep.sexoDependente
     , case when dep.sexoDependente = 'F' then 'bola B'
       else 'bola A' end   as Brinde
  from tbdependente dep
  join tbvendedor   vnd on vnd.cdvendedor = dep.cdvendedor;

-- IFNULL
SELECT IFNULL(NULL,10) as exemplo;

-- **********************************************
-- Relacionamento entre bancos de dados distintos
-- **********************************************
-- Enriquecimento de dados
select * from censo2020.escolas;

select dep.*
     , esc.*
  from db_aula.tbdependente dep
  join censo2020.escolas    esc on esc.CO_ENTIDADE = dep.inepescola;

-- #############
-- Boas práticas
-- #############
-- Utizem comentários (https://dev.mysql.com/doc/refman/8.0/en/comments.html)
-- Indentação
-- Escrita limpa
-- Padronização
-- Evite o * no select