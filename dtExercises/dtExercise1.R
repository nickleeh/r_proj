library("data.table")


### sed 's/^[[:blank:]]*//;s/[[:blank:]]\{1,\}/,/g'

df <- read.table("dtExercise1", header=T)
df
testDF <- data.table(df)
testDF
DT <- fread("dtExercise1",header=TRUE, sep="\t")
DT <- fread("dtEx1.csv")
DT
sessionInfo()

str(DT)
str(df)
identical(testDF,DT)
