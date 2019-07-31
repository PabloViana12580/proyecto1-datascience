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

datos<-republica_guatemala
datos[datos == "---"] <- NA
datos[datos == "-"] <- NA
datos[datos == "--"] <- NA
View(datos)