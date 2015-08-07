library("data.table")
                                        # Create a data.table my_first_data_table with a column x = c("a","b","c","d","e") and a column y = c(1,2,3,4,5). Use data.table().

my_first_data_table <- data.table(x = c("a","b","c","d","e"),
                                  y = c(1,2,3,4,5))

# Create a two-column data.table DT that contains the four integers 1,2,1,2 in the first column a and the letters A,B,C,D in the second column b. Use recycling.

DT <- data.table(rep(c(1,2),2), LETTERS[1:4])
DT

# Select the third row of DT and just print the result to the console.

DT[3,]

# Select the second and third rows without using any comma at all and print the result to the console.

DT[2:3]

DT[.N-1]
class(DT)
tables()

DT[c(2,2,3)][c(1,1,3)]

DT <- as.data.table(iris)
DT
DT[,mean(Sepal.Length), by = Species]
DT[,mean(Sepal.Length), by = substr(Species,1,1)]
?substr

Group the specimens by Sepal area (to the nearest 10 cm2) and count how many occur in each group.
Using the answer to the above question, you can now name the group Area and the count Count.

# Group the specimens by Sepal area (to the nearest 10 cm2) and count how many occur in each group.
DT[,.(Count=.N), by= .(Area=10*round(Sepal.Width * Sepal.Length / 10))]

set.seed(1L)
DT <- data.table(A=rep(letters[2:1], each=4L), B=rep(1:4, each=2L), C=sample(8))
DT

Given DT, calculate cumulative sum of C in column C while you group by A,B. Store it in a new data.table DT2 with 3 columns A,B and C.

DT2 <- DT[,.( C=sum(C)), by= .(A, B)]

DT2 <- DT[,.( C=cumsum(C)), by= .(A, B)]
DT2
DT

Select from DT2, the last two values of C in column C while you group by A alone. Make sure the column names won't change.

DT2[, .(C=tail(C, n=2L)) , by = A]

?tail
??`%`

cat("\014")
# ---------------------------------------

library(data.table)
library(hflights)
DT <- as.data.table(hflights)
DT[Month==10, mean(na.omit(AirTime)), by= UniqueCarrier]
DT[2:5]
DT[UniqueCarrier=="AA"]
DT[.N-1]
DT[,mean(na.omit(ArrDelay))]
DT[, .(mean(na.omit(DepDelay)), mean(na.omit(ArrDelay)))]
DT[, .(Avg_ArrDelay=mean(na.omit(DepDelay)), Avg_ArrDelay=mean(na.omit(ArrDelay)))]

DT[UniqueCarrier == "AA",
    .( Avg_DepDelay = mean(na.omit(DepDelay)),
       Avg_ArrDelay = mean(na.omit(ArrDelay)),
       plot(DepTime, DepDelay, ylim=c(-15,200)),
       abline(h=0))]

?Filters
?c

