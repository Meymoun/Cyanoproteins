library(dplyr)
library(tidyr)

## all genes
id1 <- rownames(msdata)
id2 <- category$GeneID

unique_genes <- unique(id1, id2)

# count all genes and prepare for hypergeometric test
n1 <- length(unique_genes)
o <- rep(n1, each = 17)

freq_all <- as.data.frame(cbind(count(category, Process), o))
#freq_all <- as.data.frame(cbind(count(category, Pathway), o))

# for all genes from the experiment
mt_identified <- category$GeneID %in% row.names(order_results) 
category_identified <- category[mt_identified, ]

# for hypergeometric test
ni = nrow(category_identified)
m <- rep(ni, each = 17) 

freq_identified <- as.data.frame(cbind(count(category_identified, Process), m))
#freq_identified <- as.data.frame(cbind(count(category_identified, Pathway), m))

# for the DE genes from the experiment
id_deproteins <- rownames(de_proteins)
n_de1 <- length(id_deproteins)
k <- rep(n_de1, each = 17)

mt_DE <- category$GeneID %in% row.names(de_proteins) 
category_DE <- category[mt_DE, ]
freq_DE <- as.data.frame(cbind(count(category_DE, Process), k))
#freq_DE <- as.data.frame(cbind(count(category_DE, Pathway), k))

join_freq <- inner_join(freq_DE, freq_all, by = 'Process')
join_freq <- inner_join(join_freq, freq_identified, by = 'Process')
#join_freq <- inner_join(freq_DE, freq_all, by = 'Pathway')
#join_freq <- inner_join(join_freq, freq_identified, by = 'Pathway')

colnames(join_freq) <- c('process', 'x', 'k', 'm', 'n', 'i', 'ni')

ea_names <- join_freq[, 1]
enrichment_analysis <- join_freq[ ,2:7]
row.names(enrichment_analysis) <- ea_names

# arrange the data for the barplot
for_graph <- select(join_freq, process, i, m, x)

bp <- for_graph %>%
  arrange(x) %>%
  gather(process, value)

colnames(bp) <- c('process', 'group', 'value')