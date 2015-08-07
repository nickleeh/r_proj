library(data.table)
DT <- data.table(Name=c("Susie", "John", "Mary", "Mary", "John", "Susie", "Mary"), Value=c(400,100,200,300,100,100,100))
DT
totalDT1 <- DT[, .(Total=sum(Value)), by= Name][order(Name, Total)]
totalDT1
totalDT2 <- DT[order(Name, Value)][, .(Total=sum(Value)),by=Name]

totalDT2
dput(DT)
