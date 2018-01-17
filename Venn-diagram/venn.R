grid.newpage()

draw.pairwise.venn(2015, 1395, 1362, 
                  category = c("MaxQuant", "MSOpen"), 
                   lty = rep("blank", 2), 
                   fill = c("light blue", "pink"), 
                   alpha = rep(0.5, 2), 
                  cat.pos = c(0, 0), cat.dist = rep(0.025, 2))

png("venn.png", width = 10, height = 10, units = 'in', res = 400)

draw.pairwise.venn(2015, 1395, 1362, 
                   category = c("MaxQuant", "OpenMS"),
                   fill = c("#6495ED", "#ffd700"),
                   cex = 2,
                   cat.cex = 2,
                   cat.pos = c(300, 120),
                   cat.dist = 0.09)


dev.off()
