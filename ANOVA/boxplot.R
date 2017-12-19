library(ggplot2)

adjusted_pvalue_top1 <- order_results$adjusted_pval
top1protein <- top50[1]
top1 <- msdata[top1protein, ]

tidy <- gather(top1, protein, intensity, X60_1:X1000_4)
tidy2 <- cbind(condition, tidy) 

tidy2$condition = factor(tidy2$condition,
                         labels = c('X60', 'X100', 'X200', 'X300', 'X1000'))

pdf(file = file.path("output", figure),
    ##width = 11.69, height = 8.72,
    ##horizontal = FALSE,
    onefile = FALSE,
    paper = "A4")

ggplot(tidy2, aes(x = condition, y = intensity)) +
  theme(aspect.ratio=1) + # squared figure
  geom_boxplot(fill = "#dbc3d0", colour = "black") +
  scale_x_discrete(limit = c('X60', 'X100', 'X200', 'X300', 'X1000')) + 
  labs(title = top1protein, x = "Light condition",
                            y = "Protein intensity")

dev.off()

protein_lm <- lm(intensity ~ condition, data = tidy2)
summary(protein_lm)

