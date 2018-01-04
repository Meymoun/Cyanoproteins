
# connect each protein to localization
# gene id and localization: cytoplasmic, cytoplasmic membrane,
# periplasmic, extracellular, outer membrane and unknown

clean_category <- category %>%
  select('geneID' = GeneID, Final_Localization)


# get the mean for each protein in each intensity
x60 <- apply(msdata[, 1:4], 1, mean)
x100 <- apply(msdata[, 5:8], 1, mean)
x200 <- apply(msdata[, 9:12], 1, mean)
x300 <- apply(msdata[, 13:16], 1, mean)
x1000 <- apply(msdata[, 17:20], 1, mean)

geneID <- rownames(msdata)
x <- as.data.frame(cbind(geneID, x60, x100, x200, x300, x1000))

join_location <- full_join(x, clean_category, by = 'geneID')

c <- join_location$Final_Localization == 'Cytoplasmic'
cytoplasmic <- join_location[c, 2:6]
ct <- na.omit(cytoplasmic)
ct_nr <- sapply(ct, as.numeric)
ct_sum <- apply(ct_nr, 2, sum)

m <- join_location$Final_Localization == 'OuterMembrane'
membrane <- join_location[m, 2:6]
mb <- na.omit(membrane)
mb_nr <- sapply(mb, as.numeric)
mb_sum <- apply(mb_nr, 2, sum)


rt <- as.data.frame(cbind(ct_sum, mb_sum))


rt <- mutate(rt, ratio = ct_sum / mb_sum)
ratio2 <- mutate(rt, ratio = mb_sum /ct_sum)

i <- c('x60', 'x100', 'x200', 'x300', 'x1000')

ratio <- cbind(i, rt)

ratio$i <- factor(ratio$i, levels = ratio$i)

ratio4 <- mutate(ratio, 
                 normalized = 
                   ratio$ratio / ratio$ratio[1])

plot(ratio2$ratio)

library(ggplot2)

ggplot(ratio4, aes(x=i, y=normalized)) + 
  geom_point(size=2) +
  labs(title = "With normalized ratio", x = 'Light intensity', y = 'Volume/surface ratio') +
  theme(aspect.ratio = 1)
  


ggplot(ratio4, aes(x=i, y=ratio)) + 
  geom_point(size=2) +
  labs(x = 'Light intensity', y = 'Volume/surface ratio') +
  theme(aspect.ratio = 1)
