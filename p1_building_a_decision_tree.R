library(rpart)
load(file = "datafiles/GCDData.RData") # load your data to be analysed
#designig a simple model
model <- rpart(Good.Loan ~
                 Duration.in.month + 
                 Installment.rate.in.percentage.of.disposable.income -
                 Other.installment.plans,
               data = d,
               control = rpart.control(maxdepth = 4),
               method = "class"
               )

#we use resultFrames now to create a confusion matrix where:
## rows -> actual loan status
## collumns -> predicted loan status
## diagonal -> correct predictions
resultFrames <- data.frame(Good.Loan = creditdata$Good.Loan,
                           pred = predict(model, type="class"
                                          )
                           )
rtab_variable <- table(resultFrames)

print(rtab_variable) # display predictions

print(sum(diag(rtab_variable)) / sum(rtab_variable)) # overall model accuracy
print(sum(rtab_variable[1,1]) / sum(rtab_variable[ ,1])) # model precision
print(sum(rtab_variable[1,1]) / sum(rtab_variable[1, ])) # model recall
print(sum(rtab_variable[2,1]) / sum(rtab_variable[2, ])) #false positives