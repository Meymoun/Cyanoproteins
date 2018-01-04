
library(dplyr)
library(tidyr)

groups <- strsplit(colnames(msdata), split = '_')
condition <- sapply(groups, function(x) x[1])

ht_anova <- function(protein) {

  tidy <- gather(as.data.frame(protein), group, intensity)
  tidy$group <- condition
  
  tidy$group = factor(tidy$group,
                         labels = c('X60', 'X100', 'X200', 'X300', 'X1000'))

  statistics <- anova(lm(intensity ~ group, data = tidy))
  result <- c(statistics$`F value`[1], statistics$`Pr(>F)`[1])

  return (result)
  
  }

# loops through the rows in msdata (for each protein, execute function ht_anova)
ht_anova_result <- apply(msdata, 1, ht_anova)

results <- as.data.frame(t(ht_anova_result))
colnames(results) <- c('f.value', 'p.value')

# wanted to use dplyr functions which drops the rownames, 
# therefore added them as a column
#results2 <- as.data.frame(cbind(id = rownames(results), results))

# create new column based on old, then arrange according to the new column 
# (the q-value)

q.value <- p.adjust(results$p.value, "fdr")
results <- cbind(results, q.value)
order_results <- results[order(results$q.value), ]

#order_results <- results2 %>% 
  #mutate(q.value = p.adjust(results2$p.value, "fdr")) %>%
  #arrange(q.value)

# proteins found to be differentially expressed
hits <- as.numeric(order_results$q.value) <= 0.05
de_proteins <- order_results[hits, ]

significant_proteins <- row.names(de_proteins)
top50 <- significant_proteins[1:50] 

