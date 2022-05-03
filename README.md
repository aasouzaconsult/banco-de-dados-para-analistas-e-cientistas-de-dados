# Banco de Dados

Um banco de dados (sua abreviatura é BD, em inglês DB, database) é uma entidade na qual é possível armazenar dados de maneira estruturada e com a menor redundância possível. Estes dados devem poder ser utilizados por programas e por diferentes tipos de usuários (usuários finais, analistas, cientistas, etc). Assim, a noção básica de dados é acoplada geralmente a uma rede, a fim de poder pôr, conjuntamente, estas informações, daí o nome banco. Fala-se, geralmente, de sistema de informação para designar toda a estrutura que reúne os meios organizados para poder compartilhar dados. ([mais...](https://blogdozouza.wordpress.com/dados/estruturados/banco-de-dados/))

# SQL
Essa habilidade consiste na capacidade de consultar dados contidos em tabelas (não apenas em tabelas) nas mais diversas Fontes de Dados ([consulte na seção Classificação de dados (Data Classification)](https://medium.com/blog-do-zouza/dos-dados-at%C3%A9-a-tomada-de-decis%C3%A3o-534f61abd3cb)). Em grande parte das vezes, estas consultas, buscam atender alguma necessidade do negócio, da empresa na qual esta trabalhando!
Normalmente utilizando a linguagem padrão SQL (Structured Query Language). A Linguagem SQL, é subdivida em alguns tipos de linguagem, são elas:
- **DDL (Data Definition Language)** — principais comandos: CREATE DATABASE | DROP DATABASE | ALTER DATABASE | CREATE TABLE | ALTER TABLE | DROP TABLE | TRUNCATE | RENAME
- **DML (Data Manipulation Language)** — principais comandos: INSERT | UPDATE | DELETE
- **DCL (Data Control Language)** — principais comandos: GRANT | REVOKE
- **TCL (Transaction Control Language)** — principais comandos: ROLLBACK | COMMIT | SAVE POINT
- **DQL (Data Query Language)** — principais comandos: SELECT (esse aqui será nosso foco) — observação, na literatura também pode ser que encontrem comandos SELECT dentro de DML. ([mais...](https://medium.com/@aasouzaconsult/sql-para-an%C3%A1lise-de-dados-2183f746f2e1))

# Ferramentas utilizadas
- [MySQL - Documentação](https://dev.mysql.com/doc/)
- [MySQL - Download](https://dev.mysql.com/downloads/mysql/)
- [MySQL - Instalação Passo a Passo](https://dicasdeprogramacao.com.br/como-instalar-o-mysql-no-windows/)
- [MySQL - Executar comandos de exemplo direto no navegador](https://www.w3schools.com/mysql/mysql_examples.asp)
- [Modelagem do BD](https://github.com/aasouzaconsult/banco-de-dados-para-analistas-e-cientistas-de-dados/blob/main/sales.z/1.%20Modelagem_BD_ERP.png)
- [Ambiente de BD - script](https://github.com/aasouzaconsult/banco-de-dados-para-analistas-e-cientistas-de-dados/blob/main/sales.z/1.%20Script_Criacao_BD_ERP.sql)

# Projeto

**Análise de Dados utilizando SQL**
-----------------------------------
Somos a empresa: *data.z - consultoria em dados*

A empresa **sales.z** nos contratou para realizarmos uma consultoria em seus dados de venda. Nos passaram um [banco de dados de amostra](https://github.com/aasouzaconsult/banco-de-dados-para-analistas-e-cientistas-de-dados/blob/main/sales.z/1.%20Script_Criacao_BD_ERP.sql) e como sua [modelagem relacional](https://github.com/aasouzaconsult/banco-de-dados-para-analistas-e-cientistas-de-dados/blob/main/sales.z/1.%20Modelagem_BD_ERP.png), contendo alguns dados fictícios, mas que obedece a estrutura real do banco de dados deles em produção.

Nos informaram por e-mail, que estão realizando um estudo e gostaria que nós criássemos algumas consultas para auxiliar neste processo, consultas para responder as seguintes questões: 

*Observação 1: não alterar nada na base de dados, apenas nas consultas mesmo! (uma consulta por questão)*

*Observação 2: qualquer dúvida, pode procurar diretamente o cliente - Alex Souza*

Fase 1:
-------
- Quantidade de dependentes
- Quantidade de dependentes por sexo
- Quantidade de clientes da região sul
- Uma descrição breve dos produtos da empresa (codigo, nome, tipo)
- Quais os 5 produtos mais vendidos de 2021?
- Nome, Nome em Maiúsculo e Nome em Minúsculo, dos vendedores do sexo feminino
- Nome e idade de todos os dependentes, ordenados do mais velho para o mais novo
- Somatório do Valor Total de Vendas (concluídas e não deletadas) por Estado
- Somatório de Unidades Vendidas (concluídas e não deletadas) por Produto
- Média do Valor Total de Vendas por Estado
- Nome dos clientes que compram o produto 1
- Quantidade mínima e qual o respectivo produto
- Uma descrição detalhada dos produtos da empresa (codigo, nome, tipo, Qtd em Estoque)
- Nome dos Vendedores que realizaram determinadas Vendas (Codigo da Venda, Data da Venda, Produto e nome do vendedor)
- Relação com o nome dos vendedores e seus respectivos filhos (dependentes - nome e data de nascimento) -- montar uma view com estes dados
- Criar uma view com informações de vendas, produto, estoque, cliente, vendedores (apenas concluídas e não deletadas)
- View de quantidade de vendas por canal

Fase 2:
-------
- Filtrar a tabela de vendedores pelo vendedor de nome: Vendedor 6
- Uma consulta que retorno o nome dos dependentes, mas quando for o dependente de código 5, retorne o seu nome. (Usando IF ou CASE)
- Retornar todas as vendas entre os dias 07/05/2019 a 03/03/2021 unidas com as todas as vendas entre os dias 11/09/2011 a 03/09/2012
- Retornar o nome do produto (apenas os 5 primeiros caracteres) e a quantidade de venda com 10 dígitos, completando com zeros a esquerda.
- Qual o produto que tem a maior quantidade de vendas no canal: Ecommerce?
- Existiram vendas para produtos em MVP - validação? Quais foram?
- Quantas vendas encontram-se deletadas logicamente?
- Quantas vendas encontram-se canceladas?
- Na tabela de dependentes, temos o código da Escola que o dependente estuda, precisamos além do códido da escola (INEP), saber o nome da escola de cada um dos dependentes estudam. (planilha com nome da escola em [anexo](https://github.com/aasouzaconsult/banco-de-dados-para-analistas-e-cientistas-de-dados/blob/main/sales.z/Censo2020_inep.csv))

Entrega do Projeto para o cliente:
----------------------------------
A entrega do projeto para o cliente fica a seu critério, normalmente aqui na *data.z* utilizamos o [GitHub](https://github.com/aasouzaconsult/banco-de-dados-para-analistas-e-cientistas-de-dados/blob/main/sales.z/modelo_doc.md) para documentar nossas entregas, mas fique a vontade para utilizar a ferramenta que mais tem familiaridade.

**Data**: *08/05/2022 até as 23:59hs*

-----------
**Alex Souza**
- [Portfólio de Serviços](https://github.com/aasouzaconsult/Cientista-de-Dados)
- [Blog](https://medium.com/blog-do-zouza)
- [Linkedin](https://www.linkedin.com/in/alex-souza/)
- [Instagram](https://www.instagram.com/alexsouzamsc/)

------
![github-contribution-grid-snake](https://user-images.githubusercontent.com/29084827/164712340-6b03015f-a428-4731-b1b9-a5605de203b2.svg)
