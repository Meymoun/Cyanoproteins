
# zt
library(dplyr)
library(tidyr)
library(ggplot2)

sub_category <- select(category, GeneID, SeqID, Process, Pathway, Protein)

d_whole <- dist(as.matrix(msdata))
hc_whole <- hclust(d_whole)

# show tree and clusters
plot(hc_whole)
rect.hclust(hc_whole, k = 100, border = 'red')
dev.off()

# cluster tree
c <- cutree(hc_whole, k = 3)
c_whole <- as.data.frame(c)
c_whole <- cbind(id = row.names(c_whole), c_whole)

s <- c_whole %>%
  mutate(i = 1:nrow(c_whole)) %>%
  group_by(c) %>%
  spread(c, id)


s1 <- droplevels(na.omit(s$`1`))
s2 <- droplevels(na.omit(s$`2`))
s3 <- droplevels(na.omit(s$`3`))

s1 <- as.data.frame(s1)
s2 <- as.data.frame(s2)
s3 <- as.data.frame(s3)

colnames(s1) <- 'GeneID'
colnames(s2) <- 'GeneID'
colnames(s3) <- 'GeneID'

cluster1 <- inner_join(s1, sub_category, by = 'GeneID')
cluster2 <- inner_join(s2, sub_category, by = 'GeneID')
cluster3 <- inner_join(s3, sub_category, by = 'GeneID')

i <- as.data.frame(cbind(GeneID = row.names(zt), zt), stringsAsFactors = FALSE)

clusterdata1 <- inner_join(cluster1, i, by = 'GeneID')
clusterdata2 <- inner_join(cluster2, i, by = 'GeneID')
clusterdata3 <- inner_join(cluster3, i, by = 'GeneID')

c1 <- clusterdata2 %>%
  select(SeqID, Pathway, x60:x1000) %>%
  gather(group, intensity, x60:x1000)

# make column numeric
c1$intensity <- as.numeric(c1$intensity)

# factorize columns, is this necessary?
c1$SeqID <- factor(c1$SeqID)
c1$group <- factor(c1$group, levels = c('x60', 'x100', 'x200', 'x300', 'x1000'))

#figure = 'cluster2.3.pdf'

#pdf(file = file.path("output", figure),
    #onefile = FALSE,
    #paper = "A4")

bmp(filename = 'cluster1.bmp')

ggplot(c1, aes(y = intensity, x = group, col = SeqID)) +
  geom_point(aes(shape = Pathway), size = 3) +
  #geom_smooth(method = 'lm', aes(fill=GeneID, group = GeneID), 
  #fullrange = TRUE, se = FALSE,
  #size = 0.5) +
  geom_path(aes(group = SeqID, color = SeqID)) +
  scale_y_continuous(name = 'Abundance') +
  labs(title = 'Gene cluster', x = NULL) +
  theme_classic() +
  theme(legend.position = c(1.3, 0.6)) +
  theme(aspect.ratio = 1)
  
#facet_wrap(~ GeneID)

dev.off()
