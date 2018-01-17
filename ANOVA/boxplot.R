library(ggplot2)

# plot the protein with highest q-value for DE analysis
significant_proteins <- row.names(de_proteins)
top50 <- significant_proteins[1:50] 

adjusted_pvalue_top1 <- order_results$adjusted_pval
top1protein <- top50[1]
top1 <- msdata[top1protein, ]

tidy <- gather(top1, protein, intensity, X60_1:X1000_4)
tidy <- cbind(condition, tidy) 

tidy$condition = factor(tidy$condition,
                         labels = c('X60', 'X100', 'X200', 'X300', 'X1000'))

ggplot(tidy, aes(x = condition, y = intensity)) +
  theme(aspect.ratio=1) + # squared figure
  geom_boxplot(fill = "#dbc3d0", colour = "black") +
  scale_x_discrete(limit = c('X60', 'X100', 'X200', 'X300', 'X1000')) + 
  labs(title = top1protein, x = "Light condition",
                            y = "Protein intensity")

dev.off()

