#Statistical machine learning lecture
##################
# Sof Antelo
# Comp Bio 6100
# 4/16/2026
##################
#PCA and Random Forest in R

#set up environment
# For reproducible results
set.seed(1)

# Packages used today
library(ggplot2)
library(psych)        # Bartlett's test
library(randomForest) # Random forest

# Data
data(iris)

#take a look
head(iris)
str(iris)

#PCA!
#Numeric Columns and Scale
iris_num <- iris[, 1:4]
iris_species <- iris$Species

round(cor(iris_num), 2)

#make sure pca is "worth it"
bart <- cortest.bartlett(cor(iris_num), n = nrow(iris_num))
bart

#fit pca
pca <- prcomp(iris_num, center = TRUE, scale. = TRUE)
summary(pca)

#variance 
eig <- pca$sdev^2
pve <- eig / sum(eig)

pca_var_table <- data.frame(
  PC = paste0("PC", 1:length(eig)),
  Eigenvalue = round(eig, 3),
  PVE = round(pve, 3),
  CumPVE = round(cumsum(pve), 3)
)
pca_var_table

#scree plot
plot(eig, type = "b", pch = 19,
     xlab = "Principal component",
     ylab = "Eigenvalue",
     main = "Scree plot (iris PCA)")

# test
broken_stick <- function(p) sapply(1:p, function(k) sum(1/(k:p)) / p)
bs <- broken_stick(ncol(iris_num))

retain <- data.frame(
  PC = paste0("PC", 1:length(pve)),
  ObservedPVE = round(pve, 3),
  BrokenStick = round(bs, 3),
  Keep = pve > bs
)
retain

#Interpretation 
head(pca$x)
pca$rotation

#plot pca
scores <- as.data.frame(pca$x)
scores$Species <- iris_species

plt <- ggplot(scores, aes(PC1, PC2, color = Species)) +
  geom_point(size = 2.6, alpha = 0.85) +
  theme_minimal() +
  labs(title = "PCA on iris", subtitle = "PCA is unsupervised; species used only for coloring")

plt + stat_ellipse() # 95% CI

#test group separation after pca
man <- manova(cbind(PC1, PC2) ~ Species, data = scores)
summary(man, test = "Pillai")


##############
#Random Forest

#train and test
set.seed(42)
id_train <- sample(seq_len(nrow(iris)), size = 0.7 * nrow(iris))
train <- iris[id_train, ]
test  <- iris[-id_train, ]

#fit classifier
set.seed(123)
rf <- randomForest(
  Species ~ ., data = train,
  ntree = 500,
  mtry = 2,
  importance = TRUE
)
rf

#evaluate
pred <- predict(rf, newdata = test)
conf <- table(Observed = test$Species, Predicted = pred)
conf

acc <- mean(pred == test$Species)
acc

#OOB error curve
plot(rf, main = "Random forest OOB error vs number of trees")

#variable importance 
importance(rf)
varImpPlot(rf)
