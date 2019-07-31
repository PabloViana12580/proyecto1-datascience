"Universidad del Valle de Guatemala - Data science 1 
Catedratica: Lynette Garcia
Pablo Viana - 16091 
Sergio Marchena - 16387
Jose Martinez -  
Odalis Reyes -
Ivan Maldonado - 
Mayra Silva - 


----------------------------------* Proyecto 1 - Data Science *----------------------------------"
#Para hacer esto tienen que bajar el archivo del drive, y setear su working directory a donde guardaron el archivo RData
load("republica_guatemala.RData")

#Cambiar republica_guatemala que tengan guiones por NA
republica_guatemala[republica_guatemala == "---"] <- NA
republica_guatemala[republica_guatemala == "-"] <- NA
republica_guatemala[republica_guatemala == "--"] <- NA

#Cambio de tipo de columna de char a factor
datos_transformados <- transform(republica_guatemala, DEPARTAMENTO = as.factor(DEPARTAMENTO),
                                 MUNICIPIO = as.factor(MUNICIPIO),
                                 NIVEL = as.factor(NIVEL),
                                 SECTOR = as.factor(SECTOR),
                                 AREA = as.factor(AREA),
                                 STATUS = as.factor(STATUS),
                                 JORNADA = as.factor(JORNADA),
                                 PLAN = as.factor(PLAN))

#Eliminacion de caracteres especificos en columna telefono 
datos_transformados$TELEFONO <- gsub("-|y|,| ","",datos_transformados$TELEFONO)

