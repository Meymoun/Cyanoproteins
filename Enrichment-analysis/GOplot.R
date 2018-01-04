
#install.packages("GOplot")
library(GOplot)
library(dplyr)
library(gtools)

results2 <- cbind(id = row.names(results), results)

#goterm

category_process <- select(category, id = GeneID, Pathway)

df_goterm <- inner_join(results2, goterm, by = 'id')
df_goterm2 <- inner_join(df_goterm, category_process, by = 'id')

goterm_and_q <- df_goterm2 %>%
  select(id, q.value, mol.function, Pathway)

de_goterm <- goterm_and_q[goterm_and_q$q.value < 0.05, ]

de_go <- count(de_goterm, Pathway)
go <- count(goterm_and_q, Pathway)

sum(de_go$n)
sum(go$n)


d <- inner_join(de_go, go, by = "Pathway")

d1 <- cbind(d, rep(sum(go$n), each = nrow(d)),
            rep(sum(de_go$n), each = nrow(d)))


colnames(d1) <- c('pathway', 'x', 'm', 'n', 'k')

d2 <- select(d1, x, m, n, k)
row.names(d2) <- d1$pathway

  
go_pvals <- apply(d2, 1, function(row) phyper(row[1], row[2], row[3], row[4], 
                                             lower.tail = FALSE, log.p = FALSE)) # default, test depletion

go_qvals <- p.adjust(go_pvals, 'fdr')
d3 <- cbind(d2, go_pvals, go_qvals)

# empty name, rename to "unknown"
row.names(d3)[1] <- "Unknown"

fc <- apply(d3, 1, function(row) foldchange(row[1]/row[4], 
                                            row[2]/row[3]))

d3 <- cbind(d3, fc)
