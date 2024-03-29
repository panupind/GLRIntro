x=3
x
y <- x+5
y
m <- "Money"
m
class(m)
v1 <- c(1:10)
v1
class(v1)
str(v1)
v2
class(v2)
str(v2)

strv <- c("Introduction", "To","R")
strv
class(strv)

logV <- c(FALSE, TRUE, TRUE, TRUE, FALSE , FALSE)
logV

class(logV)

# Sequence of numbers from 1 : 15 skipping 2 numbers 

s1 <- seq(from =1 , to = 15 , by=2)
s1

# sequence from 1 : 15 , splittig into 5 parts 
s11 <- seq(from =0 , to=15, length.out = 5)
s11


v.a <- c(1,1,2,3,5)
v.b <- c(1,2,2,3,6)

v.a == v.b

# Display values  1 -> 3 

v.a[1:3]

# Display values at 1st , 3rd , 5th position

v.a[c(1,3,5)]

# Display values other than 3rd pos
v.a[-3]

# Display Values other than 3rd and 5th positions
v.a[c(-3, -5)]

# Vector arithmetic

v.c <- v.a + v.b
v.c

# convert vetor to factor == factor is count  of unique values

factor.v.a <- factor(v.a)
factor.v.a

wday <- c("Sun","mon","tue","wed","thu","fri","sat","thu","tue")
wday.factor <- factor(wday)
wday.factor

class(wday)
class(wday.factor)

summary(wday.factor)


# Speed vector without ordered factors

speed.vector <- c("Fast", "Fast", "Slow","Express","Slow","x-fast")
speed.factor <- factor(speed.vector)
speed.factor


# Speed vector with ordered factors

speed.factor <- factor(speed.vector, ordered = TRUE , levels =c("Slow","Express","Fast","x-fast"))
speed.factor

#installed packages
library()

search()

data()

example(mean)
example("subset")

help(package = MASS)

v3 <- "filler"

dataframe.1 <- data.frame(v.a, v.b , v3)
dataframe.1

str(dataframe.1)

new.row <- data.frame(v.a = 9 , v.b =  9 , v3 = "New Row Added")
new.row
dataframe.2 <- rbind(dataframe.1, new.row)
dataframe.2
str

new.col <- c(10,20,30,40,50)
new.col
dataframe.3 <- cbind(dataframe.1 , new.col)
dataframe.3


names(dataframe.3)
colnames(dataframe.3) <- c("Session","students","topic","new topic")
names(dataframe.3)

nrow(dataframe.3)
ncol(dataframe.3)
dim(dataframe.3)

dataframe.3[3,]
dataframe.3[,2]


dataframe.3$v.b
dataframe.3$v.b[4]

dataframe.3

# 22/6/2019

dataframe.sub1 <- dataframe.3[,1:2]
dataframe.sub1

dataframe.3
dataframe.sub2 <- dataframe.3[,c("Session","students")]
dataframe.sub2

dataframe.sub3 <- subset(dataframe.3, students >= 2)
dataframe.sub3


dataframe.sub4 <- subset(dataframe.3, topic == "filler")
dataframe.sub4


dataframe.3[order(dataframe.3$students),]
dataframe.3[order(dataframe.3$students, decreasing = TRUE),]

library(MASS)
hist(input.data$Price)

hist(input.data$Price , main =  "Price Histogram" , xlab = "Price" , ylab = "count")
hist(input.data$Price , col= c("Red","Blue","Green"),  main =  "Price Histogram" , xlab = "Price" , ylab = "count")

hist(input.data$Price , col= rainbow(6),  main =  "Price Histogram" , xlab = "Price" , ylab = "count")




price.colors <- ifelse(input.data$Price > 25 , "Blue" , "Red")
price.colors


library(ggplot2)
attach(input.data)
plot(input.data$Horsepower, input.data$Price , main="Horsepower Vs Price" , xlab = "Horsepower" , ylab ="Price")

qplot(Cylinders , MPG.city , data = input.data)

qplot(MPG.city , Price , data = input.data)


ggplot(input.data , aes( x= Price))

ggplot(input.data , aes( x= Price)) + 
  geom_histogram(binwidth = 8)

ggplot(input.data , aes( x= Price)) + 
  geom_histogram(binwidth = 8 , colour = "black", fill = "white")


ggplot(input.data , aes( x= Price)) + 
  geom_histogram(binwidth = 8 , color = "black", fill = "white")

ggplot(input.data , aes( x= Type , y  = Price )) + 
  geom_bar()

ggplot(input.data , aes( x= Type , y  = Price )) + 
  geom_bar(stat = "identity")


ggplot(input.data , aes( x= Type , y  = Price ,  fill = Type)) + 
  geom_bar(stat = "identity" , colour = "black")


update.packages("dplyr")
library(dplyr)

mean.price <- input.data%>%
  group_by(Type)
summarise(Price = mean(Price))
mean.price


#ggplot(input.data , aes( x= Type , y  = mean.price ,  fill = Type)) + 
 # geom_bar(stat = "identity" , colour = "black")

install.packages("ggplotgui")


library(ggplotgui)
ggplotgui::ggplot_shiny(Cars93)

install.packages("esquisse")
library(esquisse)


esquisser()
