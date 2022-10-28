library(class)
library(ISLR)
library(MASS)
library(e1071)
library(caret)
?cancer_train.csv
v<-t(data.frame(as.numeric(colnames(cancer_train))))
colnames(v)<-c("Radius","Texture","Perimeter","Area","Smoothness","Compactness","Concavity","Concave_points","Symmetry","Fractal_dimension","Radius_se","Texture_se","Perimeter_se","Area_se","Smoothness_se","Compactness_se","Concavity_se","Concave_points_se","Symmetry_se","Fractal_dimension_se","Radius_e","Texture_e","Perimeter_e","Area_e","Smoothness_e","Compactness_e","Concavity_e","Concave_points_e","Symmetry_e","Fractal_dimension_e")
  colnames(cancer_train) <- c("Radius","Texture","Perimeter","Area","Smoothness","Compactness","Concavity","Concave_points","Symmetry","Fractal_dimension","Radius_se","Texture_se","Perimeter_se","Area_se","Smoothness_se","Compactness_se","Concavity_se","Concave_points_se","Symmetry_se","Fractal_dimension_se","Radius_e","Texture_e","Perimeter_e","Area_e","Smoothness_e","Compactness_e","Concavity_e","Concave_points_e","Symmetry_e","Fractal_dimension_e")
cancer_train<-data.frame(rbind(v,cancer_train))
?label_train.csv
n<-t(data.frame(as.character(colnames(label_train))))
colnames(n)<-c('class')
colnames(label_train)<-c('class')
label_train<-data.frame(rbind(n,label_train))
cancer_train<-cbind(cancer_train,label_train)
View(cancer_train)
cancer_train$class<-ifelse(cancer_train$class=='B',0,1)
?cancer_test.csv
k<-t(data.frame(as.numeric(colnames(cancer_test))))
colnames(k)<-c("Radius","Texture","Perimeter","Area","Smoothness","Compactness","Concavity","Concave_points","Symmetry","Fractal_dimension","Radius_se","Texture_se","Perimeter_se","Area_se","Smoothness_se","Compactness_se","Concavity_se","Concave_points_se","Symmetry_se","Fractal_dimension_se","Radius_e","Texture_e","Perimeter_e","Area_e","Smoothness_e","Compactness_e","Concavity_e","Concave_points_e","Symmetry_e","Fractal_dimension_e")
colnames(cancer_test) <- c("Radius","Texture","Perimeter","Area","Smoothness","Compactness","Concavity","Concave_points","Symmetry","Fractal_dimension","Radius_se","Texture_se","Perimeter_se","Area_se","Smoothness_se","Compactness_se","Concavity_se","Concave_points_se","Symmetry_se","Fractal_dimension_se","Radius_e","Texture_e","Perimeter_e","Area_e","Smoothness_e","Compactness_e","Concavity_e","Concave_points_e","Symmetry_e","Fractal_dimension_e")
cancer_test<-data.frame(rbind(k,cancer_test))
?label_test.csv
l<-t(data.frame(as.character(colnames(label_test))))
colnames(l)<-c('class')
colnames(label_test)<-c('class')
label_test<-data.frame(rbind(l,label_test))
cancer_test<-cbind(cancer_test,label_test)
cancer_test$class<-ifelse(cancer_test$class=='B',0,1)
View(cancer_test)
summary(cancer_train)
#####
### Logit
set.seed(123)
train_x<-cancer_train[,-31]
train_y<-cancer_train['class']
test_x<-cancer_test[,-31]
test_y<-cancer_test['class']
model_logit2<-glm(class~Radius+Texture+Perimeter+Area+Smoothness+Compactness+Concavity+Concave_points+Symmetry+Fractal_dimension+Radius_se+Texture_se+Perimeter_se+Area_se+Smoothness_se+Compactness_se+Concavity_se+Concave_points_se+Symmetry_se+Fractal_dimension_se+Radius_e+Texture_e+Perimeter_e+Area_e+Smoothness_e+Compactness_e+Concavity_e+Concave_points_e+Symmetry_e+Fractal_dimension_e, family = "binomial", data=cancer_train)
summary(model_logit2)
conv_train <- ifelse(predict(model_logit2) > 0.5,1,0)
conf_train<- confusionMatrix(table(conv_train, cancer_train$class), positive = "1")
acc_train<-conf_train$overall['Accuracy']
conv_test<-ifelse(predict(object=model_logit2, newdata=test_x, type="response") > 0.5,1,0)
conf_test <- confusionMatrix(table(conv_test, cancer_test$class), positive="1")
print(conf_train)
acc_test<-conf_test$overall['Accuracy']

