library(heatmap3)
#"#0083FF"
# cornflowerblue: #6495ED #0083FF
#FFD700

# #af8dc3

hm_color = colorRampPalette(c("#a1d76a", "black", "#e9a3c9"))(n = 499)

#d01c8b, #f7f7f7
col_breaks <- c(seq(-6.5,-0.1, length = 100), seq(0, 0, length = 300), seq(0.1, 6.5, length = 100))

# zt
phases <- colnames(zt)
names(phases) <- 'Intensity'

groups2 <- as.character(factor(phases, 
                  levels = c("x60", "x100", "x200", "x300", "x1000"),
                  labels = c('#993404', '#d95f0e', '#fe9929', '#fed98e', '#ffffd4')))
                  #c('#045a8d', '#2b8cbe', '#74a9cf', '#bdc9e1', '#f1eef6'))) 

                  
                  #labels = c('#993404', '#d95f0e', '#fe9929', '#fed98e', '#ffffd4')))
                    
                    #c('#a50f15', '#de2d26', '#fb6a4a', '#fcae91', '#fee5d9')))
                    #c('#f0f9e8', '#bae4bc', '#7bccc4', '#43a2ca', '#0868ac')))
 
                 #labels = c("#1F749B", "#0EAD69", "#FF871E", "#FFD23F", "#EE4266")))

pdf(file = 'pink_heatmap.pdf')

heatmap3(zt,
         key = TRUE,
         side.height.fraction = 0.5,
         labCol = NULL, labRow = FALSE, 
         Rowv = TRUE, Colv = NA,
         scale = 'row', dendrogram = 'row',
         col = hm_color, breaks = col_breaks,
         density.info = 'none', trace = 'none')
         #ColSideColors = groups2)

#legend('topright', title = "Light conditions", 
       #legend = c("x60", "x100", "x200", "x300", "x1000"),
       #fill = c('#993404', '#d95f0e', '#fe9929', '#fed98e', '#ffffd4'),
         #c("#1F749B", "#0EAD69", "#FF871E", "#FFD23F", "#EE4266"), 
       #cex = 0.75)
dev.off()
