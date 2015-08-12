library(data.table)
df <- read.table("emp.data", col.names = c("Name", "PayRate", "HoursWorked"))
DT <- as.data.table(df, key=HoursWorked)

## DT
## readDT <- fread("emp.data", header=FALSE, sep=" ")
## colnames(DT) <- c("Name", "PayRate", "HoursWorked")
## colnames(DT)

DT[HoursWorked>0, .(Name, Pay = PayRate * HoursWorked),]
