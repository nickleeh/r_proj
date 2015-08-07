str <- "How do I best try and try and try and find a way to to improve this code?"
d <- unlist(strsplit(str, split=" "))
d <- gsub("[[:punct:]]", "", d)         # optional: remove punctuation.
paste(unique(d), collapse = ' ')        # remove duplicate words.
