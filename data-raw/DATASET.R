## code to prepare `DATASET` dataset goes here
library(tidyverse)
AstrosCheating<- readr::read_csv("astros_bangs_20200127.csv"
) %>%
  janitor::clean_names() %>%
  rename(
    opponent_runs = final_away_runs, #Opponent is always away team
    astros_runs = final_home_runs, #Astros are always home team
    number_bangs = bangs #Number of bangs on trash can
  ) %>%
  mutate(number_bangs = parse_number(number_bangs), #Only want number
         number_bangs = as.numeric(number_bangs), #Make it numeric
         game_date = lubridate:: dmy(game_date))
#Replace NAs with 0 for number_bangs
AstrosCheating$number_bangs<- replace(AstrosCheating$number_bangs,
                                    is.na(AstrosCheating$number_bangs), 0)
#Select the 10 variables for further analysis
AstrosCheating <- AstrosCheating %>%
  select(astros_runs, at_bat_event, batter, description, game_date, has_bangs,
         inning, opponent_runs, number_bangs, pitch_category)
usethis::use_data(AstrosCheating)
