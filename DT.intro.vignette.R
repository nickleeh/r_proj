install.packages("devtools")

# To install development version
library(devtools)
install_github("Rdatatable/data.table", build_vignettes = FALSE)

library(data.table)
flights <- fread("https://raw.githubusercontent.com/wiki/arunsrinivasan/flights/NYCflights14/flights14.csv")
str(flights)
tables()
DT = data.table(ID=c("b", "b", "b", "a", "b", "c"), a= 1:6, b=7:12, c=13:18)
DT
class(DT$ID)

ans <- flights[,arr_delay]
head(ans)

ans <- flights[, list(arr_delay, dep_delay)]
ans <- flights[, .(arr_delay, dep_delay)]

ans <- flights[, sum((arr_delay + dep_delay)<0)]
ans

ans <- flights[origin=="JFK" & month==6L, .N]

f) Subset in i and do in j
– Calculate the average arrival and departure delay for all flights with “JFK” as the origin airport in the month of June.

ans <- flights[origin == "JFK" & month == 6L, 
               .(m_arr=mean(arr_delay), m_dep=mean(dep_delay))]
ans
#       m_arr    m_dep
# 1: 5.839349 9.807884

typeof(6)


We first subset in i to find matching row indices where origin airport equals “JFK”, and month equals 6. At this point, we do not subset the entire data.table corresponding to those rows.
Now, we look at j and find that it uses only two columns. And what we have to do is to compute their mean(). Therefore we subset just those columns corresponding to the matching rows, and compute their mean().
Because the three main components of the query (i, j and by) are together inside [...], data.table can see all three and optimise the query altogether before evaluation, not each separately. We are able to therefore avoid the entire subset, for both speed and memory efficiency.
– How many trips have been made in 2014 from “JFK” airport in the month of June?

ans <- flights[origin == "JFK" & month == 6L, length(dest)]
ans
# [1] 8422
The function length() requires an input argument. We just needed to compute the number of rows in the subset. We could have used any other column as input argument to length() really.

This type of operation occurs quite frequently, especially while grouping as we will see in the next section, that data.table provides a special symbol .N for it.

Special symbol .N:
.N is a special in-built variable that holds the number of observations in the current group. It is particularly useful when combined with by as we’ll see in the next section. In the absence of group by operations, it simply returns the number of rows in the subset.
So we can now accomplish the same task by using .N as follows:

ans <- flights[origin == "JFK" & month == 6L, .N]
ans
# [1] 8422
Once again, we subset in i to get the row indices where origin airport equals “JFK”, and month equals 6.
We see that j uses only .N and no other columns. Therefore the entire subset is not materialised. We simply return the number of rows in the subset (which is just the length of row indices).
Note that we did not wrap .N with list() or .(). Therefore a vector is returned.
We could have accomplished the same operation by doing nrow(flights[origin == "JFK" & month == 6L]). However, it would have to subset the entire data.table first corresponding to the row indices in i and then return the rows using nrow(), which is unnecessary and inefficient. We will cover this and other optimisation aspects in detail under the data.table design vignette.


flights[origin=="JFK" & month == 6L, .N]
flights[, c("arr_delay", "dep_delay"), with = FALSE] 
flights[, .(arr_delay, dep_delay)]
flights

DF = data.frame(x=c(1,1,1,2,2,3,3,3), y=1:8)
DF[DF$x>1,]
DF[with(DF, x>1),]

flights[carrier =="AA", .N, by=origin]
flights[carrier == "AA", .N, by = .(origin, dest)]

flights[carrier == "AA",
        .(ArrDelayMean = mean(arr_delay),
          DepDelayMean = mean(dep_delay)),
        by = .(origin, dest, month)]

flights[carrier == "AA",
        .(ArrDelayMean = mean(arr_delay),
          DepDelayMean = mean(dep_delay)),
        keyby = .(origin, dest, month)]

ans <- flights[carrier=="AA", .N, by = .(origin,dest)]
ans <- ans[order(origin, -dest)]

ans <- flights[carrier=="AA", .N, by = .(origin, dest)][order(origin, -dest)]

flights[, .N, .(dep_delay>0, arr_delay>0)]

DT[, print(.SD), by=ID]
DT[, lapply(.SD, mean), by=ID]

flights[carrier=="AA",
        lapply(.SD, mean),
        by=.(origin, dest, month), .SDcols=c("arr_delay", "dep_delay")]

flights[, head(.SD,2),by=month]


DT[, .(val=c(a,b)), by = ID]
DT[, .(val=list(c(a,b))), by = ID]
DT[, .(val=.(c(a,b))), by = ID]

DT[, print(c(a,b)), by= ID]
DT[, print(.(c(a,b))), by= ID]

DT
