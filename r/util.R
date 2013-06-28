# evaluation function
apk <- function(k, actual, predicted) {
    score <- 0.0
    cnt <- 0.0
    for (i in 1:min(k,length(predicted))) {
        if (predicted[i] %in% actual && !(predicted[i] %in% predicted[0:(i-1)])) {
            cnt <- cnt + 1
            score <- score + cnt / i 
        }
    }
    score <- score / min(length(actual), k)
    return(score)}

mapk <- function (k, actual, predicted) {
    scores <- rep(0, length(actual))

    for (i in 1:length(scores)) {
        scores[i] <- apk(
            k,
            strsplit(actual[[i]], split = ' ', fixed = TRUE)[[1]],
            strsplit(predicted[[i]], split = ' ', fixed = TRUE)[[1]])
    }
    score <- mean(scores)
    return(score)}

apk_all <- function (k, actual, predicted) {
    scores <- rep(0, length(actual))

    for (i in 1:length(scores)) {
        scores[i] <- apk(
            k,
            strsplit(actual[[i]], split = ' ', fixed = TRUE)[[1]],
            strsplit(predicted[[i]], split = ' ', fixed = TRUE)[[1]])
    }
    return(scores)}

# modified evaluation function
apk_mod <- function(k, actual, predicted) {
    score <- 0.0
    cnt <- 0.0
    predicted <- unique(predicted)
    actual <- unique(actual)
    for (i in 1:min(k,length(predicted))) {
        if (predicted[i] %in% actual && !(predicted[i] %in% predicted[0:(i-1)])) {
            cnt <- cnt + 1
            score <- score + cnt / i 
        }
    }
    score <- score / min(length(actual), k)
    return(score)}

mapk_mod <- function (k, actual, predicted) {
    scores <- rep(0, length(actual))

    for (i in 1:length(scores)) {
        scores[i] <- apk_mod(
            k,
            strsplit(actual[[i]], split = ' ', fixed = TRUE)[[1]],
            strsplit(predicted[[i]], split = ' ', fixed = TRUE)[[1]])
    }
    score <- mean(scores)
    return(score)}

apk_all_mod <- function (k, actual, predicted) {
    scores <- rep(0, length(actual))

    for (i in 1:length(scores)) {
        scores[i] <- apk_mod(
            k,
            strsplit(actual[[i]], split = ' ', fixed = TRUE)[[1]],
            strsplit(predicted[[i]], split = ' ', fixed = TRUE)[[1]])
    }
    return(scores)}

toLong <- function(data) {
    paper_list <- strsplit(data$PaperIds, split = ' ')
    paper_length <- sapply(paper_list, length)
    AuthorId <- rep(data$AuthorId, paper_length)
    PaperId <- as.integer(unlist(paper_list))

    return(data.frame(AuthorId, PaperId))
}

createRepeatId <- function(data) {
    APId <- with(data, paste(AuthorId, PaperId))
    APId_table <- table(APId)
    RepeatId <- unlist(lapply(APId_table, seq))
    AP_list <- strsplit(names(APId_table), split = ' ')
    AuthorId <- rep(as.integer(sapply(AP_list, function(x) x[1])), APId_table)
    PaperId <- rep(as.integer(sapply(AP_list, function(x) x[2])), APId_table)

    return(data.frame(AuthorId, PaperId, RepeatId))
}

toWide <- function(data) {
    pasteIds <- with(
        data,
        tapply(PaperId, AuthorId, function(x) paste(x, collapse = ' ')))
    return(pasteIds)
}

# aggregate
summaryTable <- function(
    ids,
    target = "count",
    data = PaperAuthor,
    stat = sum) {
    By <- paste(ids, collapse = '+')
    Formula <- as.formula(paste(c(target, By), collapse = '~'))
    sumtable <- aggregate(Formula, data = data, FUN = stat)
    num_ids <- length(ids)
    varname <- paste(c(target, ids), collapse = '_')
    names(sumtable)[num_ids + 1] <- varname

    return(sumtable)
}

