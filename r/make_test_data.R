setwd(Dir$rdata)
load("Author_mod.RData")
load("PaperAuthor_mod.RData")
load("PaperAuthorName.RData")
load("name_dict.RData")

# read raw data
setwd(Dir$raw)
Test <- read.csv("Test.csv")

test <- toLong(Test)
test$target <- NA

test$uid <- 1:nrow(test)

temp_data <- test

# due to lack of memory, I have to use subset of PaperAuthor
SUB <-
    PaperAuthor$AuthorId %in% temp_data$AuthorId |
    PaperAuthor$PaperId %in% temp_data$PaperId
PaperAuthor <- subset(PaperAuthor, subset = SUB)
PaperAuthorName <- subset(PaperAuthorName, subset = SUB)

#####
count_list <- list()
PaperAuthor$count <- 1

count_list$count_a <- summaryTable(c("AuthorId"))
count_list$count_p <- summaryTable(c("PaperId"))
count_list$count_ap <- summaryTable(c("AuthorId", "PaperId"))
count_list$count_apo <- summaryTable(c("AuthorId", "PaperId", "OnameId"))
count_list$count_aps1 <- summaryTable(c("AuthorId", "PaperId", "Sname1Id"))
count_list$count_aps2 <- summaryTable(c("AuthorId", "PaperId", "Sname2Id"))
count_list$count_aps3 <- summaryTable(c("AuthorId", "PaperId", "Sname3Id"))
count_list$count_aps4 <- summaryTable(c("AuthorId", "PaperId", "Sname4Id"))
count_list$count_aps5 <- summaryTable(c("AuthorId", "PaperId", "Sname5Id"))
count_list$count_aps6 <- summaryTable(c("AuthorId", "PaperId", "Sname6Id"))

count_list$count_po <- summaryTable(c("PaperId", "OnameId"))
count_list$count_ps1 <- summaryTable(c("PaperId", "Sname1Id"))
count_list$count_ps2 <- summaryTable(c("PaperId", "Sname2Id"))
count_list$count_ps3 <- summaryTable(c("PaperId", "Sname3Id"))
count_list$count_ps4 <- summaryTable(c("PaperId", "Sname4Id"))
count_list$count_ps5 <- summaryTable(c("PaperId", "Sname5Id"))
count_list$count_ps6 <- summaryTable(c("PaperId", "Sname6Id"))

name_deleted <- PaperAuthor$Name
# delete all characters except alphabet and space
name_deleted <- gsub("[^a-zA-Z ]", "", name_deleted)
PaperAuthor$count_upper <- toupper(name_deleted) == name_deleted

count_list$count_upper_ap <- summaryTable(c("AuthorId", "PaperId"), target = "count_upper")
count_list$count_upper_p <- summaryTable(c("PaperId"), target = "count_upper")

###
PaperAuthor_unq <- PaperAuthor
# reverse the order by minus
PaperAuthor_unq$order <- -nchar(PaperAuthor$Name_mod)
PaperAuthor_unq <- PaperAuthor_unq[
    with(PaperAuthor_unq, order(AuthorId, PaperId, order)), ]
PaperAuthor_unq <- PaperAuthor_unq[
    !duplicated(PaperAuthor_unq[, c("AuthorId", "PaperId")]), ]
PaperAuthor_unq$count_unq <- 1

count_list$count_ua <- summaryTable(c("AuthorId"),
    target = "count_unq", data = PaperAuthor_unq)
count_list$count_up <- summaryTable(c("PaperId"),
    target = "count_unq", data = PaperAuthor_unq)

count_list$count_upo <- summaryTable(c("PaperId", "OnameId"),
    target = "count_unq", data = PaperAuthor_unq)
count_list$count_ups1 <- summaryTable(c("PaperId", "Sname1Id"),
    target = "count_unq", data = PaperAuthor_unq)
count_list$count_ups2 <- summaryTable(c("PaperId", "Sname2Id"),
    target = "count_unq", data = PaperAuthor_unq)
count_list$count_ups3 <- summaryTable(c("PaperId", "Sname3Id"),
    target = "count_unq", data = PaperAuthor_unq)
count_list$count_ups4 <- summaryTable(c("PaperId", "Sname4Id"),
    target = "count_unq", data = PaperAuthor_unq)
count_list$count_ups5 <- summaryTable(c("PaperId", "Sname5Id"),
    target = "count_unq", data = PaperAuthor_unq)
count_list$count_ups6 <- summaryTable(c("PaperId", "Sname6Id"),
    target = "count_unq", data = PaperAuthor_unq)

