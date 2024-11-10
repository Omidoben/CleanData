## code to prepare `DATASET` dataset goes here

## code to prepare `DATASET` dataset goes here

unemp_2013 <- readr::read_csv("https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2013.csv")
unemp_2014 <- readr::read_csv("https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2014.csv")
unemp_2015 <- readr::read_csv("https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2015.csv")

library(dplyr)
library(stringr)

clean_data <- function(x){
  x %>%
    janitor::clean_names() %>%
    mutate(level = case_when(
      str_detect(commune, "Grand-D.*") ~ "Country",
      str_detect(commune, "Canton") ~ "Canton",
      !str_detect(commune, "(Canton|Grand-D.*)") ~ "Commune"
    ),
    commune = if_else(str_detect(commune, "Canton"), str_remove_all(commune, "Canton "),
                      commune),
    commune = if_else(str_detect(commune, "Grand-D.*"), str_remove_all(commune, "Grand-Duche de "),
                      commune)
    ) %>%
    select(year,
           place_name = commune,
           level,
           everything())
}


my_datasets <- list(
  unemp_2013,
  unemp_2014,
  unemp_2015
)


unemp <- purrr::map_dfr(my_datasets, clean_data)

usethis::use_data(unemp, overwrite = TRUE)
