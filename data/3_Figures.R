library(ggplot2)
library(tidyr)
library(tidytext)
library(ggthemr)

## Leer los datos
data <- read.csv("data/Dataset.csv")

data$How.is.data.available.[data$How.is.data.available. == "In text (Figure of a Table)"] <- "In text"
data$How.is.data.available.[data$How.is.data.available. == "In supplement"] <- "Supplement"
data$How.is.data.available.[data$How.is.data.available. == "Sequences are in a table"] <- "In text"

data$How.is.data.available.[data$How.is.data.available. == "In text"] <- "Texto principal"
data$How.is.data.available.[data$How.is.data.available. == "Supplement"] <- "Supplemento"
data$How.is.data.available.[data$How.is.data.available. == "No"] <- "No disponibles"


eco <- data[data$Dataset == "Scielo_Ecologia.csv",]
evo <- data[data$Dataset == "Scielo_Filogen.csv",]


sumds <- rbind(
data.frame(ds = "Ecología", table(eco$How.is.data.available.)),
data.frame(ds = "Evolución",table(evo$How.is.data.available.)),
data.frame(ds = "Total",table(data$How.is.data.available.))
)

sumds <- with(sumds, sumds[order(ds, -Freq),])

sumds <- sumds %>%  group_by(ds) %>% 
  mutate(perc=100*Freq/sum(Freq))

ggthemr('light')

ggplot(sumds, aes(reorder_within(Var1, perc, ds), perc, fill = ds)) +
  geom_hline(yintercept=50, color = "grey", linetype = "dashed") +
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_x_reordered() +
  facet_grid(ds ~., scales = "free")+ 
  theme(text = element_text(size=15)) +
  xlab("Disponibilidad de datos") +
  ylab("Porcentaje de publicaciones")+ 
  theme(legend.position = "none") +
  theme(plot.background = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank())+
  theme(axis.text.x=element_text(colour="black"),
        axis.text.y=element_text(colour="black"),
        text=element_text(color="black")) +
  theme(strip.text = element_text(colour = 'black'),
        axis.ticks = element_line(color = "black"))

ggsave("data/mainFig.pdf", width = 8, height = 5)
ggsave("data/mainFig.png", width = 8, height = 5)

  




