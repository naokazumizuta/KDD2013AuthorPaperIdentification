# read data
setwd(Dir$raw)
old_locale <- Sys.getlocale("LC_CTYPE")
Sys.setlocale("LC_CTYPE", "C")

Author <- read.csv("Author.csv")
Conference <- read.csv("Conference.csv")
Journal <- read.csv("Journal.csv")
Paper <- read.csv("Paper.csv")
PaperAuthor <- read.csv("PaperAuthor.csv")
Train <- read.csv("Train.csv")
Valid <- read.csv("Valid_mod.csv") # not Valid.csv

Sys.setlocale("LC_CTYPE", old_locale)

setwd(Dir$rdata)
save(Author, file = "Author.RData")
save(Conference, file = "Conference.RData")
save(Journal, file = "Journal.RData")
save(Paper, file = "Paper.RData")
save(PaperAuthor, file = "PaperAuthor.RData")
save(Train, file = "Train.RData")
save(Valid, file = "Valid.RData")
