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
    complete(Team, Year, Medal, fill = list(n=0))

wbd <- wb_data(c("NY.GDP.MKTP.KD", "SP.POP.TOTL"),
               start_date = 2000, end_date = 2024) |>
    filter(date %in% unique(medals$Year))

wbd2 <- wbd |> select(Team = country, Year = date, GDP = NY.GDP.MKTP.KD,
                      pop = SP.POP.TOTL)

match_vals <- read_delim("team_match.csv", delim = ";", trim_ws=TRUE)

## ugh, matching team names against country names ...
m <- match(wbd2$Team, match_vals$Country)
wbd3 <- wbd2 |>
    mutate(across(Team,
                  ~ ifelse(is.na(m), ., match_vals$Team[m])))

olymp1 <- full_join(medals, wbd3, by = c("Team", "Year")) |>
    mutate(pop = pop/1e6,
           GDP = GDP/1e9)

## diagnosing match problems
## find top populations with no medals
olymp1 |> filter(is.na(n)) |> 
    select(Team, pop) |>
    group_by(Team) |>
    summarise(across(pop, mean)) |>
    arrange(desc(pop)) |>
    print(n = 20)

## find top medal teams with no pop
olymp1 |>
    filter(is.na(pop), Medal == "Gold") |>
    select(Team, n) |>
    group_by(Team)|>
    summarise(across(n, mean)) |>
    arrange(desc(n)) |>
    print(n=20)


write.csv(olymp1, "olymp1.csv", row.names=FALSE)
