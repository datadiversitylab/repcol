library(RefManageR)
titles <- c("A Beginner's Guide to Conducting Reproducible Research")
citations <- lapply(titles, ReadCrossRef, limit = 1)
lapply(citations, 
       WriteBib, 
       file = here("Data", "Citas", "MainText.Bib"), 
       append = TRUE)