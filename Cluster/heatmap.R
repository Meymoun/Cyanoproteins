library(heatmap3)
library(dplyr)
library(tidyr)

# pink and green colors
hm_color = colorRampPalette(c("#a1d76a", "black", "#e9a3c9"))(n = 499)

col_breaks <- c(seq(-6.5,-0.1, length = 100), seq(0, 0, length = 300), seq(0.1, 6.5, length = 100))

phases <- colnames(mean_intensities)
names(phases) <- 'Intensity'
                  
category_hm <- select(category, gene = GeneID, Process, Pathway) 

gene <- rownames(mean_intensities) 
hm <- as.data.frame(cbind(gene, mean_intensities))

b <- inner_join(hm, category_hm, by = 'gene')

process <- b$Process

# look if there are some processes clustered together
groups2 <- as.character(factor(process, 
                               levels = unique(process),
                               labels = c('white', 'red', 'white', 'white', 'white',
                               'white', 'blue', 'white', 'white', 'white', 'white', 
                               'white', 'white', 'white', 'white', 'green', 'white')))

pathway <- b$Pathway
group3 <- as.character(factor(process, 
                              levels = unique(pathway),
                              labels = rainbow(66)))

#png("pink-heatmap.png", width = 10, height = 10, units = 'in', res = 400)

heatmap3(mean_intensities,
         key = TRUE,
         side.height.fraction = 0.5,
         labCol = NULL, labRow = FALSE, 
         Rowv = TRUE, Colv = NA,
         scale = 'row', dendrogram = 'row',
         col = hm_color, breaks = col_breaks,
         density.info = 'none', trace = 'none')
        
dev.off()
