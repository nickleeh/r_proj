# To install development version
install.packages("devtools")
library(devtools)
install_github("Rdatatable/data.table", build_vignettes = FALSE)

# If you would like to revert back to CRAN version
remove.packages("data.table")         # First remove the current version
install.packages("data.table")        # Then install the CRAN version
