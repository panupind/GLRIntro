#1 Setwd to the appropriate Dir

setwd("D:/Prasanna/Personal/Learning/Other Reads/GL/Course Material/Intro To R/RProjects/GLIntro")

#2 Import Dataset to xls format

FoodNutrition <- read_excel("D:/Prasanna/Personal/Learning/Other Reads/GL/Course Material/Intro To R/DataSets/Food Nutrition.xlsx")

#3 View top 10 rows of the Data

head(FoodNutrition , 10)

#4 View top 20 rows of the Data

tail ( FoodNutrition , 20)

#5 Show summary of the data

summary(FoodNutrition)

#6 Create vector using top 10 values of protein varriable

attach(FoodNutrition)
names(FoodNutrition)

head(`Protein_(g)`, 10)

vProt <- c(head(`Protein_(g)`, 10))

vProt

#7 matrix of top 5 rows of 5 variables

#matxM <- matrix( data = FoodNutrition, nrow = 5 , ncol =5)

matxM <- head(FoodNutrition,5)[,1:5]

matxM

# 8 class of sodium(_mg)

class(`Sodium_(mg)`)

#9 New variable EPW by divising energy cal with Water

EPW = Energ_Kcal / `Water_(g)`
EPW

NROW(FoodNutrition)
NCOL(FoodNutrition)
dim(FoodNutrition)

EPW_col <- EPW

EPW_col


#10 updated dimension of new dataset

New.FoodNutrition <- cbind (FoodNutrition, EPW_col)

NCOL(New.FoodNutrition)

dim(New.FoodNutrition)

#11 Subset of Dataset where Energy Kcal < 500 

Enerygyless500 <- subset(FoodNutrition , Energ_Kcal < 500)

Enerygyless500
dim(Enerygyless500)

#12 Plot a bar plot between Energy Kcal and Water using new Dataset

Enerygyless500$Energ_Kcal 
str(Enerygyless500$Energ_Kcal)
count(Enerygyless500 )
names(Enerygyless500)


NROW(Enerygyless500$Energ_Kcal)  #564
NROW(Enerygyless500$`Water_(g)`) #564

unique(Enerygyless500$Energ_Kcal)  #242
unique(Enerygyless500$`Water_(g)`) #422

max(unique(Enerygyless500$Energ_Kcal)) #496
max(unique(Enerygyless500$`Water_(g)`) ) #99.9


test.df <- c(Enerygyless500$Energ_Kcal , Enerygyless500$`Water_(g)`)
test.df
dim(test.df)

EKL.factor <- factor(Enerygyless500$Energ_Kcal)
EKL.factor

str(EKL.factor)
class(EKL.factor)
dim(EKL.factor)

WTR.factor <- factor(Enerygyless500$Energ_Kcal)
WTR.factor

str(WTR.factor)
class(WTR.factor)
dim(WTR.factor)

library(plyr)


example(barplot)

library(ggplot2)
max(Enerygyless500$Energ_Kcal)
max(Enerygyless500$`Water_(g)`)


# For bar plot always convert the 2 dimensional into tables
tab.Kcal <- table(Enerygyless500$Energ_Kcal)
tab.Kcal
max(tab.Kcal)
tab.Wtr <- table(Enerygyless500$`Water_(g)`)
tab.Wtr

KcalWtr <- table(Enerygyless500$Energ_Kcal , Enerygyless500$`Water_(g)`, legend = rownames(KcalWtr))

KcalWtr
rownames(KcalWtr) #242
colnames(KcalWtr) #422
dim(KcalWtr)



barplot(KcalWtr , main ="Kcal Vs Water" , xlab =  "KCal" ,  col=c("Blue","Red"))

dim(KcalWtr)




# Histogram of Sugar_tot
hist(Enerygyless500$`Sugar_Tot_(g)`)
