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

matxM <- matrix( data = FoodNutrition, nrow = 5 , ncol =5)

matxM
