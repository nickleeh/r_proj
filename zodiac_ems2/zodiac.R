library("ggplot2")
library("data.table")
library("DescTools")

## Read in data as data.frame
## ems02 <- read.csv("zodiac_ems2/ems02csv.csv")

DT <- fread("ems02csv.csv")
## str(DT)
## DT <- data.table(ems02)

DT$DOB <- as.Date(DT$DOB,format="%Y/%m/%d")                  # Convert DOB from factor to date format

## Determine Zodiac symbols according to DOB
DT <- DT[,.(Name = Name, ZS=Zodiac(DOB)),]                   # Determine zodiac symbols
DTZQ <- DT[,.(QTY=length(Name)),by=ZS]                       # Count quatity by zodiac symbols
DTZQ$ZS <- factor(DTZQ$ZS, levels=DTZQ$ZS[order(DTZQ$QTY)])  # Set ZS factor order -- for plot order in the next step.

## Plot 
p <- ggplot(data=DTZQ, aes(x=ZS, y=QTY)) +
    geom_bar(stat="identity", fill="#009E73") +
    coord_flip() +
    theme(axis.text.y = element_text(colour = 'black', size=rel(1.5)),
          axis.text.x = element_text(colour = 'black', size=rel(1.5)),
          plot.title= element_text(size=18)) + 
    ggtitle("Zodiac Symbols of English Majors 2") +
    labs(y="",x="")

## Save plot image
ggsave(filename="zodiac-en.jpg", plot= p); dev.off()
