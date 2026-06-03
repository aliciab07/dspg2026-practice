# Tidying Data
# Alicia Bacani
# June 2, 2026

# scripts -----------------------

library(tidyverse)
library(tidyr)

interviews <- read_csv("data/SAFI_clean.csv", 
                       na = "NULL")

# Mean number of members 
# and the minimum number of members 
# per village & member association
# without NAs in member association

interviews |>
  filter(!is.na(memb_assoc)) |>
  group_by(village, memb_assoc) |>
  summarize(mean_no_membrs = mean(no_membrs),
    min_members = min(no_membrs), 
    .groups = "drop"
  ) 


interviews |>
  filter(!is.na(memb_assoc)) |>
  summarize(mean_no_membrs = mean(no_membrs),
            min_members = min(no_membrs), 
            households = n(), 
            .by = c(village, memb_assoc))


interviews |> 
  count(village, memb_assoc,
        sort = TRUE)


interviews |>
  filter(!is.na(memb_assoc)) |>
  summarize(mean_no_membrs = mean(no_membrs),
            min_members = min(no_membrs), 
            households = n(), 
            .by = c(village, memb_assoc)) |> 
  arrange(desc(households), desc(mean_no_membrs)) # doesn't change data, changes display OF data


## more practice ##

interviews |> 
  filter_out(is.na(memb.assoc))
  mutate(per_room = no_members / rooms) 
  summarize(mean_per_room = mean(per_room), 
            min(per_room), 
            households = n(),
            .by = c(village, memb_assoc)) |>
    arrange(desc(households))
    

  
# new tidy data section ------------------------------------------------------

interviews_items_owned <- interviews |> 
  separate_longer_delim(items_owned, delim = ";") |>
  replace_na(list(items_owned = "no_listed_items")) |> 
  mutate(items_logical = TRUE) |> 
  group_by(key_ID) |> 
  mutate(number_items = if_else(
    condition = items_owned == "no_listed_items", 
    true = 0, 
    false = n()
  )) |> 
  pivot_wider(names_from = items_owned, 
              values_from = items_logical, 
              values_fill = list(items_logical = FALSE)) 
  
interviews_plotting <- interviews_items_owned |>
  separate_longer_delim(months_lack_food, delim = ";") |>
  group_by(key_ID) |> 
  mutate(months_logical = TRUE, 
         numbers_months_lack_food = if_else(
           condition = months_lack_food =="none", 
           true = 0, 
           false = n()
         )) |>
  pivot_wider(names_from = months_lack_food, 
              values_from = months_logical, 
              values_fill = list(months_logical = FALSE))

# save the data ----------------------------------------------------------------

write_csv(interviews_plotting, 
          "data/interviews-plotting.csv")


