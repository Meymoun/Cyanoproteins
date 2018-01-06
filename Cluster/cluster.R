
# zt
library(dplyr)
library(tidyr)
library(ggplot2)

sub_category <- select(category, GeneID, SeqID, Process, Pathway, Protein)

d_whole <- dist(as.matrix(zt))
hc_whole <- hclust(d_whole)

plot(hc_whole)
rect.hclust(hc_whole, k = 3, border = 'red')
dev.off()

c <- cutree(hc_whole, k = 5)

c_whole <- as.data.frame(c)
c_whole <- cbind(id = row.names(c_whole), c_whole)

s <- c_whole %>%
  mutate(i = 1:nrow(c_whole)) %>%
  group_by(c) %>%
  spread(c, id)


s1 <- droplevels(na.omit(s$`1`))
s2 <- droplevels(na.omit(s$`2`))
s3 <- droplevels(na.omit(s$`3`))
s4 <- droplevels(na.omit(s$`4`))
s5 <- droplevels(na.omit(s$`5`))

s1 <- as.data.frame(s1)
s2 <- as.data.frame(s2)
s3 <- as.data.frame(s3)
s4 <- as.data.frame(s4)
s5 <- as.data.frame(s5)

colnames(s1) <- 'GeneID'
colnames(s2) <- 'GeneID'
colnames(s3) <- 'GeneID'
colnames(s4) <- 'GeneID'
colnames(s5) <- 'GeneID'

cluster1 <- inner_join(s1, sub_category, by = 'GeneID')
cluster2 <- inner_join(s2, sub_category, by = 'GeneID')
cluster3 <- inner_join(s3, sub_category, by = 'GeneID')
cluster4 <- inner_join(s4, category, by = 'GeneID')
cluster5 <- inner_join(s5, category, by = 'GeneID')

mean_i <- as.data.frame(cbind(GeneID = row.names(zt), zt), stringsAsFactors = FALSE)

clusterdata1 <- inner_join(s1, mean_i, by = 'GeneID')
clusterdata2 <- inner_join(s2, mean_i, by = 'GeneID')
clusterdata3 <- inner_join(s3, mean_i, by = 'GeneID')
clusterdata4 <- inner_join(s4, mean_i, by = 'GeneID')
clusterdata5 <- inner_join(s5, mean_i, by = 'GeneID')

c1 <- gather(clusterdata2, group, intensity, x60:x1000)

#rdata <- as.data.frame(factor(c1, levels = row.names(clusterdata3))) 


#c1$GeneID <- factor(c1$GeneID)

intensity <- as.numeric(c1$intensity)
#geneID <- as.factor(c1$GeneID)
#group <- c1$group
c2 <- select(c1, -intensity)

c3 <- as.data.frame(cbind(c2, intensity))
#c3 <- arrange(c3, GeneID)

class(c3$intensity)

c3$GeneID <- factor(c3$GeneID)
c3$group <- factor(c3$group, levels = c('x60', 'x100', 'x200', 'x300', 'x1000'))

class(c3$GeneID)

dev.off()

#p5 <- ggplot(c1, aes(x = group, y = intensity))
#p5 + geom_line(aes(color = )) 


ggplot(c3, aes(y = intensity, x = group)) +
  geom_point(aes(color = GeneID)) +
  scale_y_continuous(name = 'intensity', breaks = NULL) +
  theme(aspect.ratio = 1) +
  geom_smooth(method = lm, se=FALSE, fullrange=TRUE)
  #geom_smooth(method = lm, aes(fill = GeneID))
  #geom_line(aes(color = geneID))
  #geom_path()
  #
  
  
  

