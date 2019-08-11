## ===============================================================================================================
## EXPLORATORY DATA ANALYTICS 
## ===============================================================================================================

## REFERENCES:
##  An Introduction to Data Cleaning with R - Edwin de Jonge and Mark Van Der Loo
##    https://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf

data = airquality

## Explore Structure and Summary of Input data
str(data)
summary(data)


## =============================================================================================================
##  Univariate Analysis
## ===============================================================================================================

par(mfrow = c(2,1))

hist(data$Ozone, main = "Ozone Distribution", xlab = "Ozone")
boxplot(data$Ozone, horizontal = TRUE)
boxplot.stats(data$Ozone)

hist(data$Solar.R, main = "Solar.R Distribution", xlab = "Solar.R")
boxplot(data$Solar.R, horizontal = TRUE)
boxplot.stats(data$Solar.R)

hist(data$Wind, main = "Wind Distribution", xlab = "Wind")
boxplot(data$Wind, horizontal = TRUE)
boxplot.stats(data$Wind)

hist(data$Temp, main = "Temp Distribtion", xlab = "Temp")
boxplot(data$Temp, horizontal = TRUE)
boxplot.stats(data$Temp)


## =============================================================================================================
##  Bivariate Analysis
## ===============================================================================================================

plot(data)


## ===============================================================================================================
## EXPLORATORY DATA ANALYTICS - MISSING VALUES TREATMENT
## ===============================================================================================================

##  Options Available:
##    1.  Remove records having missing values
##    2.  Impute values


## For now, we will omit Day and Month which are categorical variables
data1 = data[-c(5,6)]
data1
summary(data1)

## Randomly insert 10 missing values in Wind and Temp columns

n = nrow(data1)
n

set.seed(100)
for(i in 3:ncol(data1)) {
  data1[sample(1:n, 10, replace = FALSE), i] = NA
}

summary(data1)   ## Note 10 Missing values introduced in Wind and Temp

## Let us examine the rows with missing values - Incomplete Rows
data1[!complete.cases(data1),]    

attach(data1)

##  GUIDELINES:
##  A safe maximum threshold for missing values in a particular column is 5%.
##  If missing data for a column > 5%, we need to consider leaving out that variable

## Build a function to calculate percentage of missing values in Columns and Rows
pMiss = function(x){
  sum(is.na(x))/length(x)*100
}

## Find Percentage of missing values in each column
col_miss = apply(data1,2,pMiss)  ## 2 is for Columns
col_miss

## OBSERVATIONS:
## Ozone has nearly 25% missing values

## Find Percentage of missing values in each Row
row_miss = apply(data1,1,pMiss)  ## 1 is for Rows
row_miss

## OBSERVATIONS:
## Row 5 has 50% missing variables - will not be of much value
data1[5,]

## Identify rows with high missing values
high_miss_rows = data1[row_miss > 25,]
high_miss_rows   ## 10 Rows have more than 25% missing values
nrow(high_miss_rows)

## Keep only the rows with less than 30% missing values
low_miss_rows = data1[row_miss < 30,]
low_miss_rows
nrow(low_miss_rows)


install.packages("mice")
## Using mice package
library(mice)
md.pattern(data1)

## IMPUTING MISSING VALUES USING mice PACKAGE
## If any variable contains missing values, the mice package regresses 
##   it over the other variables and predicts the missing values. 
##   Some of the available models in mice package are:
##    *  PMM (Predictive Mean Matching) - suitable for numeric variables
##    *  logreg(Logistic Regression) - suitable for categorical variables with 2 levels
##    *  polyreg(Bayesian polytomous regression) - suitable for categorical variables with more than or equal to two levels
##    *  Proportional odds model - suitable for ordered categorical variables with more than or equal to two levels


## NOTE: FOR THIS EXERCISE, WE ARE USING data1 DATASET WITH 153 ROWS - NOT low_miss_rows!!!!
data_imputes = mice(data1, m = 5, maxit = 7, seed = 500)   
## m: Number of times model should run, maxit: Max number of iterations

summary(data_imputes)

## Methods mice used for imputing
data_imputes$method

##    Since only numeric variables had missing values, mice used pmm method 

## What are the values determined for each variable?
data_imputes$imp

