library(dplyr)
library(tidyr)

goterm <- read.csv(file.path("input", "goterm_structure.csv"), 
                   sep = "\t", header = FALSE, stringsAsFactors = FALSE)

goterm <- goterm[ ,2:ncol(goterm)]
colnames(goterm) <- c('specie', 'id', 'goterm', 'mol.function')
new_goterm <- goterm %>%
  separate(mol.function, into = c('mol.function', 'GO'), sep = "GO:") %>%
  select(-specie, -goterm)

gt <- as.data.frame(goterm) %>%
  mutate(mid = 1:n()) %>%
  group_by(id) %>%
  spread(id, mol.function) %>%
  select(-specie, -goterm, -mid)

#sel <- lapply(gt[ , 1:4],function(x) x[!is.na(x)])

#l <- as.data.frame(t(sel), check.names = FALSE)

#unlist(l$sll0002[1])

subgo1 <- subgo %>%
  arrange(mol.function) %>%
  #separate(mol.function, into = c('mol.function', 'GO'), sep = "\\(GO:") %>%
  select(-specie, -goterm)


mt <- row.names(order_results) %in% goterm$id
mt_DE <- row.names(de_proteins) %in% goterm$id


subgo <- goterm[mt, ]
subgo_DE <- goterm[mt_DE, ]


# 931 
#subgo1 <- as.data.frame(apply(subgo1, 2, function(x) gsub("\\)", "", x)))

#factor(subgo1$GO, levels = unique(subgo1$GO))

#frequency <- count(subgo, mol.function)
frequency_DE <- count(subgo_DE, mol.function)

#f_identified_proteins <- as.data.frame(frequency)
f_DE <- as.data.frame(frequency_DE)


