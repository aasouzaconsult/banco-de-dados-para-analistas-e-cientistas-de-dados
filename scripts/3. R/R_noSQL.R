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