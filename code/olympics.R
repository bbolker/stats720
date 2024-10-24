library(tidyverse)
library(wbstats)

## athlete data from Kaggle ...
## https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results
athletes <- read_csv("athlete_events.csv")
medals <- athletes |>
    filter(Season == "Summer", Year>=2000) |>
    mutate(across(Team, ~ stringr::str_remove(., "-[0-9]+$"))) |>
    count(Team, Year, Medal)|>
    drop_na(Medal) |>
    complete(Team, Year, Medal, fill = list(n=0)) |>
    rename_with(tolower)
    
wbd <- wb_data(c("NY.GDP.MKTP.KD", "SP.POP.TOTL"),
               start_date = 2000, end_date = 2024) |>
    filter(date %in% unique(medals$year))

wbd2 <- wbd |> select(team = country, year = date, gdp = NY.GDP.MKTP.KD,
                      pop = SP.POP.TOTL)

## ugh, matching team names against country names ...
## 'country' matches WB data; 'team' matches Olympic data
match_vals <- read_csv("team_match.csv")


m <- match(wbd2$team, match_vals$country)
wbd3 <- wbd2 |>
    mutate(across(team,
                  ~ ifelse(is.na(m), ., match_vals$team[m])))

olymp1 <- full_join(medals, wbd3, by = c("team", "year")) |>
    mutate(pop = pop/1e6,
           gdp = gdp/1e9)

## diagnosing match problems
## find top populations with no medals
olymp1 |>
    filter(is.na(n)) |> 
    select(team, pop) |>
    group_by(team) |>
    summarise(across(pop, mean)) |>
    arrange(desc(pop)) |>
    print(n = 20)

## find top gold medal teams with no pop
olymp1 |>
    filter(is.na(pop), medal == "Gold") |>
    select(team, n) |>
    group_by(team)|>
    summarise(across(n, mean)) |>
    arrange(desc(n)) |>
    print(n=20)

write.csv(olymp1, "olymp1.csv", row.names=FALSE)
