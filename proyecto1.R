"Universidad del Valle de Guatemala - Data science 1 
Catedratica: Lynette Garcia
Pablo Viana - 16091 
Sergio Marchena - 16387
Jose Martinez -  
Odalis Reyes - 17032
Ivan Maldonado - 
Mayra Silva - 


----------------------------------* Proyecto 1 - Data Science *----------------------------------"

#Para hacer esto tienen que bajar el archivo del drive, y setear su working directory a donde guardaron el archivo RData
load("republica_guatemala.RData")

#Cambiar datos que tengan guiones por NA
datos<-republica_guatemala

# Unificar las etiquetas
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
datos[datos == 0] <- NA

#Cambio de tipo de columna de char a factor
datos_transformados <- transform(datos, DEPARTAMENTO = as.factor(DEPARTAMENTO),
                                 MUNICIPIO = as.factor(MUNICIPIO),
                                 NIVEL = as.factor(NIVEL),
                                 SECTOR = as.factor(SECTOR),
                                 AREA = as.factor(AREA),
                                 STATUS = as.factor(STATUS),
                                 JORNADA = as.factor(JORNADA),
                                 TELEFONO = as.factor(TELEFONO),
                                 PLAN = as.factor(PLAN))
View(datos_transformados)

#Eliminacion de filas vacias
datos <- subset(datos_transformados, !(is.na(DISTRITO) & is.na(DEPARTAMENTO) & is.na(MUNICIPIO) & is.na(ESTABLECIMIENTO) & is.na(DIRECCION) & is.na(TELEFONO) & is.na(DIRECTOR) & is.na(NIVEL) & is.na(SECTOR) & is.na(AREA) & is.na(STATUS) & is.na(MODALIDAD) & is.na(JORNADA) & is.na(PLAN) & is.na(DEPARTAMENTAL)))

