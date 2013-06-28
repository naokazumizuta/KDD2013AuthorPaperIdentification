setwd(Dir$rdata)
load("test_data.RData")
load("test_index.RData")
load("gbm_fit.RData")

n_trees <- 750
pred_score <- plogis(predict(
    gbm_fit,
    test_data,
    n.trees = n_trees,
    type = "response"))
names(pred_score) <- test_index$PaperId

pred_list <- tapply(
    pred_score,
    test_index$AuthorId,
    function(x)
        paste(unique(names(x)[order(x, decreasing = TRUE)]), collapse = ' '))

PaperIds <- pred_list

setwd(Dir$raw)
submit_form <- read.csv("Test.csv")

submit_form$uid <- 1:nrow(submit_form)
submit_form <- submit_form[order(submit_form$AuthorId), ]
submit_form$PaperIds <- PaperIds
submit_form <- submit_form[order(submit_form$uid), ]
submit_form <- subset(submit_form, select = c(AuthorId, PaperIds))

setwd(Dir$submit)
write.table(
    submit_form,
    file = "final_submission.csv",
    row.names = FALSE,
    sep = ',')
