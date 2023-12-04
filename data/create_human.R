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


# continuing the human data wrangling 

human <- read.csv("data/human.csv")

# Structures and dimensions
str(human)
dim(human)
human

# Original data from: http://hdr.undp.org/en/content/human-development-index-hdi
# Data have following variables
# "Country" = Country name

# # Health and knowledge
# "HDI_Rank" = Human development index rank
# "HDI" = Human development index
# "Exp_Life" = Life expectancy at birth
# "Exp_Educ" = Expected years of schooling
# "Mean_Educ" = Mean years of education
# "GNI" = Gross National Income per capita
# "GNI_HDI" = GNI per capita rank - HDI rank
# "GII_Rank" = Gender inequality index rank
# "GII" = Gender inequality index
# "Mort_ratio" = Maternal mortality ratio
# "ABR" = Adolescent birth rate

# # Empowerment
# "PRP" = Percetange of female representatives in parliament
# "edu2F" = Proportion of females with at least secondary education
# "edu2M" = Proportion of males with at least secondary education
# "labF" = Proportion of females in the labour force
# "labM" " Proportion of males in the labour force
# "edu2_ratio" = Edu2.F / Edu2.M
# "lab_ratio" = Labo2.F / Labo2.M


# Excluding some of the variables

match <- c("Country", "edu2_ratio", "lab_ratio", "Exp_Life", "Exp_Educ", "GNI", "Mort_ratio", "ABR", "PRP")
human <- select(human, one_of(match))

# removing missing values

complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))

# excluding areas

tail(human_, 12) # 7 last are not countries but areas instead
last <- nrow(human_) - 7
human_ <- human_[1:last, ]
dim(human_) # 155 countries left

# choosing only countries by rownames

rownames(human_) <- human_$Country
human <- human_[, -1]
dim(human) # 155 observations in 8 coutries

# saving the wrangling

write.csv(human, "data/human.csv", row.names = T)
