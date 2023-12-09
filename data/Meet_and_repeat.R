# Moona Partanen / 08.12.2023 / Assignment 6: data wrangling

# loading the data sets

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

dim(BPRS)
str(BPRS)
names(BPRS)

dim(RATS)
str(RATS)
names(RATS)

# The data is longitudinal data where each variable describes a one measurement following the previous column measurement.
# In BPRS, the treatment is binary data where the subject has had one of the the two treatments following the
# measurements made in weeks 1-8 during the treatment. All the subjects have had both treatments i.e., crossover design.
# In RATS data, the group is the treatment whereas the ID is the subject identification and the WD variables are the measurement values.

# changing the categorical variables, treatment and group, into a factorial variable 

BPRS$treatment <- factor(BPRS$treatment)
RATS$Group <- factor(RATS$Group)

# converting to long form

BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>% arrange(weeks)
RATSL <- pivot_longer(RATS, cols = -c(ID, Group),
                      names_to = "WD", values_to = "rats") %>% arrange(WD)

# adding variables

BPRSL <- BPRSL %>% mutate(week = as.integer(substr(weeks, 5,5)))
RATSL <- RATSL%>% mutate(Time = as.integer(substr(WD, 3, 4))) 

colnames(BPRSL)
colnames(RATSL)

dim(BPRSL) # 360   5
dim(RATSL) # 176   5

# Now in the long format, all the observations are rows and columns are the different factors of the observations, e.g., ID, time and treatment.

# saving the data
write.csv(RATSL, "data/Rats_longitudinal.csv")
write.csv(BPRSL, "data/Bprsl_longitudinal.csv")



