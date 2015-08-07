library("ggplot2")
library("data.table")
## library(scales)

getwd()
ems02 <- read.csv("zodiac_ems2/zodiac-ems02.csv")
DT <- data.table(ems02)
colnames(DT)[3] = "ZS"
## str(DT)
## DT


GroupDT <- DT[,Name,by= ZS]
## count_by_group <- Group[, .(QTY = length(Name)),by= ZS][order(-QTY)]
count_by_group <- GroupDT[, .(QTY = length(Name)),by= ZS]
## count_by_group

## x$name <- factor(x$name, levels = x$name[order(x$val)])
count_by_group$ZS <- factor(count_by_group$ZS, levels=count_by_group$ZS[order(count_by_group$QTY)])

myplot <- ggplot(data=count_by_group, aes(x=ZS, y=QTY)) +
    geom_bar(stat="identity", fill="#009E73") +
    coord_flip() +
    theme(axis.text.y = element_text(colour = 'black', size=rel(2)),
          axis.text.x = element_text(colour = 'black', size=rel(1.5)),
          plot.title= element_text(size=28)) + 
    ggtitle("Ó¢Óï2°àÐÇ×ù·Ö²¼Í¼") +
    labs(y="",x="")

## myplot + scale_x_continuous(labels=c(0,1,2,3,4,6))
myplot

## count_by_group

## myplot + theme(axis.text.y = element_text(colour = 'red', angle = 45, size = 10, hjust = -3, vjust = 7, face = 'italic'))
## myplot + theme(axis.text.y = element_text(colour = 'black'), axis.text.x = element_text(colour = 'black'))


ggsave(filename="zodiac.jpg", plot=myplot)



## -----------------------------------------------
DT
DT2 <- as.Date(DT$DOB, format = "%d-%b-%Y")
DT2
## Then use the Zodiac function from DescTools:
install.packages("DescTools")
library(DescTools)
DT$Zodiac <- Zodiac(DT$DOB)
str(DT)

typeof(DT$DOB)
Zodiac(as.character(DT$DOB))

DT$DOB <- as.Date(DT$DOB, format="%d-%b-%Y")
str(Zodiac(DT$DOB))

as.Date(factor("24-Feb-1984"), format="%d-%b-%Y")

md <- factor("24-Feb-1984")
md
as.Date(md, format = "%d-%b-%Y")


as.Date(DT$DOB, origin = "1970-01-01")

## This will give NA(s) in some locales; setting the C locale
## as in the commented lines will overcome this on most systems.
lct <- Sys.getlocale("LC_TIME");
Sys.setlocale("LC_TIME", "C")
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z
## Sys.setlocale("LC_TIME", lct)
