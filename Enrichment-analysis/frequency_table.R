
id_deproteins <- rownames(de_proteins)
id1 <- rownames(msdata)
id2 <- category$GeneID

unique_genes <- unique(id1, id2)
n1 <- length(unique_genes)
o <- rep(n1, each = nrow(for_graph))

freq_all <- as.data.frame(cbind(count(category, Process), o))
#row.names(freq_all) <- freq_all$Process

mt_identified <- category$GeneID %in% row.names(order_results) 
category_identified <- category[mt_identified, ]
freq_identified <- as.data.frame(count(category_identified, Process))
#row.names(freq_identified) <- freq_identified$Process

n_de1 <- length(id_deproteins)
k <- rep(n_de1, each = nrow(for_graph))

mt_DE <- category$GeneID %in% row.names(de_proteins) 
category_DE <- category[mt_DE, ]
freq_DE <- as.data.frame(cbind(count(category_DE, Process), k))

#row.names(freq_DE) <- freq_DE$Process

join_freq <- inner_join(freq_DE, freq_all, by = 'Process')
join_freq <- inner_join(join_freq, freq_identified, by = 'Process')

colnames(join_freq) <- c('Process', 'x', 'k', 'm', 'n', 'identified')

gsa_names <- join_freq[, 1]
gsa <- join_freq[ ,2:5]
row.names(gsa) <- gsa_names

for_graph <- as.data.frame(gsa)

g <- gather(for_graph, Process, value)
colnames(g) <- c('process', 'group', 'value')


