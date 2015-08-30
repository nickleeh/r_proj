pacman::p_load("ggplot2",
               "lubridate",
               "readr",
               "dplyr",
               "DescTools")

## Read in data as data.frame
setwd("~/projects/r_proj/zodiac_ems2")

## iconv -f gbk -t utf8 input-file > output-file  # Convert encoding from GBK to UTF-8

ems02 <- read_csv("ems02-utf8.csv")
ems02 <- mutate(ems02, DOB = ymd(DOB))

## Determine Zodiac symbols according to DOB
ZodiacGroup <- ems02 %>%
    mutate(ZS=Zodiac(DOB)) %>%                  # Determine zodiac symbols
    group_by(ZS) %>%
    summarise(ZodiacGroupQuality = n()) %>%
    arrange(order(desc(ZodiacGroupQuality)))

ZodiacGroup$ZS <- factor(ZodiacGroup$ZS,
                         levels=ZodiacGroup$ZS[order(ZodiacGroup$ZodiacGroupQuality)])  # Set ZS factor order -- for plot order in the next step.

## Plot 
p <- ggplot(data=ZodiacGroup, aes(x=ZS, y=ZodiacGroupQuality)) +
    geom_bar(stat="identity", fill="#009E73") +
    coord_flip() +
    theme(axis.text.y = element_text(colour = 'black', size=rel(1.5)),
          axis.text.x = element_text(colour = 'black', size=rel(1.5)),
          plot.title= element_text(size=18)) + 
    ggtitle("Zodiac Symbols of English Majors 2") +
    labs(y="",x="")

## Save plot image
ggsave(filename="zodiac-dplyr.jpg", plot= p); dev.off()
