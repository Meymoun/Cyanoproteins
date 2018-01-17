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

mean_intensities <- apply(msdata, 1, m_for_hm2)
mean_intensities <- t(mean_intensities)

mean_intensities <- as.data.frame(mean_intensities)
colnames(mean_intensities) <- c('x60', 'x100', 'x200', 'x300', 'x1000')
