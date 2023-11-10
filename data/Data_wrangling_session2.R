# Moona Partanen / 7.11.2023 / Assignment 2: data wrangling


IOSD_data <- read.delim("C:/Users/moonapar/University of Eastern Finland/Kurssit/ODS/IOSD_data.txt")
View(IOSD_data)

# exprlorations of the data

IOSD_data %>% count(gender)
IOSD_data %>% count(gender, Attitude, Age, Points)

# filtering the data

IOSD_data %>% filter(Points > 30)
IOSD_data %>% filter(Points > 30, Attitude > 40)

# more explorations

str(IOSD_data)
summary(IOSD_data)
dim(IOSD_data)

# creating new dataset

d_sm <- IOSD_data$D03+IOSD_data$D11+IOSD_data$D19+IOSD_data$D27
d_ri <- IOSD_data$D07+IOSD_data$D14+IOSD_data$D22+IOSD_data$D30
d_ue <- IOSD_data$D06+IOSD_data$D15+IOSD_data$D23+IOSD_data$D31
Deep <- d_sm+d_ri+d_ue
su_lp <- IOSD_data$SU02+IOSD_data$SU10+IOSD_data$SU18+IOSD_data$SU26
su_um <- IOSD_data$SU05+IOSD_data$SU13+IOSD_data$SU21+IOSD_data$SU29
su_sb <- IOSD_data$SU08+IOSD_data$SU16+IOSD_data$SU24+IOSD_data$SU32
Surf <- su_lp+su_um+su_sb
st_os <- IOSD_data$ST01+IOSD_data$ST09+IOSD_data$ST17+IOSD_data$ST25
st_tm <- IOSD_data$ST04+IOSD_data$ST12+IOSD_data$ST20+IOSD_data$ST28
Stra <- st_os+st_tm

# Joining datasets

New_dataset <- data.frame(Deep, Surf, Stra, IOSD_data$gender, IOSD_data$Age, IOSD_data$Attitude, IOSD_data$Points)
View(New_dataset)

# renaming the variables

library(dplyr)
New_dataset_1 <- New_dataset %>% rename(Gender = IOSD_data.gender, Age = IOSD_data.Age, Attitude = IOSD_data.Attitude, Points = IOSD_data.Points)
View(New_dataset_1)

# scaling the variables

Scaled_data <- data_frame()

# exclusion of the variables with 0 points

Refined_data <- New_dataset_1 %>% filter(Points != 0)
View(Refined_data)


#####################

# NEW TRY!!

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
lrn14$attitude <- lrn14$Attitude / 10


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


# Classify questions
deep <- c(
  "D03", "D11", "D19", "D27", "D07", "D14",
  "D22", "D30","D06",  "D15", "D23", "D31"
)
surf <- c(
  "SU02", "SU10", "SU18", "SU26", "SU05", "SU13",
  "SU21", "SU29", "SU08", "SU16", "SU24", "SU32"
)
stra <- c(
  "ST01", "ST09", "ST17", "ST25",
  "ST04", "ST12", "ST20", "ST28"
)

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

 # Filtering

Final_data <- learning2014 %>% filter(points != 0)
View(Final_data)

# saving the data

write.csv(Final_data)









