setwd(Dir$rdata)
load("train_data.RData")
load("train_index.RData")
load("valid_data.RData")
load("valid_index.RData")

train_data$is_valid <- 0
valid_data$is_valid <- 1
base_model <- rbind(train_data, valid_data)
index_data <- rbind(train_index, valid_index)

base_model <- cbind(base_model, index_data)

sort_order <- with(base_model, order(target, is_valid, uid))

base_model <- base_model[sort_order, ]
index_data <- index_data[sort_order, ]
base_model <- subset(base_model, select = -c(is_valid, uid, AuthorId, PaperId))

is_last <- duplicated(index_data[, c("AuthorId", "PaperId")], fromLast = TRUE)

set.seed(12345)

### gbm adaboost
n_trees <- 750
require(gbm)
system.time({
    gbm_fit <- gbm(
        target ~ .,
        data = base_model[!is_last, ],
        distribution = "adaboost",
        n.trees = n_trees,
        interaction.depth = 4,
        shrinkage = .1,
        keep.data = FALSE,
        verbose = TRUE)})

setwd(Dir$rdata)
save(gbm_fit, file = "gbm_fit.RData")
