library(stringr) # has a convenient function for splitting to a fixed length 

cmd.out      <- system("ps aux --sort -%mem", intern = TRUE)
fields       <- strsplit(cmd.out[1], " +")[[1]]
ps           <- str_split_fixed(cmd.out[-1], " +", n = length(fields))
colnames(ps) <- fields