## Now let us first examine the values mice determined for Ozone
data_imputes$imp$Ozone

## Before inserting the values, let us look at rows 5, 10 and 25 - They all have missing values
data1[c(5,10,25),]

## Which of the 5 datasets created should we use?
stripplot(data_imputes, pch = 20, cex = 1.2)

## OBSERVATIONS:
##  For Temp, Iteration 3 and 4 is the one with most imputed values in the middle 
##    which does not fit well with observed values - we can therefore ignore the 3rd imputed dataset

library(funModeling)  ## Ref: https://blog.datascienceheroes.com/exploratory-data-analysis-data-preparation-with-funmodeling/

plot_num(data)  ## Overall Iteration 5 fits the original distribution the closest

## Impute Data using 'complete' function from mice package
imputed_data = complete(data_imputes, 5)

## Let us look at the same rows 5, 10 and 25
imputed_data[c(5,10,25),]

data[c(9,25,31,40,48,55,60), -(5:6)]   ## Original Data without Month and Day columns

data1[c(9,25,31,40,48,55,60),]         ## Data with Randomly inserted missing values

imputed_data[c(9,25,31,40,48,55,60),]     ## Data with Imputation for missing values

summary(data)

summary(imputed_data)

## Inspecting distribution of original and imputed data
#xyplot(data_imputes, Ozone ~ Wind + Temp + Solar.R, 
#       pch = 18, cex =1)

densityplot(data_imputes)

## OBSERVATIONS:
## Red lines - Density of imputed data for each imputed dataset
## Blue line - Density of observed data 
## We expect the Red and Blue distributions to be similar
##  - Ozone and Wind has similar patterns for Red and Blue lines 
##  - Temp has similar patterns for Red and Blue lines - However Observed data (Blue)
##             has more variation than some of the Imputed datasets
##  - For Solar.R, imputed values for 4 datasets are close to Observed - Can ignore the other imputed dataset


## ==========================================================================================
## MISING VALUE TREATMENT USING KNN METHOD FROM VIM PACKAGE
## ==========================================================================================

summary(data[,3:4])  ## Dataframe with no missing values for Wind and Temp

summary(data1[,3:4]) ## Dataframe with missing values introduced for Wind and Temp

data1[!complete.cases(data1[,3:4]),]


library(VIM)

## Impute missing values using KNN method
data2 = kNN(data1)

summary(data2)

data[c(9,25,31,40,48,55,60), -(5:6)]   ## Original Data without Month and Day columns

data1[c(9,25,31,40,48,55,60),]         ## Data with Randomly inserted missing values

data2[c(9,25,31,40,48,55,60),1:4]      ## Data with Imputation for missing values

plot_num(data[,1:4])

plot_num(data2)


## =====================================
## Working with Messy Data
## =====================================

## Let us create a dataset with outliers
age = c(21,2,18,221,34)
group = c("adult","child","adult","elderly","child")
height = c(6.0, 3,5.7,5, -7)
status = c("single", "married", "married","widowed", "married")
yearsmarried = c(-1,0,20,2,3)

## Build a dataframe using the vectors created above
people = data.frame(age,group,height,status,yearsmarried)
people

## OBSERVATIONS:
##   yearsmarried cannot be negative
##   A 2 year old child cannot be married
##   An 18 year old adult cannot be married for 20 years
##   221 year old married for 2 years???!!!
##   34 year old Child who is -7 ft tall??

library(editrules)

## Set Age Rule
E_age = editset(c("age >= 0", "age <= 120"))

## Which records violate the Age Rule?
violatedEdits(E_age,people)   ## Record 4 violates the second age rule <=120

## All Rules can be maintained on an external Text File
E_file = editfile("EDA_Rules_Edit.txt")

rule_violations = violatedEdits(E_file, people)

people

rule_violations

plot(rule_violations)

## Graph showing interconnection between Variables and Restrictions
plot(E_file)

## OBSERVATIONS:
##    - Two cases of Categorical violations involving Group and Status
##        - If status == 'married', group should be 'adult' or 'elderly'
##        - Rule violated in records 2 and 5
##    - Two cases of Mixed Rules violations involving Status, YearsMarried and Age
##        - If status == 'married', age - yrsMarried >= 17
##        - Rule violated in records 2 and 3


