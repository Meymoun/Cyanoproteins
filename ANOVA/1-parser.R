
f <- read.csv(file.path("input", "diffacto_weightedsum.csv"), 
                   sep = ",",row.names = 2, stringsAsFactors = FALSE)

# remove first column, numbers 
msdata <- f[ , 2:ncol(f)]


goterm_csv <- read.csv(file.path("input", "goterm.csv"), 
              sep = ",", stringsAsFactors = FALSE)


category_loc <- read.csv(file.path("input", "category_loc.csv"), 
                         sep = ",", stringsAsFactors = FALSE)

category <- category_loc

