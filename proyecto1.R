"Universidad del Valle de Guatemala - Data science 1 
Catedratica: Lynette Garcia
Pablo Viana - 16091 
Sergio Marchena - 16387
Jose Martinez -  
Odalis Reyes - 17032
Ivan Maldonado - 17211
Mayra Silva - 17276
Mayra Silva - 

----------------------------------* Proyecto 1 - Data Science *----------------------------------"
#Librerias
library(tidyverse)

#cargamos archivo RData
load("republica_guatemala.RData")


#Asignamos a la variable datos el data.frame de republica_guatemala
datos<-republica_guatemala

#Cambio de tipo de columna, de char a factor
datos <- transform(republica_guatemala, DEPARTAMENTO = as.factor(DEPARTAMENTO),
                   MODALIDAD = as.factor(MODALIDAD),
                   MUNICIPIO = as.factor(MUNICIPIO),
                   NIVEL = as.factor(NIVEL),
                   SECTOR = as.factor(SECTOR),
                   AREA = as.factor(AREA),
                   STATUS = as.factor(STATUS),
                   JORNADA = as.factor(JORNADA),
                   DISTRITO = as.factor(DISTRITO),
                   PLAN = as.factor(PLAN))

# Unificar las etiquetas
#Cambiamos todos los datos que representen ausencia de informacion por NA 
datos[datos == "---+"] <- NA
datos[datos == "."] <- NA
datos[datos == 0] <- NA
datos[datos == "---"] <- NA
datos[datos == "0"] <- NA
datos[datos == "-"] <- NA
datos[datos == "--"] <- NA
datos[datos == "---"] <- NA
datos[datos == "----"] <- NA
datos[datos == "-----"] <- NA
datos[datos == "------"] <- NA
datos[datos == "-------"] <- NA
datos[datos == "--------"] <- NA
datos[datos == "---------"] <- NA
datos[datos == "----------"] <- NA
datos[datos == "-----------"] <- NA
datos[datos == "------------"] <- NA
datos[datos == "-------------"] <- NA
datos[datos == "--------------"] <- NA
datos[datos == "-----------------"] <- NA
datos[datos == "---------------------"] <- NA
datos[datos == "--------------------"] <- NA
datos$DIRECTOR[datos$DIRECTOR == "-----------------------------"] <- NA
datos$DISTRITO[datos$DISTRITO == "01-"] <- NA #Cambiando distrito que solo tenga 01- a NA
# COLUMNA SUPERVISOR
datos$SUPERVISOR[datos$SUPERVISOR == "------------------------ ---------------------------"] <- NA

#Debido a que estos datos pertenecen al sector diversificado, se cambian los NA's de la columna NIVEL a DIVERSIFICADO
datos$NIVEL[is.na(datos$NIVEL)] <- "DIVERSIFICADO"

#Eliminacion de caracteres especificos en columna telefono 
datos$TELEFONO <- gsub("-|cel|\\.|/|,| ","",datos$TELEFONO)
#Restriccion de un solo telefono por establecimiento
datos$TELEFONO[nchar(datos$TELEFONO) > 8] <- NA

#Eliminacion de filas vacias
datos <- subset(datos, !(is.na(DISTRITO) & is.na(DEPARTAMENTO) & is.na(MUNICIPIO) & is.na(ESTABLECIMIENTO) & is.na(DIRECCION) & is.na(TELEFONO) & is.na(DIRECTOR) & is.na(NIVEL) & is.na(SECTOR) & is.na(AREA) & is.na(STATUS) & is.na(MODALIDAD) & is.na(JORNADA) & is.na(PLAN) & is.na(DEPARTAMENTAL)))

#Eliminación de filas repetidas
datos <- datos%>% distinct(DEPARTAMENTO, MUNICIPIO, ESTABLECIMIENTO, DIRECCION, STATUS, JORNADA, PLAN, .keep_all = TRUE)