## ====================================================================================
## WORKING WITH DIFFERENT UNITS
## ====================================================================================

name = c("A","B","C","D","E")
height = c(170.00,1.74, 70.00, 168.00, 5.91)
unit = c("cm","m","inch","cm","ft")

physical = data.frame(name,height,unit)
physical

library(deducorrect)

## Convert all values into Meters ("m")
R = correctionRules("Length_Convertions.txt")
R

## Apply correction rules to data
cor = correctWithRules(R, physical)
cor

cor$corrected

## *****************************************
## Working with Dates - Also covered in Intro to R
## *****************************************

## In R, Dates and Times are captured using POSIXct (Continuous Time - Number of seconds) and POSIXlt (List Time)
## Base Date: 1 January 1970

Sys.time()

class(Sys.time())

time.list = as.POSIXlt(Sys.time())
unlist(time.list)

y <- strptime("01/02/2018",format="%d/%m/%Y")
y

weekdays(y)    ## Find day of the week

y$wday         ## Thursday is fourth day of the week

## R is clever with dates!!
start_end_dates = c("2016 2 Mon", "2017 6 Fri", "2018 10 Tue")  ## Mon of Week 2, Fri of Week 6 and Tue of Week 10
strptime(start_end_dates, format = "%Y %W %a")

## Difference between two dates
difftime("2014-02-06", "2016-08-15")
as.numeric(difftime("2014-02-06", "2016-08-15"))

## Generating Sequence of dates from 2015-11-04 to 2015-11-15 incrementing by 1 day
dates.seq = seq(as.POSIXlt("2015-11-04"), as.POSIXlt("2015-11-15"), "1 day")
dates.seq
class(dates.seq)

dates.seq1 = seq(as.POSIXlt("2015-11-04"), by = "day", length = 11)
dates.seq1
class(dates.seq1)

## Working with Dates using Lubridate package

library(lubridate)

dates = c("15/12/2013", "15 December 13", "It happened on 15 02 '13")

dmy(dates)  ## All dates above converted to common format!!

## How does R know whether it is 1913 or 2013??
##  Years 00 to 68 will be 20xx
##  Years 69 to 99 will be 19xx

## Other limitations
dmy("15 Feb 2018")

dmy("15 Febr 2018")   ## Error since POSIX standard expects Feb and not Febr

## ======================================================================================
## CHARACTER MANIPULATION USING stringr PACKAGE
## ======================================================================================

## CHARCTER MANIPULATION INCLUDES:
##  - Remove pre-pending or trailing white spaces
##  - Pad strings to certain width
##  - Transform to upper/lower case
##  - Search for strings containing certain patterns (substrings)
##  - Approximate matching procedures based on string distances

library(stringr)

## Remove white spaces before and after text
str_trim("   hello world  ")   

## Remove white spaces left of text 
str_trim("   hello world  ", side = "left")   

## Remove white spaces right of text 
str_trim("   hello world  ", side = "right")   

## Add spaces before text
str_pad("hello world", width = 20, side = "left", pad = " ")  # width is total length including padding

## Add zeros before numbers
str_pad(112, width = 6, side = "left", pad = 0)   # Padding numbers for fields like IDs

## Convert string to ALL CAPS
toupper("hello world")

## Convert string to all lower
tolower('HELLO WORLD')

## ========================================================================================
## Approximate String Matching
## ========================================================================================

gender = c("M", "male","F", "Female", "fem.")

## Find all values with "m" in gender
grepl("m", gender)  # Gives logical output

grep("m", gender)   # Gives row or position number

## Ignore case "M" and "m" should be treated the same
grepl("m", gender, ignore.case = TRUE)  # Gives logical output

grep("m", gender, ignore.case = TRUE)   # Gives row or position number

## Look for any value that starts with "M" or "m"
grepl("^m", gender, ignore.case = TRUE)  # Notice ^ before the seach parameter

## Working with Special Characters
gender = c("M", "male","F", "Female", "fem.","Male**","F+","male/")

grepl("+", gender, fixed = TRUE)  # Search for '+'
grepl(".", gender, fixed = TRUE)  # Search for '.'
grepl("*", gender, fixed = TRUE)  # Search for '*'

