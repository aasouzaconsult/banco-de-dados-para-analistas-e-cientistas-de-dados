# Banco de Dados

Um banco de dados (sua abreviatura é BD, em inglês DB, database) é uma entidade na qual é possível armazenar dados de maneira estruturada e com a menor redundância possível. Estes dados devem poder ser utilizadas por programas, por usuários diferentes. Assim, a noção básica de dados é acoplada geralmente a uma rede, a fim de poder pôr, conjuntamente, estas informações, daí o nome banco. Fala-se, geralmente, de sistema de informação para designar toda a estrutura que reúne os meios organizados para poder compartilhar dados. ([mais...](https://blogdozouza.wordpress.com/dados/estruturados/banco-de-dados/))

-----------
**Ferramentas utilizadas**
- [MySQL - Documentação](https://dev.mysql.com/doc/)
- [MySQL - Download](https://dev.mysql.com/downloads/mysql/)
- [Ambiente de BD - script](https://dev.mysql.com/downloads/mysql/)

---------------
**Atividade 1**

Necessidades do Cliente
------------------------

O cliente está realizando um estudo e gostaria que nós criássemos algumas consultas para auxiliar neste processo, consultas para responder as seguintes questões: 
Observação: não alterar nada na base de dados, apenas nas consultas mesmo! (uma consulta por questão)


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

Outras demandas do cliente:
---------------------------
- Filtrar a tabela de vendedores pelo vendedor de nome: Vendedor 6
- Uma consulta que retorno o nome dos dependentes, mas quando for o dependente de código 5, retorne o seu nome. (Usando IF ou CASE)
- Retornar todas as vendas entre os dias 07/05/2019 a 03/03/2021 unidas com as todas as vendas entre os dias 11/09/2011 a 03/09/2012
- Retornar o nome do produto (apenas os 5 primeiros caracteres) e a quantidade de venda com 10 dígitos, completando com zeros a esquerda.
- Qual o produto que tem a maior quantidade de vendas no canal: Ecommerce?
- Existiram vendas para produtos em MVP - validação? Quais foram?
- Quantas vendas encontram-se deletadas logicamente?

-----------
**Alex Souza**
- [Portfólio de Serviços](https://github.com/aasouzaconsult/Cientista-de-Dados)
- [Blog](https://blogdozouza.wordpress.com/)
- [Linkedin](https://www.linkedin.com/in/alex-souza/)
- [Instagram](https://www.instagram.com/alexsouzamsc/)