#####
### LDA
func<-paste(names(cancer_train)[31], "~", paste(names(cancer_train)[-31],collapse="+"))
model_lda<-lda(as.formula(paste(func)),data=cancer_train)
model_lda_pred<-predict(model_lda)
conf_train_lda<-confusionMatrix(table(model_lda_pred$class,cancer_train$class),positive="1")
acc_train_lda<-conf_train_lda$overall["Accuracy"]
model_lda_pred_t<-predict(object=model_lda,newdata=test_x)
conf_test_lda<-confusionMatrix(table(model_lda_pred_t$class,cancer_test$class),positive="1")
acc_test_lda<-conf_test_lda$overall["Accuracy"]

######
### QDA
func_qda<-paste(names(cancer_train)[31], "~", paste(names(cancer_train)[-31],collapse="+"))
model_qda<-qda(as.formula(paste(func_qda)),data=cancer_train)
model_qda_pred<-predict(model_qda)
conf_train_qda<-confusionMatrix(table(model_qda_pred$class,cancer_train$class),positive="1")
acc_train_qda<-conf_train_qda$overall["Accuracy"]
model_qda_pred_t<-predict(object=model_qda,newdata=test_x)
conf_test_qda<-confusionMatrix(table(model_qda_pred_t$class,cancer_test$class),positive="1")
acc_test_qda<-conf_test_qda$overall["Accuracy"]

#######
### Naive Bayes
model_nb<-naiveBayes(class~Radius+Texture+Perimeter+Area+Smoothness+Compactness+Concavity+Concave_points+Symmetry+Fractal_dimension+Radius_se+Texture_se+Perimeter_se+Area_se+Smoothness_se+Compactness_se+Concavity_se+Concave_points_se+Symmetry_se+Fractal_dimension_se+Radius_e+Texture_e+Perimeter_e+Area_e+Smoothness_e+Compactness_e+Concavity_e+Concave_points_e+Symmetry_e+Fractal_dimension_e,data=cancer_train,method="nb")
model_nb_pred<-predict(model_nb,train_x)
conf_train_nb<-confusionMatrix(table(model_nb_pred,cancer_train$class),positive="1")
acc_train_nb<-conf_train_nb$overall['Accuracy']
model_nb_pred_t<-predict(object=model_nb,newdata = test_x)
conf_test_nb<-confusionMatrix(table(model_nb_pred_t,cancer_test$class),positive="1")
acc_test_nb<-conf_test_nb$overall['Accuracy']
###########
### Testing and Training erros
#logistic
logit_train<-as.numeric((1-(acc_train))*100)
logit_test<-as.numeric((1-(acc_test))*100)
#LDA
lda_train<-as.numeric((1-(acc_train_lda))*100)
lda_test<-as.numeric((1-(acc_test_lda))*100)
#QDA
qda_train<-as.numeric((1-(acc_train_qda))*100)
qda_test<-as.numeric((1-(acc_test_qda))*100)
#NB
nb_train<-as.numeric((1-(acc_train_nb))*100)
nb_test<-as.numeric((1-(acc_test_nb))*100)
##########
Errors<-data.frame("Training Error"=c(logit_train,lda_train,qda_train,nb_train),"Testing Error"=c(logit_test,lda_test,qda_test,nb_test))
row.names(Errors)<-c("Logit","LDA","QDA","NB")
print(Errors)



