require(data.table)
theDF <- data.frame(A=1:10,
                    B=letters[1:10],
                    C=LETTERS[11:20],
                    D=rep(c("One", "Two", "Three"),length.out=10))
theDT <- data.table(A=1:10,
                    B=letters[1:10],
                    C=LETTERS[11:20],
                    D=rep(c("One", "Two", "Three"),length.out=10))
theDF
theDT
class(theDF$B)
class(theDT$B)
library("ggplot2")
diamondsDT <- data.table(diamonds)
diamondsDT
theDT[1:2,]
theDT[theDT$A >= 7,]
theDT[,list(A,C)]
theDT[,B]
theDT[,list(B)]
theDT[, "B", with=FALSE]
theDT[, c("A", "C"), with=FALSE]
class(theDT$B)
tables()
theDT
setkey(theDT, D)
key(theDT)
theDT["One",]
theDT[c("One", "Two"),]
setkey(diamondsDT, cut, color)
diamondsDT
diamondsDT[J("Ideal", "E"),]

aggregate(price ~ cut, diamonds, mean)
str(diamonds)

diamondsDT
diamondsDT[,mean(price),by=cut]
diamondsDT[, list(price=mean(price)), by=cut]
diamondsDT[, list(price=mean(price)), by= list(cut, color)]
diamondsDT[, list(price=mean(price), carat = mean(carat)), by = cut]
diamondsDT[, list(price=mean(price),
                  carat = mean(carat),
                  caratSum = sum(carat)),
           by = cut]

diamondsDT[,list(price=mean(price),
                 carat = mean(carat)),
           by = list(cut, color)]

ls()
tables()
