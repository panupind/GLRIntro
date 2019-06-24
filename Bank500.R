input.data <- Bank500
str(input.data)
str(input.data)
summary(input.data)
NROW(input.data)
NCOL(input.data)
head(input.data,6)

tail(input.data,6)

summary(input.data$contact)
str(input.data$contact)

class(input.data$contact)
contact.factor <- factor(input.data$contact)
contact.factor
str(contact.factor)


input.data$age

names(input.data)

attach(input.data)


age_below_40 <- subset(input.data , input.data$age <= 40)

age_below_40

NROW(age_below_40)


class(age_below_40)

age_below_40[order(age_below_40$age, decreasing =  TRUE),]

hist(input.data$age)


barplot(table(input.data$marital))


plot(input.data$duration, input.data$balance, main = "Duration Vs Balance", 
     xlab = "Duration", ylab = "Balance")

ggplot(input.data, aes(x = input.data$balance)) +       ## Simple Box Plot - Midsize has high variance
  geom_boxplot()


boxplot(input.data$balance, horizontal = TRUE)
p <- ggplot(input.data, aes(input.data$balance))



#ggplot(input.data$balance) + geom_boxplot()


#ggplot(input.data, aes(x = input.data$balance, y = input.data$job, fill = Type)) + geom_boxplot() +  guides(fill = FALSE)

#ggplot(df, aes(x)) + geom_boxplot( aes(ymin = y0, lower = y25, middle = y50, upper = y75, ymax = y100), stat = "identity")

#example("geom_boxplot")

boxplot(input.data$balance,data= input.data, main="Balance", 
        xlab="Balance")


boxplot(input.data$balance~input.data$job,data= input.data, main="Balance Vs Job", 
        xlab="Balance" , ylab = "Job"  )
library(ggplot2)

qplot(education , balance , data = input.data)

qplot(age , balance , data = input.data)


qplot(age , balance , color= housing ,  data = input.data)


means = tapply(input.data$balance, input.data$numMonth, mean)

barplot(means, xlab = "Month", ylab = "Average Balance", main = "Monthly Average Balance")
