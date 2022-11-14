library('doBy')
library('lattice')
library('dplyr')
library('tidyverse')
library(data.table)

health_rec <- read.table('https://raw.githubusercontent.com/xrander/Health-data/master/Health_data.csv',
           header = T,
           sep = ',',
           na.strings = NA,
           dec = '.',
           strip.white = T)

health_rec <- setDT(health_rec)
#Data Explorartion
View(health_rec)

str(health_rec) # data structure

summary(health_rec) # quick statistics

# some of the columns is having NA's and they've been removed
nrow(health_rec)

# Dealing with NA's for outcome
health_rec[is.na(health_rec$outcome),]

health_rec <- health_rec[!is.na(health_rec$outcome),] #removing the missing outcome data

length(health_rec$outcome) #There is no missing data again in the part of the outcome.
# The data have reduced to 1176 from 1177

#Data transformation
# some data are categorical data and they've been changed to factor type of data

health_rec$outcome  <-as.factor(health_rec$outcome)
health_rec$gender <- as.factor(health_rec$gender)
health_rec$COPD <- as.factor(health_rec$COPD)
health_rec$Renal_failure <-as.factor(health_rec$Renal_failure)
health_rec$hypertensive <- as.factor(health_rec$hypertensive)
health_rec$atrialfibrillation <- as.factor(health_rec$atrialfibrillation)
health_rec$CHD_with_no_MI <- as.factor(health_rec$CHD_with_no_MI)
health_rec$diabetes <- as.factor(health_rec$diabetes)
health_rec$deficiencyanemias <- as.factor(health_rec$deficiencyanemias)
health_rec$depression <- as.factor(health_rec$depression)
health_rec$Hyperlipemia <- as.factor(health_rec$Hyperlipemia)
health_rec$Renal_failure <- as.factor(health_rec$Renal_failure)

# Assigning values to codes
health_rec$outcome <- ifelse(health_rec$outcome == '0', 'Alive', 'Dead')
health_rec$gender <- ifelse(health_rec$gender == '1', 'Male', 'Female')

# QUESTIONS

# Question 1: Which age is the most in the hospital?
sort(table(health_rec$age), decreasing = T)
# Visuals
barplot(sort(table(health_rec$age), decreasing = T),
        col = 'blue',
        main = 'Age distribution of patients',
        horizontal = FALSE,
        ylim = c(0, 160),
        ylab = 'Number of patients',
        xlab = 'Age of Patients')

## ANSWER: Patients that are 89 years of age are the highest.

# - Question 1b: Which age group is the most in the hospital?
breaks <- seq(from = 1, to = max(health_rec$age), by = 10) #this starts 
#at the lowest age and ends at the lowest
  
age_interval <- cut(health_rec$age, breaks = breaks,
                    right = FALSE,
                    include.lowest = TRUE) # this makes the class interval from the list
age_group <- cbind(data.frame(age_interval))

age_groups <- sort(table(age_interval), decreasing = T) # generating frequency table


barchart(age_groups,
         horizontal = FALSE,
         xlab = 'Age_interval',
         ylab = 'Frequency',
         ylim = c(0, 450),
         col = 'red')
## Patients between the age 81 to 91 are the highest in the hospital with age 89 been the highest


#which age group of patients dies more in the hospital?
health_rec[ ,c("outcome", "age")]
dead_patients <- health_rec[outcome == "Dead",c("outcome","age","gender") ]

barchart(age~gender, data = dead_patients,
         group = age,
         name)


sort(table(health_rec$outcome), decreasing = T)
         

health_rec[,4]

health_rec %>% outcome %>% summarize()

