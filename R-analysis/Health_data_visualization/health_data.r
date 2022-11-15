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
health_rec$atrialfibrillation <- ifelse(health_rec$atrialfibrillation == '0', 'Having', 'Not having')
health_rec$depression <- ifelse(health_rec$depression == 0, 'Having','Not having')

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


# Question 2: which age group of patients dies more in the hospital?

dead_patients <- health_rec[outcome == "Dead",c("outcome","age","gender") ]

View(sort(table(dead_patients$age), decreasing = T)) #frequency table for dead patients according to age

  ## Patients at age 89 are the highest to die, with 23 patients dying 


---------------
# Question 3: What is the most prevalent gender in the hospital
gender <- as.data.frame(sort(table(health_rec$gender), decreasing = T)) # This gives a frequency of the genders
  ## Female gender is more prevalent with 618 patients

colnames(gender) <- c('gender','num') #changing column names

# Question 3b: what is the death rate of both gender
gender_dead_count <- as.data.frame(sort(table(dead_patients$gender))) #Frequency for dead patients according to gender
colnames(gender_dead_count) <- c('gender', 'count')

gender[3] <- gender_dead_count$count

names(gender)[3] <- 'dead' # this is similar to using colnames

gender$rate <- gender$dead/gender$num * 100 #rate of death per hundred

  ## the male gender is having more dead rate than female

barplot(gender$rate,
        names.arg = gender$gender,
        xlab = substitute(paste(bold('gender'))),
        ylab = substitute(paste(bold('death rate per hundred'))),
        main = 'Death rate of genders',
        col = c(5,7))

--------------

# Question 4: Gender group with the highest number of death
View(sort(table((dead_patients$gender)), decreasing = T))   #the gender with the 
  ## highest death is male with 80 individuals dead

--------------

# Question 5: how many patients died in the hospital with atrialfibrillation?
dead_patients_atrial <- as.data.frame(health_rec %>% select(outcome, atrialfibrillation) %>% 
  filter(outcome == 'Dead') %>% group_by(atrialfibrillation)%>%
  summarize(length = length(atrialfibrillation)))
  ## 67 patients died having atrialfibrillation

# Question 5b: number of patients that died between the gender having atrialfibrillation
dead_patients_atrial_gender <- as.data.frame(health_rec %>% select(outcome, gender, atrialfibrillation) %>% 
    filter(outcome == 'Dead', atrialfibrillation=='Having') %>%
    group_by(gender) %>%
    summarize(length = length(gender)))
  ## 39 female and 28 male died having atrialfibrillation
gender <- merge(gender, dead_patients_atrial_gender, by = 'gender', all = TRUE) # merging the result to gender table
names(gender)[5] <- 'died_having_atrialfibrilation'

# Question 6: how many patients in the hospital have depression?
View(sort(table(health_rec$depression)))

# Question 6b: show the number of patients having depression that are dead according to gender.
# Question 6c: Show the number of dead patients having or not having depression according to the genders
health_rec %>% select(outcome, gender, depression) %>%
  filter(outcome == 'Dead') %>%
  group_by(gender, depression) %>%
  summarize(depressed = length(depression), m_f = length(gender))



# Question 7:  Is there a correlation between depression and aging?
# Question 8: what is the rate of non-survived patients with hypertension?
# Question 9: Rate of gender with hypertension"
# How many patients with renal failure are alive in the hospital?
# how many patients in the hospital with Hperlipemia are dead?
# how many patients in the hospital with Anemia are dead?
# What is the proportion of survival and non-survival between diabetic and non-diabetic patients
# What is the proportion of survival and non-survival between depressed and non-depressed patients
  # (a) What is the proportion of depressed and non-depressed that survived
  # (b) What is the proportion of depressed and non-depressed that did not survive
