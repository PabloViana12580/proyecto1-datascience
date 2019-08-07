"Universidad del Valle de Guatemala - Data science 1 
Catedratica: Lynette Garcia
Pablo Viana - 16091 
Sergio Marchena - 16387
Jose Martinez -  15163
Odalis Reyes - 17032
Ivan Maldonado - 17211
Mayra Silva - 17276


----------------------------------* Proyecto 1 - Data Science *----------------------------------"
#Librerias
install.packages("tidyverse")
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

datos <- transform(republica_guatemala, TELEFONO = as.list(TELEFONO))


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
#Cambiando distrito que solo tenga 01- a NA
datos$DISTRITO[datos$DISTRITO == "01-"] <- NA 
# COLUMNA SUPERVISOR
datos$SUPERVISOR[datos$SUPERVISOR == "------------------------ ---------------------------"] <- NA

#Debido a que estos datos pertenecen al sector diversificado, se cambian los NA's de la columna NIVEL a DIVERSIFICADO
datos$NIVEL[is.na(datos$NIVEL)] <- "DIVERSIFICADO"

#Corrección de palabras "AV.", "AVE", "AVE." por "AVENIDA
datos$DIRECCION <- gsub("AV|AV.|AVE.|AVAENIDA|AVENIDA"," AVE ",datos$DIRECCION)
datos$DIRECCION <- gsub("TA.|TA|RA|RA.|ERA|ERA.","",datos$DIRECCION)
datos$DIRECCION <- gsub("1A.|1A","1 ",datos$DIRECCION)
datos$DIRECCION <- gsub("2A.|2A","2 ",datos$DIRECCION)
datos$DIRECCION <- gsub("3A.|3A","3 ",datos$DIRECCION)
datos$DIRECCION <- gsub("4A.|4A","4 ",datos$DIRECCION)
datos$DIRECCION <- gsub("5A.|5A","5 ",datos$DIRECCION)
datos$DIRECCION <- gsub("6A.|6A","6 ",datos$DIRECCION)
datos$DIRECCION <- gsub("7A.|7A","7 ",datos$DIRECCION)
datos$DIRECCION <- gsub("8A.|8A","8 ",datos$DIRECCION)
datos$DIRECCION <- gsub("9A.|9A","9 ",datos$DIRECCION)
datos$DIRECCION <- gsub("10A.|10A","10 ",datos$DIRECCION)
datos$DIRECCION <- gsub("11A.|11A","11 ",datos$DIRECCION)
datos$DIRECCION <- gsub("12A.|12A","12 ",datos$DIRECCION)
datos$DIRECCION <- gsub("13A.|13A","13 ",datos$DIRECCION)
datos$DIRECCION <- gsub("14A.|14A","14 ",datos$DIRECCION)
datos$DIRECCION <- gsub("15A.|15A","15 ",datos$DIRECCION)
datos$DIRECCION <- gsub("16A.|16A","16 ",datos$DIRECCION)
datos$DIRECCION <- gsub("17A.|17A","17 ",datos$DIRECCION)
datos$DIRECCION <- gsub("18A.|18A","18 ",datos$DIRECCION)
datos$DIRECCION <- gsub("19A.|19A","19 ",datos$DIRECCION)
datos$DIRECCION <- gsub("20A.|20A","20 ",datos$DIRECCION)
datos$DIRECCION <- gsub("22A.|22A","22 ",datos$DIRECCION)
datos$DIRECCION <- gsub("23A.|23A","23 ",datos$DIRECCION)
datos$DIRECCION <- gsub("   |  "," ",datos$DIRECCION)
datos$DIRECCION <- gsub("ª", '', datos$DIRECCION)
datos$DIRECCION <- gsub("\\. "," ",datos$DIRECCION)
datos$DIRECCION <- gsub("O CALLE","0 CALLE",datos$DIRECCION)
datos$DIRECCION <- gsub(" Y "," ",datos$DIRECCION)

