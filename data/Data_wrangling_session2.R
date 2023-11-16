# Moona Partanen / 7.11.2023 / Assignment 2: data wrangling


#reading the data

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)


# scaling the attitude variable 

lrn14$attitude <- lrn14$Attitude / 10


# classifying the questions

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")



deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)


# New variables
deep <- c(
  "D03", "D11", "D19", "D27", "D07", "D14",
  "D22", "D30","D06",  "D15", "D23", "D31")
surf <- c(
  "SU02", "SU10", "SU18", "SU26", "SU05", "SU13",
  "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")
stra <- c(
  "ST01", "ST09", "ST17", "ST25",
  "ST04", "ST12", "ST20", "ST28")

# Compute averages in a loop
for (Qclass in c("deep", "surf", "stra")) {
  lrn14[[Qclass]] <- rowMeans(lrn14[, get(Qclass)])
}
deep

# New dataset
learning2014 <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

learning2014

 # Filtering the data

Final_data <- learning2014 %>% filter(points != 0)
View(Final_data)

# saving the data

Final_data %>%  write.csv("Final_data.csv")









