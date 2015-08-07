##  mem-usage-stat.R 
## Get top 10 memory usage from shell command.

library(data.table)
library(stringr)       # has a convenient function for splitting to a fixed length 

## run shell command to get input, clean, and make it a data.frame.
topmem                 <- system("topmem 999", intern = TRUE)
fields                 <- strsplit(topmem[1], " +")[[1]]
fields                 <- gsub("%","",fields)
topmem.clean           <- str_split_fixed(topmem[-1], " +", n = length(fields))
colnames(topmem.clean) <- fields

## process as data.table
DT <- as.data.table(topmem.clean)
DT <- DT[, .(MEM=sum(as.numeric(MEM))), by= COMMAND]          # sum memory usage group by each command.
head(DT[, .(MEM=sort(MEM, decreasing = TRUE), COMMAND)], 10)  # sort by memory usage in decreasing order, get top 10.

## ----------------------------------------------------


topmem          <- system("ps aux | egrep 'xorg|xmonad'", intern = TRUE)
fields       <- strsplit(topmem[1], " +")[[1]]
topmem.clean           <- str_split_fixed(topmem[-1], " +", n = length(fields))
colnames(topmem.clean) <- fields
DT
