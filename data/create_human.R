<<<<<<< HEAD
# Moona Partanen / 24.11.2023 / Assignment 4: data wrangling

# reading the data

library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# stuctures and dimensions as well as summaries

str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)

# renaming the variables according the metadata

colnames(hd) <- c("HDI_Rank", "Country", "HDI", "Exp_Life", "Exp_Educ", "Mean_Educ",
                  "GNI", "GNI_HDI")

colnames(gii) <- c("GII_Rank", "Country", "GII", "Mort_ratio", "ABR", "PRP",
                   "edu2F", "edu2M", "labF", "labM")


# creating new variables for gender inequality

library(dplyr)
gii <- mutate(gii, edu2_ratio = edu2F/edu2M, lab_ratio = labF/labM)

# joining the two datasets

human <- inner_join(hd,gii,by=c("Country"))

dim(human)

# the data has 195 observations and 19 variables
# saving the data

write.csv(human, "data/human.csv")
=======
# Moona Partanen / 24.11.2023 / Assignment 4: data wrangling

# reading the data

library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# stuctures and dimensions as well as summaries

str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)

# renaming the variables according the metadata

colnames(hd) <- c("HDI_Rank", "Country", "HDI", "Exp_Life", "Exp_Educ", "Mean_Educ",
                  "GNI", "GNI_HDI")

colnames(gii) <- c("GII_Rank", "Country", "GII", "Mort_ratio", "ABR", "PRP",
                   "edu2F", "edu2M", "labF", "labM")


# creating new variables for gender inequality

library(dplyr)
gii <- mutate(gii, edu2_ratio = edu2F/edu2M, lab_ratio = labF/labM)

# joining the two datasets

human <- inner_join(hd,gii,by=c("Country"))

dim(human)

# the data has 195 observations and 19 variables
# saving the data

write.csv(human, "data/human.csv")
>>>>>>> 81d36a03428906df9c435359b810329906e8f3c8
