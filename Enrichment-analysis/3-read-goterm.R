
library(dplyr)
library(tidyr)

goterm <- read.csv(file.path("input", "goterm_structure.csv"), 
                   sep = "\t", header = FALSE, stringsAsFactors = FALSE)

goterm <- goterm[ ,2:ncol(goterm)]
colnames(goterm) <- c('specie', 'id', 'goterm', 'mol.function')

#subgo1 <- subgo %>%
  #arrange(mol.function) %>%
  #separate(mol.function, into = c('mol.function', 'GO'), sep = "\\(GO:") %>%
  #select(-specie, -goterm)

mt <- row.names(order_results) %in% goterm$id
mt_DE <- row.names(de_proteins) %in% goterm$id

subgo <- goterm[mt, ]
subgo_DE <- goterm[mt_DE, ]

frequency_DE <- count(subgo_DE, mol.function)
f_DE <- as.data.frame(frequency_DE)


