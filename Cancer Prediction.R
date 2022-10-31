library(MASS) # LDA, QDA
library(naivebayes)

## naivebayes 0.9.7 loaded
train.x <- read.table("cancer.train.csv", header=F, sep=",")
train.label <- read.table("label.train.csv", header=F, sep=",",stringsAsFactors=T)
test.x <- read.table("cancer.test.csv", header=F, sep=",")
test.label <- read.table("label.test.csv", header=F, sep=",",stringsAsFactors=T)
train <- cbind(train.x,train.label)
names(train)[31] <- c("label")
test <- cbind(test.x,test.label)
names(test)[31] <- c("label")

## Fit the model
# Logistic Regression
glm <- glm(label~., data=train, family=binomial)
summary(glm)

# Linear Discriminant Analysis (LDA)
lda <- lda(label~., data=train)
plot(lda)

# Quadratic Discriminant Analysis (QDA)
qda <- qda(label~., data=train)
# Naive Bayes
nb <- naive_bayes(label~., data=train)
plot(nb)
#Training and Testing errors for each of the models
## Logistic
# training error
glm_prob <- predict(glm, train[,1:30],type="response")
glm_pred <- rep("B", dim(train)[1])
glm_pred[glm_prob>0.5] <- "M"
table(glm_pred, train[,31])

glm_trainE <- (0+0)/(293+163)
sprintf("training error for logistic regression: %.4f", glm_trainE)

# testing error
glm_prob <- predict(glm, test[,1:30],type="response")
glm_pred <- rep("B", dim(test)[1])
glm_pred[glm_prob>0.5] <- "M"
table(glm_pred, test[,31])

glm_testE <- (1+4)/(63+45)
sprintf("testing error for logistic regression: %.4f", glm_testE)

## LDA
# training error
lda_pred <- predict(lda, train[,1:30])
table(lda_pred$class, train[,31])

lda_trainE <- (1+15)/(292+148)
sprintf("training error for LDA: %.4f", lda_trainE)

# testing error
lda_pred <- predict(lda, test[,1:30])
table(lda_pred$class, test[,31])

lda_testE <- (0+2)/(64+47)
sprintf("testing error for LDA: %.4f", lda_testE)

## QDA
# training error
qda_pred <- predict(qda, train[,1:30])
table(qda_pred$class, train[,31])

qda_trainE <- (8+3)/(290+155)
sprintf("training error for QDA: %.4f", qda_trainE)

# testing error
qda_pred <- predict(qda, test[,1:30])
table(qda_pred$class, test[,31])

qda_testE <- (1+4)/(60+48)
sprintf("testing error for QDA: %.4f", qda_testE)


## NB
# training error
nb_pred <- predict(nb, train[,1:30])
table(nb_pred, train[,31])

nb_trainE <- (9+16)/(284+147)
sprintf("training error for NB: %.4f", nb_trainE)

# testing error
nb_pred <- predict(nb, test[,1:30])
table(nb_pred, test[,31])

nb_testE <- (4+5)/(59+45)
sprintf("testing error for NB: %.4f", nb_testE)

## Compare four models
comparison <- data.frame(trainError=c(glm_trainE, lda_trainE, qda_trainE, nb_trainE),
                         testError=c(glm_testE, lda_testE, qda_testE, nb_testE))
row.names(comparison) <- c("LR", "LDA", "QDA", "NB")
print(comparison)


