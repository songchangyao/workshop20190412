rm(list = ls(all=TRUE))

library(tidyverse)

interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")

#Selecting columns and filtering rows
select(interviews,village,no_membrs,years_liv)  #取列
filter(interviews,village=="God")     #取行

#pipe
filter(interviews, village == "God")
select(interviews2, no_membrs, years_liv)

interviews_god <- select(filter(interviews, village == "God"), no_membrs, years_liv)

interviews_god1 <- interviews %>%
  filter(village == "God") %>%
  select(no_membrs, years_liv)

interviews %>% 
  filter(memb_assoc=="yes") %>% 
  select(affect_conflicts,liv_count,no_meals)

#mutate
interviews %>%
  mutate(people_per_room = no_membrs / rooms)

interviews %>%
  filter(memb_assoc!="NULL") %>%
  mutate(people_per_room = no_membrs / rooms)

interviews %>% 
  mutate(total_meals= no_membrs*no_meals) %>% 
  filter(total_meals>20) %>% 
  select(village,total_meals)

#Split-apply-combine data analysis and the summarize() function

interviews %>% 
  group_by(village) %>%
  summarize(mean_no_membrs=mean(no_membrs))

interviews %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(memb_assoc!="NULL") %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs), 
            min_membrs = min(no_membrs)) %>%
  arrange(min_membrs)

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs)) %>%
  arrange(desc(village, min_membrs))     #可以按多变量排序

##count
interviews %>%
  count(village)
interviews %>%
  count(village, sort = TRUE)

#exercise
interviews %>% 
  count(no_membrs)
interviews %>% 
  count(no_meals==2)
interviews %>% 
  count(no_meals==3)
unique(interviews$no_meals)

interviews %>%
  group_by(village) %>% 
  summarize(mean_no_membrs=mean(no_membrs),
            min_no_membrs=min(no_membrs),
            max_no_membrs=max(no_membrs),
            n=n())      #计数函数 n()

date <- interviews$interview_date
interviews %>%
  mutate(month = month(date),
         day = day(date),
         year = year(date)) %>%
  group_by(year, month) %>%
  summarize(max_no_membrs = max(no_membrs))   #~


#Reshaping with gather and spread
interviews_spread <- interviews %>%
  mutate(wall_type_logical = TRUE) %>%
  spread(key=respondent_wall_type, value = wall_type_logical, fill = FALSE)

interviews_gather <- interviews_spread %>%
  gather(key = respondent_wall_type, value = "wall_type_logical",
         burntbricks:sunbricks)

interviews_gather <- interviews_spread %>%
  gather(key = "respondent_wall_type", value = "wall_type_logical",
         burntbricks:sunbricks) %>%
  filter(wall_type_logical=="TRUE") %>%   #or filter(wall_type_logical)
  select(-wall_type_logical)



#Applying spread() to clean our data
interviews_items_owned <- interviews %>%
  mutate(split_items = strsplit(items_owned, ";")) %>%
  unnest() %>%
  mutate(items_owned_logical = TRUE) %>%
  spread(key = split_items, value = items_owned_logical, fill = FALSE)
nrow(interviews_items_owned)

interviews_items_owned <- interviews_items_owned %>%
  rename(no_listed_items = `<NA>`)

interviews_items_owned %>%
  filter(bicycle) %>%
  group_by(village) %>%
  count(bicycle)

interviews_items_owned %>%
  mutate(number_items = rowSums(select(., bicycle:television))) %>%
  group_by(village) %>%
  summarize(mean_items = mean(number_items))

#Exporting data

interviews_plotting <- interviews %>%
  ## spread data by items_owned
  mutate(split_items = strsplit(items_owned, ";")) %>%
  unnest() %>%
  mutate(items_owned_logical = TRUE) %>%
  spread(key = split_items, value = items_owned_logical, fill = FALSE) %>%
  rename(no_listed_items = `<NA>`) %>%
  ## spread data by months_lack_food
  mutate(split_months = strsplit(months_lack_food, ";")) %>%
  unnest() %>%
  mutate(months_lack_food_logical = TRUE) %>%
  spread(key = split_months, value = months_lack_food_logical, fill = FALSE) %>%
  ## add some summary columns
  mutate(number_months_lack_food = rowSums(select(., Apr:Sept))) %>%
  mutate(number_items = rowSums(select(., bicycle:television)))

write_csv(interviews_plotting, path = "data_output/interviews_plotting.csv")





