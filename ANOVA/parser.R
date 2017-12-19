
f <- read.csv(file.path("input", "diffacto_weightedsum.csv"), 
                   sep = ",",row.names = 2, stringsAsFactors = FALSE)

# remove first column, numbers 
msdata <- f[ , 2:ncol(f)]
