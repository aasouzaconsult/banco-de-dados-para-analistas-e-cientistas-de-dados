# pacotes
install.packages("RMySQL"); 
library(DBI)
library(RMySQL)

# drive e conexão
drv <- dbDriver("MySQL")
con <- dbConnect(drv, username="root", password="Abcd1234", dbname ="db_aula", host='127.0.0.1')

# Listar as tabelas
dbListTables(con)

# Listando as colunas de uma tabela
dbListFields(con, 'tbproduto')

# Comando SELECT
query_sql = dbSendQuery(con, "SELECT * FROM tbproduto where cdPro < 8;")

#query_sql = dbSendQuery(con, "select * from vwvendas_resumida;")

#query_sql = dbSendQuery(con, "select *
#                                from tbvendas  ven
#                                join tbcliente cli on cli.cdCli = ven.cdCli
#                                join tbproduto pro on pro.cdPro = ven.cdPro;")

lista = fetch(query_sql, n=-1)

# Vendo o resultado 
df = data.frame(lista)

# comandos R
colnames(df)

# Somatorio de valores unitarios
sum(df$vrUni)

#desconecta da base
dbDisconnect(con)

# mais um teste
# -------------
drv <- dbDriver("MySQL")
con <- dbConnect(drv, username="root", password="Abcd1234", dbname ="db_aula", host='127.0.0.1')

query_sql = dbSendQuery(con, "SELECT * FROM tbdependente;")

lista = fetch(query_sql, n=-1)

dep = data.frame(lista)

subset(dep, sexoDependente == "F")

##############
## MONGO DB ##
##############
install.packages("mongolite")

library(mongolite)

connection_string = 'mongodb://localhost'

cli <- mongo("tbcliente")

alldata <- cli$find('{}')

print(alldata)

# Filtrando (>=) 
clifil <- cli$find('{"dscpf" : { "$gte" : 11111111112 } }')
print(clifil)

# mais sobre R
# https://analisereal.com/2017/02/07/data-frames/
# https://ycaro.net/2019/04/conectar-no-banco-de-dados-mysql-pela/
# https://stackoverflow.com/questions/54099722/how-to-connect-r-to-mysql-failed-to-connect-to-database-error-plugin-caching/54101124