set.seed(45L)
DT <- data.table(V1=c(1L,2L),
 V2=LETTERS[1:3],
 V3=round(rnorm(4),4),
 V4=1:12)
DT
DT[, V1 := round(exp(V1),2)]
DT
log(exp(1))
exp(1:10)

Cols.chosen = c("V3","V4")
DT[, Cols.chosen := NULL]
tables()
DT
DT[, (Cols.chosen) := NULL]
DT

setkey(DT,V2)
DT["A"]
DT[c("A","C")]
