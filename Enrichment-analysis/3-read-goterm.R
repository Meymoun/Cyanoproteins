library(dplyr)
library(tidyr)

goterm <- read.csv(file.path("input", "goterm_structure.csv"), 
                   sep = "\t", header = FALSE, stringsAsFactors = FALSE)

goterm <- goterm[ ,2:ncol(goterm)]
colnames(goterm) <- c('specie', 'id', 'goterm', 'mol.function')

# select goterm info for the genes found in the experiment 
match_all <- row.names(order_results) %in% goterm$id
match_DE <- row.names(de_proteins) %in% goterm$id

sub_goterm <- goterm[match_all, ]
sub_goterm_DE <- goterm[match_DE, ]

frequency_DE <- count(sub_goterm_DE, mol.function)
f_DE <- as.data.frame(frequency_DE)