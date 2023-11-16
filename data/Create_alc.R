# Moona Partanen / 7.11.2023 / Assignment 3: data wrangling

# installing needed packages

install.packages("boot")
install.packages("readr")


# reading the data to R

math <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/student-mat.csv", sep=";", header=TRUE)
por <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/student-por.csv", sep=";", header=TRUE)

# access the dplyr package
library(dplyr)

# columns that vary in the data sets

free_cols <- c("failures","paid","absences","G1","G2","G3")

# columns that are the same

join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# observing the data

dim(math_por)
str(math_por)

# getting rid of the duplicates with a loop

alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col}}


# checking the data 

glimpse(alc)

# adding the new columns for the alcohol use

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2) 


dim((alc))

# saving the data

alc %>%  write.csv("alc.csv")
