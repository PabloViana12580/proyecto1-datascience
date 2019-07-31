datos<-republica_guatemala
datos[datos == "---"] <- NA
datos[datos == "-"] <- NA
datos[datos == "--"] <- NA
View(datos)
datos<-as.factor(datos)
View(datos)
