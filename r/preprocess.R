# load data
setwd(Dir$rdata)
load("Author.RData")
load("Conference.RData")
load("Journal.RData")
load("Paper.RData")
load("PaperAuthor.RData")

Author$Name_mod <- processChar(
    Author$Name,
    converter = name_convert_matrix)
PaperAuthor$Name_mod <- processChar(
    PaperAuthor$Name,
    converter = name_convert_matrix)

Author$Affiliation_mod <- processChar(
    Author$Affiliation,
    converter = affiliation_convert_matrix)
PaperAuthor$Affiliation_mod <- processChar(
    PaperAuthor$Affiliation,
    converter = affiliation_convert_matrix)

# standardize Name and Affiliation
AuthorName <- standardizeName(Author$Name_mod)
AuthorName$oname <- ifelse(Author$Name == "", " ", Author$Name)
PaperAuthorName <- standardizeName(PaperAuthor$Name_mod)
PaperAuthorName$oname <- ifelse(PaperAuthor$Name == "", " ", PaperAuthor$Name)

Author$SAffiliation <- standardizeAffiliation(Author$Affiliation_mod)
PaperAuthor$SAffiliation <- standardizeAffiliation(PaperAuthor$Affiliation_mod)

# Name
name_dict <- list()

name_dict$oname <- addDict("oname")
name_dict$sname1 <- addDict("sname1")
name_dict$sname2 <- addDict("sname2")
name_dict$sname3 <- addDict("sname3")
name_dict$sname4 <- addDict("sname4")
name_dict$sname5 <- addDict("sname5")
name_dict$sname6 <- addDict("sname6")

Author$OnameId <- name_dict$oname[AuthorName$oname]
Author$Sname1Id <- name_dict$sname1[AuthorName$sname1]
Author$Sname2Id <- name_dict$sname2[AuthorName$sname2]
Author$Sname3Id <- name_dict$sname3[AuthorName$sname3]
Author$Sname4Id <- name_dict$sname4[AuthorName$sname4]
Author$Sname5Id <- name_dict$sname5[AuthorName$sname5]
Author$Sname6Id <- name_dict$sname6[AuthorName$sname6]

PaperAuthor$OnameId <- name_dict$oname[PaperAuthorName$oname]
PaperAuthor$Sname1Id <- name_dict$sname1[PaperAuthorName$sname1]
PaperAuthor$Sname2Id <- name_dict$sname2[PaperAuthorName$sname2]
PaperAuthor$Sname3Id <- name_dict$sname3[PaperAuthorName$sname3]
PaperAuthor$Sname4Id <- name_dict$sname4[PaperAuthorName$sname4]
PaperAuthor$Sname5Id <- name_dict$sname5[PaperAuthorName$sname5]
PaperAuthor$Sname6Id <- name_dict$sname6[PaperAuthorName$sname6]

setwd(Dir$rdata)
save(Author, file = "Author_mod.RData")
save(PaperAuthor, file = "PaperAuthor_mod.RData")
save(AuthorName, file = "AuthorName.RData")
save(PaperAuthorName, file = "PaperAuthorName.RData")
save(name_dict, file = "name_dict.RData")
