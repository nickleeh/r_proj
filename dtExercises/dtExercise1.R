library("data.table")


### sed 's/^[[:blank:]]*//;s/[[:blank:]]\{1,\}/,/g'

df <- read.table("dtExercise1", header=T)
df
testDF <- data.table(df)
testDF
DT <- fread("dtExercise1",header=T)
DT <- fread("dtExercise1",header=TRUE, sep="\t")

DT <- fread("dtEx1.csv")
DT
sessionInfo()

str(DT)
str(df)
identical(testDF,DT)

### --------------------------

setkey(DT, Date)

str(DT)

DT1 <- unique(DT, by="Col1")

DT1[, .N, by=Date][, Count:=cumsum(N)][]
