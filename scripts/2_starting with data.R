#clear console: ctrl+L
#clear environment all: rm(list = ls(all=TRUE))     

install.packages("tidyverse")
library(tidyverse)
interviews <- read.csv("data/SAFI_clean.csv")
interviews <- read_csv("data/SAFI_clean.csv")

#Inspecting data frames
interviews
View(interviews)

dim(interviews)
nrow(interviews)
ncol(interviews)
head(interviews, 20)  #first six row by default
tail(interviews)  #last six row

names(interviews)
str(interviews)
summary(interviews)
summary(interviews$rooms)

#Indexing and subsetting data frames
interviews[1,1]
interviews[,1]  #first column
interviews[1,]  #first row
interviews[1]   #first column
interviews[,1:6]  #first six column
interviews[,-1]   #exclude first column
interviews[-c(1:5),]

interviews["village"]       # Result is a data frame
interviews[, "village"]     # Result is a data frame
interviews[["village"]]     # Result is a vector
interviews$village          # Result is a vector

interviews[interviews$no_membrs == 10,]  #return specific value

#exercise
interview_100 <- interviews[100,]
tail(interviews,1)
interview_last <- interviews[nrow(interviews),]
interview_middle <- interviews[nrow(interviews)/2,]
interview_head <- interviews[-c(7:nrow(interviews)),]  #commas is necessary

#Factors 
#(represent categorical data)

respondent_floor_type <- factor(c("earth", "cement", "cement", "earth"))
levels(respondent_floor_type)
nlevels(respondent_floor_type)
respondent_floor_type <- factor(respondent_floor_type,levels = c("earth","cement"))  #change the order of factor
levels(respondent_floor_type)

levels(respondent_floor_type)[2] <- "brick"
levels(respondent_floor_type)
respondent_floor_type

#Converting factors
as.character(respondent_floor_type)

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
class(year_fct)
as.numeric(year_fct)
as.character(year_fct)
as.numeric(as.character(year_fct))
as.numeric(levels(year_fct))
as.numeric(levels(year_fct))[year_fct]

#renaming factors
## create a vector from the data frame column "memb_assoc"
memb_assoc <- interviews$memb_assoc
## convert it into a factor
memb_assoc <- as.factor(memb_assoc)
## let's see what it looks like
memb_assoc
## bar plot of the number of interview respondents who were
# members of irrigation association:
plot(memb_assoc)

## Let's recreate the vector from the data frame column "memb_assoc"
memb_assoc <- interviews$memb_assoc
## replace the missing data with "undetermined"
memb_assoc[NULL] <- "undetermined"    #???
## convert it into a factor
memb_assoc <- as.factor(memb_assoc)
## let's see what it looks like
memb_assoc
plot(memb_assoc)



#Formatting Dates
install.packages("lubridate")
library(lubridate)
date <- "august,1,2018"
mdy(date)

dates <- interviews$interview_date
day(dates)
month(dates)
year(dates)

interviews$day <- day(dates)
interviews$month <- month(dates)
interviews$year <- year(dates)



