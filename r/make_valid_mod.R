# read data
setwd(Dir$raw)
Valid <- read.csv("Valid.csv")
ValidSolution <- read.csv("ValidSolution.csv")

valid_long <- toLong(Valid)
valid_confirmed_long <- toLong(ValidSolution)

valid_long_repid <- createRepeatId(valid_long)
valid_confirmed_long_repid <- createRepeatId(valid_confirmed_long)
valid_confirmed_long_repid$target <- 1
valid_all <- merge(valid_long_repid, valid_confirmed_long_repid, all.x = TRUE)

Confermed <- toWide(subset(valid_all, subset = !is.na(target)))
Deleted <- toWide(subset(valid_all, subset = is.na(target)))

AuthorId <- as.integer(dimnames(Confermed)[[1]])

Valid_mod <- data.frame(
    AuthorId,
    ConfirmedPaperIds = as.character(Confermed),
    DeletedPaperIds = as.character(Deleted))

# This is not raw data, though.
setwd(Dir$raw)
write.table(
    Valid_mod,
    file = "Valid_mod.csv",
    sep = ',',
    quote = FALSE,
    row.names = FALSE)
