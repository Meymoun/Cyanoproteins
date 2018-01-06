
library(tidyr)
library(dplyr)

m_for_hm <- function(x) {
  x60 <- mean(x[1:4])
  x100 <- mean(x[5:8])
  x200 <- mean(x[9:12])
  x300 <- mean(x[13:16])
  x1000 <- mean(x[17:20]) 
  y <- c(x60, x100, x200, x300, x1000)
  }

z <- apply(msdata, 1, m_for_hm)
zt <- t(z)

colnames(zt) <- c('x60', 'x100', 'x200', 'x300', 'x1000')

zdf <- as.data.frame(zt)
colnames(zdf) <- c('x60', 'x100', 'x200', 'x300', 'x1000')

protein2 <- rownames(zdf)

zdf2 <- cbind(protein2, zdf)
tidy2 <- gather(zdf2, condition, intensity, x60:x1000)

tidier2 <- arrange(tidy2, protein2)

protein_group <- tidier2 %>%
  group_by(protein2) %>%
  summarise(ano <- aov(protein2))

