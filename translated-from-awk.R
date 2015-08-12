library(data.table)

### First approach:
### use `read.talbe` to read as `data.frame`, then convert to `data.table`
setwd("c:/users/nick/projects/r_exercise_data/")
df <- read.table("emp.data", col.names = c("Name", "PayRate", "HoursWorked"))
DT <- as.data.table(df, key=HoursWorked)
DT[HoursWorked>0, .(Name, Pay = PayRate * HoursWorked),]


### Second approach:
### clean with perl first.
### perl -pe 's/ {1,}/,/g' emp.data > emp.data.clean.perl
setwd("c:/users/nick/projects/r_exercise_data/")
readDT <- fread("emp.data.clean.perl", header=FALSE)
colnames(readDT) <- c("Name", "PayRate", "HoursWorked")
setkey(readDT, HoursWorked)

readDT[HoursWorked>0, .(Name, Pay = PayRate * HoursWorked),][order(Pay)]