#Más cambios de dirección
datos$DIRECCION <- gsub("2DA","2 ",datos$DIRECCION)
datos$DIRECCION <- gsub("3a","3 ",datos$DIRECCION)
datos$DIRECCION <- gsub("10MA","10 ",datos$DIRECCION)
datos$DIRECCION <- gsub("CHUARCHO","CHUARRANCHO ",datos$DIRECCION)
datos$DIRECCION <- gsub("ASENIENTO","ASENTAMIENTO ",datos$DIRECCION)
datos$DIRECCION <- gsub("0A","0 A ",datos$DIRECCION)
datos$DIRECCION <- gsub("CABECMUNICIPAL","CABECERA MUNICIPAL ",datos$DIRECCION)
datos$DIRECCION <- gsub("CARRETA SANLUCIA COTZUMALGUAPA","CARRETERA SANTA LUCÍA COTZUMALGUAPA ",datos$DIRECCION)
datos$DIRECCION <- gsub("5CALLE","5 CALLE ",datos$DIRECCION)
datos$DIRECCION <- gsub("6CALLE","6 CALLE ",datos$DIRECCION)
datos$DIRECCION <- gsub("8VA","8 ",datos$DIRECCION)
datos$DIRECCION <- gsub("7MA","7 ",datos$DIRECCION)

#Eliminación de caracteres en la columna de establecimiento
datos$ESTABLECIMIENTO <- gsub("'", '', datos$ESTABLECIMIENTO)
datos$ESTABLECIMIENTO <- gsub("\\(POR MADUREZ\\)", '', datos$ESTABLECIMIENTO)

#Eliminacion de caracteres especificos en columna telefono 
datos$TELEFONO <- gsub("-|cel|\\.|/|,| ","",datos$TELEFONO)

#Eliminacion de caracteres especificos en columna dirección
datos$DIRECCION <- gsub(",", '', datos$DIRECCION)

#Restriccion de un solo telefono por establecimiento
datos$TELEFONO<- substr(datos$TELEFONO,1,8)

#Eliminacion de filas vacias
datos <- subset(datos, !(is.na(DISTRITO) & is.na(DEPARTAMENTO) & is.na(MUNICIPIO) & is.na(ESTABLECIMIENTO) & is.na(DIRECCION) & is.na(TELEFONO) & is.na(DIRECTOR) & is.na(NIVEL) & is.na(SECTOR) & is.na(AREA) & is.na(STATUS) & is.na(MODALIDAD) & is.na(JORNADA) & is.na(PLAN) & is.na(DEPARTAMENTAL)))

#Eliminación de filas repetidas
datos <- datos%>% distinct(DEPARTAMENTO, MUNICIPIO, ESTABLECIMIENTO, DIRECCION, STATUS, JORNADA, PLAN, .keep_all = TRUE)

# Elimina la fila que está llena de NAs
datos <- subset(datos, !(is.na(CODIGO) & is.na(DISTRITO)))
datos <- subset(datos, !(is.na(DISTRITO) & is.na(DEPARTAMENTO) & is.na(MUNICIPIO) & is.na(ESTABLECIMIENTO) & is.na(DIRECCION) & is.na(TELEFONO) & is.na(DIRECTOR) & is.na(SECTOR) & is.na(AREA) & is.na(STATUS) & is.na(MODALIDAD) & is.na(JORNADA) & is.na(PLAN) & is.na(DEPARTAMENTAL)))

View(datos)


datos$ESTABLECIMIENTO <- gsub('COLEGIO "SAN FRANCISCO JAVIER DE ZACAPA"','COLEGIO SAN FRANCISCO JAVIER DE ZACAPA',datos$ESTABLECIMIENTO)
datos$ESTABLECIMIENTO <- gsub("INSTITUTO TECNICO EDUCACIÓN INDUSTRIAL","INSTITUTO TECNICO DE EDUCACIÓN INDUSTRIAL",datos$ESTABLECIMIENTO)
datos$ESTABLECIMIENTO <- gsub('LICEO PARTICULAR MIXTO JIREH (POR MADUREZ)|LICEO PARTICULAR MIXTO "JIREH"','LICEO PARTICULAR MIXTO JIREH',datos$ESTABLECIMIENTO)
datos$ESTABLECIMIENTO <- gsub('COLEGIO "HIGA"','COLEGIO HIGA',datos$ESTABLECIMIENTO)


