library("ggplot2")
library("data.table")
library("DescTools")

### (1) Read in data as data.frame
setwd("c:/users/nick/projects/r_proj/zodiac_ems2")
dt <- fread("ems02csv.csv")

### (2) Process
## reformat date
dt$DOB <- as.Date(dt$DOB,format="%Y/%m/%d")              # Convert DOB from factor to date format

## Determine Zodiac symbols according to DOB
dt <- dt[,.(Name = Name, ZodiacSign=Zodiac(DOB)),]       # Determine zodiac signs
zodiac_qty_dt <- DT[,.(QTY=length(Name)),by=ZodiacSign]  # Count quatity by zodiac symbols

## Set ZodiacSign factor order -- for plot order in the next step.
zodiac_qty_dt$ZodiacSign <- factor(zodiac_qty_dt$ZodiacSign, levels=zodiac_qty_dt$ZodiacSign[order(zodiac_qty_dt$QTY)])

### (3) Plot 
p <- ggplot(data=zodiac_qty_dt, aes(x=ZodiacSign, y=QTY)) +
    geom_bar(stat="identity", fill="#009E73") +
    coord_flip() +
    theme(axis.text.y = element_text(colour = 'black', size=rel(1.5)),
          axis.text.x = element_text(colour = 'black', size=rel(1.5)),
          plot.title= element_text(size=18)) + 
    ggtitle("Zodiac Signs of English Majors 2") +
    labs(y="",x="")

## Save plot image
ggsave(filename="zodiac-en.jpg", plot= p); dev.off()
