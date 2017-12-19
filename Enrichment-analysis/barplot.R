
library(ggplot2)
library(RColorBrewer)


ggplot(g, aes(factor(process), value, fill = group)) +
  geom_bar(stat="identity", position = "dodge") + 
  scale_fill_brewer(palette = "Accent",
                    labels = c('Known proteome', 
                               'ANOVA q < 0.05', 'Identified',
                               'Total known proteome', 'Total DE proteome')) +
  coord_flip() + 
  labs(y = 'Number of genes annotated with', x = NULL, fill = "") +
  theme(legend.position= c(0.8, 0.8))
  

dev.off()