#####
name_convert_matrix <- matrix(c(
    "\\.*\\s+", " ",
    "['\\-]", "",
    "\xc3\x80", "A",
    "\xc3\x81", "A",
    "\xc3\x82", "A",
    "\xc3\x83", "A",
    "\xc3\x84", "A",
    "\xc3\x85", "A",
    "\xc3\x87", "C",
    "\xc3\x88", "E",
    "\xc3\x89", "E",
    "\xc3\x8a", "E",
    "\xc3\x8b", "E",
    "\xc3\x8c", "I",
    "\xc3\x8d", "I",
    "\xc3\x8e", "I",
    "\xc3\x8f", "I",
    "\xc3\x91", "N",
    "\xc3\x92", "O",
    "\xc3\x93", "O",
    "\xc3\x94", "O",
    "\xc3\x95", "O",
    "\xc3\x96", "O",
    "\xc3\x98", "O",
    "\xc3\x99", "U",
    "\xc3\x9a", "U",
    "\xc3\x9b", "U",
    "\xc3\x9c", "U",
    "\xc3\x9d", "Y",
    # "\xc3\x9f", "Y",
    "\xc3\xa0", "a",
    "\xc3\xa1", "a",
    "\xc3\xa2", "a",
    "\xc3\xa3", "a",
    "\xc3\xa4", "a",
    "\xc3\xa5", "a",
    "\xc3\xa7", "c",
    "\xc3\xa8", "e",
    "\xc3\xa9", "e",
    "\xc3\xaa", "e",
    "\xc3\xab", "e",
    "\xc3\xac", "i",
    "\xc3\xad", "i",
    "\xc3\xae", "i",
    "\xc3\xaf", "i",
    "\xc3\xb1", "n",
    "\xc3\xb2", "o",
    "\xc3\xb3", "o",
    "\xc3\xb4", "o",
    "\xc3\xb5", "o",
    "\xc3\xb6", "o",
    "\xc3\xb8", "o",
    "\xc3\xba", "u",
    "\xc3\xbb", "u",
    "\xc3\xbc", "u",
    "\xc3\xbd", "y",
    "\xc3\xbf", "y",
    "[^a-zA-Z ]", ""), ncol = 2, byrow = TRUE)

affiliation_convert_matrix <- matrix(c(
    " at ", " ",
    "U\\.", "University",
    "[\\-]", " ",
    "\\|", ",",
    "[^a-zA-Z, ]", ""), ncol = 2, byrow = TRUE)

processChar <- function(charvar, converter, logging = TRUE) {
    for (i in 1:nrow(converter)) {
        if (logging) {
            cat(
                "converting:",
                converter[i, 1],
                " to ",
                converter[i, 2],
                "\n")}
        charvar <- gsub(
            converter[i, 1],
            converter[i, 2],
            charvar)
    }
    return(charvar)
}

mergeData <- function(data) {
    return(merge(temp_data, data, all.x = TRUE, all.y = FALSE))
}

# standardize Name and Affiliation
standardizeName <- function(Name) {
    name_list <- strsplit(Name, split = ' ')
    name_length <- sapply(name_list, length)
    firstname <- sapply(name_list, function(x) x[1])
    middlename <- sapply(name_list, function(x) x[2])
    lastname <- sapply(name_list, function(x) x[length(x)])
    firstinitial <- toupper(substr(firstname, 1, 1))
    middleinitial <- toupper(substr(middlename, 1, 1))
    lastinitial <- toupper(substr(lastname, 1, 1))

    firstname_mod <- tolower(firstname)
    substr(firstname_mod, 1, 1) <- firstinitial
    middlename_mod <- tolower(middlename)
    substr(middlename_mod, 1, 1) <- middleinitial
    lastname_mod <- tolower(lastname)
    substr(lastname_mod, 1, 1) <- lastinitial

    has_middlename <- name_length >= 3

    sname1 <- paste(firstinitial, lastname_mod)
    sname2 <- paste(firstname_mod, lastname_mod)

    sname3 <- paste(firstinitial, middleinitial, lastname_mod)
    sname4 <- paste(firstinitial, middlename_mod, lastname_mod)
    sname5 <- paste(firstname_mod, middleinitial, lastname_mod)
    sname6 <- paste(firstname_mod, middlename_mod, lastname_mod)

    sname3[!has_middlename] <- sname1[!has_middlename]
    sname4[!has_middlename] <- sname1[!has_middlename]
    sname5[!has_middlename] <- sname2[!has_middlename]
    sname6[!has_middlename] <- sname2[!has_middlename]

    return(data.frame(
        sname1, sname2, sname3, sname4, sname5, sname6,
        firstname_mod, lastname_mod))
}

standardizeAffiliation <- function(Affiliation) {
    affiliation_list <- strsplit(Affiliation, split = ',')
    university <- sapply(
        affiliation_list,
        function(x) x[grepl("Universi", x)][1])
    institute <- sapply(
        affiliation_list,
        function(x) x[grepl("Institu", x)][1])

    saffiliation <- ifelse(
        !is.na(university),
        university,
        ifelse(
            !is.na(institute),
            institute,
            Affiliation))

    return(saffiliation)
}

addDict <- function(name) {
    var <- c(AuthorName[, name], PaperAuthorName[, name])
    var[var == ""] <- " "
    name_unq <- unique(var)
    name_seq <- 1:length(name_unq)
    names(name_seq) <- name_unq
    return(name_seq)
}
