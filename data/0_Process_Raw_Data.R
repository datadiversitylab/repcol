library(here)
library(data.table)
library(RCurl)

##Generar dataset anonimo
targetFiles <- list.files(here("Data"), pattern = "Scielo", full.names = TRUE)
namesFiles <- list.files(here("Data"), pattern = "Scielo")
datasets <- lapply(targetFiles, read.csv)
names(datasets) <- namesFiles
condensedDataset <- rbindlist(datasets, idcol = "Dataset")
annonDataset <- condensedDataset[,c(1, 6, 8, 10:27)]

annonDataset <- annonDataset[sample(nrow(annonDataset)),]
write.csv(annonDataset, here("Data", "Dataset.csv"))



##Descargar todos los papers al repo

lapply(1:nrow(condensedDataset), function(x){
  tryCatch({
    if(grepl("Filogen", condensedDataset$Dataset[x])){
      
      download.file(condensedDataset$Fulltext.URL[x], 
                    destfile = here("Data", "Papers", "Filogenetica" , paste0(condensedDataset$ID[x], ".html")), 
                    method="libcurl")
    }else{
      download.file(condensedDataset$Fulltext.URL[x], 
                    destfile = here("Data", "Papers", "Ecologia" , paste0(condensedDataset$ID[x], ".html")), 
                    method="libcurl")
    }
  }, error=function(e){})
})

## Descargar citas

pid = gsub(".*pid=","", condensedDataset$Fulltext.URL)
pid =gsub("&.*","",pid)

lapply(seq_along(pid), function(x){
  download.file(paste0('http://www.scielo.org.co/scielo.php?download&format=BibTex&pid=', pid[x]), 
                destfile = here("Data", "Papers", "Citas" , paste0(pid[x], ".bib")), 
                method="libcurl")
})

## Concatenar las citas

list_files<- list.files(here("Data", "Papers", "Citas"), pattern = "\\.bib$", full.names = TRUE)
read_files <- unlist(lapply(list_files, readLines))
write(read_files, file = here("Data", "Citas", "Analyzed.Bib"))




