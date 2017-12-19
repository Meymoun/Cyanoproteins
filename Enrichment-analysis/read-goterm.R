
goterm <- read.csv(file.path("input", "goterm_structure.csv"), 
                   sep = "\t", header = FALSE, stringsAsFactors = FALSE)

goterm <- goterm[ ,2:ncol(goterm)]
colnames(goterm) <- c('specie', 'id', 'goterm', 'function')