###
count_list$count_ap$count_ap_ge2 <- count_list$count_ap$count_AuthorId_PaperId >= 2
count_list$count_ap_ge2_p <- summaryTable(c("PaperId"),
    target = "count_ap_ge2", data = count_list$count_ap)

count_list$count_ap_ge2_a <- summaryTable(c("AuthorId"),
    target = "count_ap_ge2", data = count_list$count_ap)
count_list$count_ap <- subset(count_list$count_ap, select = -c(count_ap_ge2))

###
count_list$count_upo$count_upo_ge2 <- count_list$count_upo$count_unq_PaperId_OnameId >= 2
count_list$count_upo_ge2_p <- summaryTable(c("PaperId"),
    target = "count_upo_ge2", data = count_list$count_upo)
count_list$count_upo <- subset(count_list$count_upo, select = -c(count_upo_ge2))

count_list$count_ups1$count_ups1_ge2 <- count_list$count_ups1$count_unq_PaperId_Sname1Id >= 2
count_list$count_ups1_ge2_p <- summaryTable(c("PaperId"),
    target = "count_ups1_ge2", data = count_list$count_ups1)
count_list$count_ups1 <- subset(count_list$count_ups1, select = -c(count_ups1_ge2))

count_list$count_ups2$count_ups2_ge2 <- count_list$count_ups2$count_unq_PaperId_Sname2Id >= 2
count_list$count_ups2_ge2_p <- summaryTable(c("PaperId"),
    target = "count_ups2_ge2", data = count_list$count_ups2)
count_list$count_ups2 <- subset(count_list$count_ups2, select = -c(count_ups2_ge2))

count_list$count_ups3$count_ups3_ge2 <- count_list$count_ups3$count_unq_PaperId_Sname3Id >= 2
count_list$count_ups3_ge2_p <- summaryTable(c("PaperId"),
    target = "count_ups3_ge2", data = count_list$count_ups3)
count_list$count_ups3 <- subset(count_list$count_ups3, select = -c(count_ups3_ge2))

count_list$count_ups4$count_ups4_ge2 <- count_list$count_ups4$count_unq_PaperId_Sname4Id >= 2
count_list$count_ups4_ge2_p <- summaryTable(c("PaperId"),
    target = "count_ups4_ge2", data = count_list$count_ups4)
count_list$count_ups4 <- subset(count_list$count_ups4, select = -c(count_ups4_ge2))

count_list$count_ups5$count_ups5_ge2 <- count_list$count_ups5$count_unq_PaperId_Sname5Id >= 2
count_list$count_ups5_ge2_p <- summaryTable(c("PaperId"),
    target = "count_ups5_ge2", data = count_list$count_ups5)
count_list$count_ups5 <- subset(count_list$count_ups5, select = -c(count_ups5_ge2))

count_list$count_ups6$count_ups6_ge2 <- count_list$count_ups6$count_unq_PaperId_Sname6Id >= 2
count_list$count_ups6_ge2_p <- summaryTable(c("PaperId"),
    target = "count_ups6_ge2", data = count_list$count_ups6)
count_list$count_ups6 <- subset(count_list$count_ups6, select = -c(count_ups6_ge2))

###
PaperAuthor$count_abb <- nchar(PaperAuthorName$firstname_mod) == 1
count_list$count_abb_ap <- summaryTable(c("AuthorId", "PaperId"), target = "count_abb")
count_list$count_abb_p <- summaryTable(c("PaperId"), target = "count_abb")

PaperAuthor$count_author <- PaperAuthor$AuthorId %in% Author$Id
count_list$count_author_p <- summaryTable(c("PaperId"), target = "count_author")

PaperAuthor_unq$count_unq_author <- PaperAuthor_unq$AuthorId %in% Author$Id
count_list$count_unq_author_p <- summaryTable(c("PaperId"),
    target = "count_unq_author", data = PaperAuthor_unq)

###
author_dict <- Author$Affiliation
names(author_dict) <- Author$Id
in_author <- PaperAuthor$AuthorId %in% Author$Id

PaperAuthor$AuthorAffiliation[in_author] <- author_dict[as.character(PaperAuthor$AuthorId[in_author])]
PaperAuthor$AuthorAffiliation[!in_author] <- ""

PaperAuthor$count_same_aff <- with(PaperAuthor, AuthorAffiliation == Affiliation & Affiliation != "")
count_list$count_same_aff_paff <- summaryTable(c("PaperId"), target = "count_same_aff")

PaperAuthor$count_aff <- with(PaperAuthor, Affiliation != "")
count_list$count_aff_ap <- summaryTable(c("AuthorId", "PaperId"), target = "count_aff")
count_list$count_aff_p <- summaryTable(c("PaperId"), target = "count_aff")

