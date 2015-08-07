library(data.table)
X <- data.table(grp=c("a", "a", "b","b","b","c","c"), foo=1:7
Y <- data.table(col1=c("b", "c"), bar = c(4,2))
setkey(X, grp)
setkey(Y, col1)
X[Y, sum(foo*bar)]
X[Y, sum(foo*bar), by= .EACHI]
X
Y
