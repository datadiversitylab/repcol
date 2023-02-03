library(ggplot2)
library(tidytext)

## Leer los datos
data <- read.csv("data/Dataset.csv")

data$How.is.data.available.[data$How.is.data.available. == "In text (Figure of a Table)"] <- "In text"
data$How.is.data.available.[data$How.is.data.available. == "In supplement"] <- "Supplement"
data$How.is.data.available.[data$How.is.data.available. == "Sequences are in a table"] <- "In text"



eco <- data[data$Dataset == "Scielo_Ecologia.csv",]
evo <- data[data$Dataset == "Scielo_Filogen.csv",]


ds <- rbind(
data.frame(ds = "Ecology", table(eco$How.is.data.available.)),
data.frame(ds = "Evolution",table(evo$How.is.data.available.)),
data.frame(ds = "Total",table(data$How.is.data.available.))
)

ggplot(data=ds, aes(x=reorder_within(Var1, -Freq, ds), y=Freq, fill = ds)) +
  geom_bar(stat="identity")+
  theme_minimal() + 
  facet_grid(~ ds, space = "free", scales = "free")


