library(stringr)
library(readr)
library(data.table)

### Connect file
setwd("c:/users/nick/projects/r_exercise_data")
f <- file("sample-data-for-clean.txt")
rf <- read_file(f)

### Clean file
clean_carriage_return_middle <- str_replace_all(rf,"\r(?!\n)", "")     # Clean  in the middle of line.
clean_f <- str_replace_all(clean_carriage_return_middle,"\r\n,", ",")  # Replace 'newline,' with ','

### Read file 
DT <- fread(clean_f)

