## Leer los datos
data <- read.csv("data/Dataset.csv")

## Numero de publicaciones por tema
table(data$Dataset)

## Numero de publicaciones de año
table(data$Publication.year)

## Numero de publicaciones por revista en cada tema
table(data[data$Dataset == "Scielo_Ecologia.csv", "Journal"]) 
table(data[data$Dataset == "Scielo_Filogen.csv", "Journal"]) 

## Revisar la frecuencia de uso de herramientas por campo y general

eco <- data[data$Dataset == "Scielo_Ecologia.csv",]
lapply(eco, function(x) table(x)/nrow(eco))
lapply(eco, table)

evo <- data[data$Dataset == "Scielo_Filogen.csv",]
lapply(evo, function(x) table(x)/nrow(evo))
lapply(evo, table)

lapply(data, function(x) table(x)/nrow(data))
lapply(data, table)











