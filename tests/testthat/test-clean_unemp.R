# In this script, we test several ideas of the clean_unemp function

# 1) Is the function returning the expected value of a given input
# We start by testing if our function actually returns data for the Grand-Duchy of Luxembourg if
# the user provides a correct regular expression.

#unemp_2013 <- readr::read_csv("https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2013.csv")

#unemp_2013 <- readr::write_csv(unemp_2013, "tests/testthat/unemp_2013.csv")
unemp_2013 <- readr::read_csv("unemp_2013.csv")

#unemp_2014 <- readr::read_csv("https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2014.csv")
#unemp_2014 <- readr::write_csv(unemp_2014, "tests/testthat/unemp_2014.csv")
unemp_2014 <- readr::read_csv("unemp_2014.csv")

#unemp_2015 <- readr::write_csv(unemp_2015, "tests/testthat/unemp_2015.csv")
unemp_2015 <- readr::read_csv("unemp_2015.csv")

test_that("selecting the grand duchy works", {

  returned_value <- clean_unemp(
    unemp,
    year_of_interest = 2013,
    level_of_interest = "Country",
    col_of_interest = active_population) |>
    as.data.frame()

  expected_value <- as.data.frame(
    list("year" = 2013,
         "place_name" = "Luxembourg",
         "level" = "Country",
         "active_population" = 242694)
  )

  expect_equal(returned_value, expected_value)

})


# second test

# this func returns many values, it cannot be handwritten like above
# save the ground truth in a csv

# clean_unemp(unemp, year_of_interest = 2013,
#             level_of_interest = "Canton", col_of_interest = active_population) %>%
#             readr::write_csv("tests/testthat/test_data_cantons.csv")

test_that("selecting cantons work", {

  returned_value <- clean_unemp(
    unemp,
    year_of_interest = 2013,
    level_of_interest = "Canton",
    col_of_interest = active_population)

  expected_value <- readr::read_csv("test_cantons.csv") |>
    dplyr::as_tibble()

  expect_equal(returned_value, expected_value)

})


# Third test: for communes

# we save the ground truth in a csv file, just like we did in above test and run it in the console

#clean_unemp(unemp_2013,
#            !grepl("(Canton|Grand-D.*)", commune),
#            active_population) %>%
#  readr::write_csv("tests/testthat/test_data_communes.csv")


test_that("selecting communes works", {

  returned_value <- clean_unemp(
    unemp,
    year_of_interest = 2013,
    level_of_interest = "Commune",
    col_of_interest = active_population)

  expected_value <- readr::read_csv("test_communes.csv") |>
    dplyr::as_tibble()

  expect_equal(returned_value, expected_value)

})


# Test 4: test for a specific commune

test_that("selecting one commune works", {

  returned_value <- clean_unemp(
    unemp,
    year_of_interest = 2013,
    place_name_of_interest = "Kayl",
    col_of_interest = active_population)

  expected_value <- tibble::as_tibble(
    list("year" = 2013,
         "place_name" = "Kayl",
         "level" = "Commune",
         "active_population" = 3863)
  )

  expect_equal(returned_value, expected_value)
})


# 2) Can the function deal with all kinds of input?
# What should happen if your function gets an unexpected input? Let’s write a unit test and then see
# if it passes. For example, what if the user enters a commune name that is not in Luxembourg?
# We expect the data frame to be empty

test_that("wrong commune name", {

  returned_value <- clean_unemp(
    unemp,
    year_of_interest = 2013,
    place_name_of_interest = "Paris",
    col_of_interest = active_population)

  expected_value <- tibble::as_tibble(
    list("year" = numeric(0),
         "place_name" = character(0),
         "level" = character(0),
         "active_population" = numeric(0))
  )

  expect_equal(returned_value, expected_value)
})


# To test if the warning is actually thrown:

test_that("wrong commune name: warning is thrown", {

  expect_warning({
    clean_unemp(
      unemp,
      year_of_interest = 2013,
      place_name_of_interest = "Paris",
      col_of_interest = active_population)
  }, "This is likely")
})











