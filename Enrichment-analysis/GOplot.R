library(GOplot)
library(dplyr)
library(gtools)
library(mosaic)

results2 <- cbind(id = row.names(results), results)


category_process <- select(category, id = GeneID, Pathway, Process)

df_goterm <- inner_join(results2, goterm, by = 'id')
df_goterm2 <- inner_join(df_goterm, category_process, by = 'id')

goterm_and_q <- df_goterm2 %>%
  select(id, q.value, mol.function, Pathway)

de_goterm <- goterm_and_q[goterm_and_q$q.value < 0.05, ]

de_go <- count(de_goterm, Pathway)
go <- count(goterm_and_q, Pathway)

sum(de_go$n)
sum(go$n)

#g <- goterm_and_q()

d <- inner_join(de_go, go, by = "Pathway")
#d <- inner_join(d, goterm_and_q, by = "Process")

d1 <- cbind(d, rep(sum(go$n), each = nrow(d)),
            rep(sum(de_go$n), each = nrow(d)))


colnames(d1) <- c('id', 'x', 'm', 'n', 'k')

d2 <- select(d1, x, m, n, k)
row.names(d2) <- d1$id

#x1 <- apply(d2, 1, function(row) log2(row[1]))
#m1 <- apply(d2, 1, function(row) log2(row[2]))
#n1 <- apply(d2, 1, function(row) log2(row[3]))
#k1 <- apply(d2, 1, function(row) log2(row[4]))

#d4 <- cbind(x1, m1, n1, k1)
#row.names(d4) <- row.names(d2)

#options(digits = 10)

go_pvals <- apply(d2, 1, function(row) phyper(row[1]-1, row[2], row[3], row[4], 
                                             lower.tail = FALSE, log.p = FALSE)) # default, test depletion


go_qvals <- p.adjust(go_pvals, 'fdr')
d3 <- cbind(d2, go_pvals, go_qvals)

fc <- apply(d3, 1, function(row) foldchange(row[1]/row[4], 
                                            row[2]/row[3]))


d3 <- cbind(d3, fc)

zscores <- zscore(d3$fc)

# negative logarithm of q value at y axis
# z score at x axis

log <- -log2(d3$go_qvals)

gobubble <- as.data.frame(cbind(category = 1:nrow(d3), id = 1:nrow(d3), term = row.names(d3), 
                                q = log, zscore = zscores, count = nrow(d3)))