count_aff_paff <- summaryTable(c("PaperId", "Affiliation"), target = "count_aff")
count_aff_paff$count_paff_ge2 <- count_aff_paff$count_aff_PaperId_Affiliation >= 2
count_aff_paff$count_paff_ge3 <- count_aff_paff$count_aff_PaperId_Affiliation >= 3
count_aff_paff$count_paff_ge4 <- count_aff_paff$count_aff_PaperId_Affiliation >= 4
count_list$count_paff_ge2_p <- summaryTable(c("PaperId"), target = "count_paff_ge2", data = count_aff_paff)
count_list$count_paff_ge3_p <- summaryTable(c("PaperId"), target = "count_paff_ge3", data = count_aff_paff)
count_list$count_paff_ge4_p <- summaryTable(c("PaperId"), target = "count_paff_ge4", data = count_aff_paff)

setwd(Dir$rdata)
load("Paper.RData")
load("Journal.RData")
load("Conference.RData")

names(Author) <- paste("Author", names(Author), sep = '')
names(Conference) <- paste("Conference", names(Conference), sep = '')
names(Journal) <- paste("Journal", names(Journal), sep = '')
names(Paper)[1] <- "PaperId"

temp_data <- mergeData(Author)
temp_data <- mergeData(Paper)
temp_data <- mergeData(Journal)
temp_data <- mergeData(Conference)

temp_data$AuthorName_mod <- processChar(
    temp_data$AuthorName,
    converter = name_convert_matrix)

AuthorName <- standardizeName(temp_data$AuthorName_mod)
AuthorName$oname <- ifelse(temp_data$AuthorName == "", " ", temp_data$AuthorName)

temp_data$OnameId <- name_dict$oname[AuthorName$oname]
temp_data$Sname1Id <- name_dict$sname1[AuthorName$sname1]
temp_data$Sname2Id <- name_dict$sname2[AuthorName$sname2]
temp_data$Sname3Id <- name_dict$sname3[AuthorName$sname3]
temp_data$Sname4Id <- name_dict$sname4[AuthorName$sname4]
temp_data$Sname5Id <- name_dict$sname5[AuthorName$sname5]
temp_data$Sname6Id <- name_dict$sname6[AuthorName$sname6]

temp_data$count_datadup <- 1
count_list$count_datadup <- summaryTable(c("AuthorId", "PaperId"), target = "count_datadup", data = temp_data)
temp_data <- subset(temp_data, select = -c(count_datadup))

for (i in 1:length(count_list)) {
    temp_data <- mergeData(count_list[[i]])
}

# other features
temp_data$has_conferenceid <- as.numeric(!(temp_data$ConferenceId %in% c(0, -1)))
temp_data$has_journalid <- as.numeric(!(temp_data$JournalId %in% c(0, -1)))
temp_data$has_year <- as.numeric(!(temp_data$Year %in% c(0, -1)))
temp_data$has_title <- as.numeric(temp_data$Title != "")
temp_data$has_keyword <- as.numeric(temp_data$Keyword != "")
temp_data$prop_ap_ge2_AuthorId <- temp_data$count_ap_ge2_AuthorId / temp_data$count_AuthorId
temp_data$prop_unq_ap_ge2_AuthorId <- temp_data$count_ap_ge2_AuthorId / temp_data$count_unq_AuthorId
temp_data$count_not_abb_PaperId <- temp_data$count_PaperId - temp_data$count_abb_PaperId

temp_data$count_ap_ge2_indata <- temp_data$count_AuthorId_PaperId >= 2

count_ap_ge2_indata <- summaryTable(c("AuthorId"), target = "count_ap_ge2_indata", data = temp_data)
temp_data <- mergeData(count_ap_ge2_indata)
temp_data <- subset(temp_data, select = -c(count_ap_ge2_indata))

temp_data <- temp_data[order(temp_data$uid), ]

for (i in names(temp_data)) {
    if (i != "target" && sum(is.na(temp_data[, i])) > 0) {
        temp_data[, i] <- ifelse(is.na(temp_data[, i]), -1, temp_data[, i])
    }
}

test_data <- temp_data[,
    grepl("count", names(temp_data)) |
    grepl("prop", names(temp_data)) |
    grepl("has_", names(temp_data)) |
    grepl("Year", names(temp_data)) |
    names(temp_data) == "target"]
test_index <- temp_data[, c("uid", "AuthorId", "PaperId")]

setwd(Dir$rdata)
save(test_data, file = "test_data.RData")
save(test_index, file = "test_index.RData")