#EXPORTACION DE LOS DATOS LIMPIOS COMO ARCHIVO .CSV 
df <-data_frame(datos)
write_excel_csv(datos,"DatosLimpios.csv")

View(datos)



#ENCONTRAR Y COMPONER VALORES DE ESTABLECIMIENTO
View(datos[grep('INMACULADA',datos$ESTABLECIMIENTO),])
datos$ESTABLECIMIENTO <- gsub('COLEGIO "LA INMACULADA"','COLEGIO LA INMACULADA',datos$ESTABLECIMIENTO)
datos$ESTABLECIMIENTO <- gsub('COLEGIO "MARÍA INMACULADA"','COLEGIO MARÍA INMACULADA',datos$ESTABLECIMIENTO)
datos$ESTABLECIMIENTO <- gsub("LICEO 'MARIA INMACULADA'",'LICEO MARIA INMACULADA',datos$ESTABLECIMIENTO)
datos$ESTABLECIMIENTO <- gsub('COLEGIO PARTICULAR MIXTO "INMACULADA CONCEPCION"','COLEGIO PARTICULAR MIXTO INMACULADA CONCEPCION',datos$ESTABLECIMIENTO)

View(datos[grep('BLAISE PASCAL',datos$ESTABLECIMIENTO),])
datos$ESTABLECIMIENTO <- gsub('COLEGIO TECNOLÓGICO "BLAISE PASCAL"','COLEGIO TECNOLÓGICO BLAISE PASCAL',datos$ESTABLECIMIENTO)
datos$ESTABLECIMIENTO <- gsub('COLEGIO TECNOLOGICO BLAISE PASCAL','COLEGIO TECNOLÓGICO BLAISE PASCAL',datos$ESTABLECIMIENTO)

#unresolved
View(datos[grep("NUEVA GENERACION",datos$ESTABLECIMIENTO),])
datos$ESTABLECIMIENTO <- gsub("COLEGIO INTEGRAL 'NUEVA GENERACION' (POR MADUREZ)",'COLEGIO INTEGRAL NUEVA GENERACION',datos$ESTABLECIMIENTO)

View(datos[grep("EMMANUEL",datos$ESTABLECIMIENTO),])
datos$ESTABLECIMIENTO <- gsub('COLEGIO PRIVADO DE BACHILLERATO POR MADUREZ "EMMANUEL"','COLEGIO PRIVADO DE BACHILLERATO POR MADUREZ EMMANUEL',datos$ESTABLECIMIENTO)

View(datos[grep("FEDERICO CROWE",datos$ESTABLECIMIENTO),])
datos$ESTABLECIMIENTO <- gsub("INSTITUTO 'FEDERICO CROWE'","INSTITUTO FEDERICO CROWE",datos$ESTABLECIMIENTO)

View(datos[grep("YULIMAY",datos$ESTABLECIMIENTO),])
datos$ESTABLECIMIENTO <- gsub("COLEGIO BILINGUE ESPECIALIZADO EN COMPUTACION YULIMAY'PC|COLEGIO BILINGUE ESPECIALIZADO EN COMPUTACION YULIMAY PC|COELGIO BILINGUE ESPECIALIZADO EN COMPUTACION YULIMAY PC (POR MADUREZ)","COLEGIO BILINGÜE ESPECIALIZADO EN COMPUTACIÓN YULIMAY´PC",datos$ESTABLECIMIENTO)

View(datos[grep("ATENEO",datos$ESTABLECIMIENTO),])
datos$ESTABLECIMIENTO <- gsub(grep("COLEGIO MIXTO 'EL ATENEO'\\(POR MADUREZ)",datos$ESTABLECIMIENTO),'COLEGIO MIXTO EL ATENEO',datos$ESTABLECIMIENTO)









