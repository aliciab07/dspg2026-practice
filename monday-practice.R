# R Practice DSPG 2026
# Alicia Bacani
# 2026-06-01

2+4*2
library(tidyverse)

#download data

download.file(
  "https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI_clean.csv",
  "data-raw/SAFI_clean.csv", mode = "wb"
)

#read data in 
interviews <- read_csv(
  file="data/SAFI_clean.csv", 
  na = "NULL"
)

class(interviews)
glimpse(interviews)
head(interviews)
tail(interviews)
summary(interviews)
str(interviews)
str(interviews$liv_count)

#starts reading numbers with 1 instead of 0
interviews[1,1] #[rows, columns]
interviews[1:3, 5]
interviews[, 1:3]
interviews[, -1]

#accessing variables by name 
interviews$village
interviews["village"]

area_hectares <- 1.0
area_acres <- area_hectares*2.47
area_hectares <- 2.5 #does not update

round(3.14159)
args(round)
?round
round(3.14159, digits=2)
round(3.14159, digits=-1)
round(42, digits=-1)

hh_members <- c(3,7,10,6)
respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
key_id <- c("1", "2", "3")
# key_id<-[1]+key_id[2]
hh_members[1:2]
hh_members[(length(hh_members)-2):length(hh_members)]

hh_members <- c(hh_members, "NULL")
# hh_members <- (3,7,10,6)
logi_vec <- c(TRUE, FALSE, TRUE)
c(1, logi_vec)
c("word",logi_vec)
hh_members <- c(hhmembers, NA)
NaN #missing (not a number)

mean(c(1,2,3))
mean(hh_members)
mean(hh_members, na.rm=TRUE)
max(hh_members, na.rm=TRUE)
hh_members[!is.na(hh_members)]
na.omit(hh_members)

# alphabetically ordering things
respondent_floor_type <- factor(c("earth", "cement", "cement", "earth"))
levels(respondent_floor_type)
respondent_floor_type

# telling the program that's how you want things to be ordered
days_of_week <- factor(
  c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"), 
  levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"),
  ordered=TRUE
  )

# as.character(days_of_week)
# as.numeric(days_of_week)
# hh_fact <- factor(hh_members)
# as.numeric(hh_fact)
as.numeric(as.character(hh_fact))

dates <- interviews$interviews_date
str(dates)
interviews$day <- day(dates)
interviews$month <- month(dates)
interviews$year <- year(dates)
dates[1]+30 #30 secs
dates[1]+months(1) #adds 1 month

# interviews$interview_date <- interviews$interview_date+years(1)


interviews <- read_csv("data/SAFI_clean.csv")

# Getting Started ---------------------------------------------------------

#dplyr ----

interviews <- read_csv(
  file = "data/SAFI_clean.csv", 
  na = "NULL"
)

#select
select(interviews, village, no_members, months_lack_food, memb_assoc)

#filter
filter(interviews, 
       village=="Chirodzo",
       rooms > 1,
       no_meals > 2)
# | = or

interviews |>
  select(-key_ID) |>
  filter(village=="Chirodzo" & rooms > 1)

#mutate creates new columns based on existing columns
interviews |>
  mutate(people_per_room =no_membrs / rooms) |>
  glimpse()

#create people per room but only for cases where family is member of an 
# irrigation association (memb_assoc=="yes")

# interviews |>
#   filter(memb_assoc=="yes") |> 
#   select(-memb_assoc) |>
#   mutate(people_per_room =no_membrs / rooms) |>
#   glimpse() 

means_no_memb <- interviews |>
  group_by(village, memb_assoc) |> 
  summarize(mean_no_members = mean(no_membrs),
            .groups = "drop")


# write_csv(x = means_no_memb
#          file = "data/means_no_memb.csv")

  