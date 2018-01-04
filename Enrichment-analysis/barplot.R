
library(ggplot2)
library(RColorBrewer)

# x$name <- factor(x$name, levels = x$name[order(x$val)]
#g$process <- g$process[order(g$process)]

ggplot(g, aes(x = process, y = value, 
              fill = factor(group, 
                            levels = c('x', 'i', 'm')))) +
  geom_bar(stat="identity", position = "dodge") + 
  scale_fill_brewer(palette = "Accent",
                    labels = c('ANOVA q < 0.05', 
                               'Identified', 'Known proteome')) +
  coord_flip() + 
  labs(y = 'Number of annotated genes', x = NULL, fill = "") +
  theme(legend.position= c(0.77, 0.85), 
        aspect.ratio = 1.2)
  

dev.off()

#'Total known proteome', 'Total DE proteome')) +
