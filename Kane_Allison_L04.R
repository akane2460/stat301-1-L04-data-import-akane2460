# L04-data-import ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(janitor)

## Exercises ----

### Ex 1 ----
# Demonstrate how to read in `TopBabyNamesByState.txt` contained in the `data` sub-directory using the appropriate function from the `readr` package. 
# After reading in the data, determine the top male and female names in 1984 for South Dakota.

top_names_state <- read_delim("data/TopBabyNamesByState.txt")

top_names_state |> filter(state == "SD" & year == "1984")

### Ex 2 ----

# arguments for read_csv obtained from r documentation
# read_csv(
#   file,
#   col_names = TRUE,
#   col_types = NULL,
#   col_select = NULL,
#   id = NULL,
#   locale = default_locale(),
#   na = c("", "NA"),
#   quoted_na = TRUE,
#   quote = "\"",
#   comment = "",
#   trim_ws = TRUE,
#   skip = 0,
#   n_max = Inf,
#   guess_max = min(1000, n_max),
#   name_repair = "unique",
#   num_threads = readr_threads(),
#   progress = show_progress(),
#   show_col_types = should_show_types(),
#   skip_empty_rows = TRUE,
#   lazy = should_read_lazy()
# )

# arguments for read_tsv obtained from r documentation
# read_tsv(
#   file,
#   col_names = TRUE,
#   col_types = NULL,
#   col_select = NULL,
#   id = NULL,
#   locale = default_locale(),
#   na = c("", "NA"),
#   quoted_na = TRUE,
#   quote = "\"",
#   comment = "",
#   trim_ws = TRUE,
#   skip = 0,
#   n_max = Inf,
#   guess_max = min(1000, n_max),
#   progress = show_progress(),
#   name_repair = "unique",
#   num_threads = readr_threads(),
#   show_col_types = should_show_types(),
#   skip_empty_rows = TRUE,
#   lazy = should_read_lazy()
# )

# see qmd for full answer

### Ex 3 ----
# specify column names
column_names <- c(
  "Entry", "Per.", "Post Date", "GL Account", "Description", "Srce.", 
  "Cflow", "Ref.", "Post", "Debit", "Credit", "Alloc."
)

# specify column widths
column_widths <- c(7, 5, 12, 12, 22, 10, 5, 9, 9, 14, 20, 7)

# read in file
fwf_example <- 
  read_fwf("data/fwf_example.txt",
           col_positions = fwf_widths(
                              widths = column_widths,
                              col_names = column_names
                              )
           )

### Exercise 4 ----

# toy dataset
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

# a.  Extracting the variable called 1.
variable_1 <- annoying$`1`

# b.  Plotting a scatterplot of 1 vs 2.
ggplot(data = annoying, aes(x = `2`, y = `1`)) +
  geom_point() +
  labs(
    x = "Variable 2",
    y = "Variable 1",
    title = "Scatterplot of 1 vs. 2"
  )

# c.  Creating a new column called 3 which is 2 divided by 1.
annoying <-
  annoying |> 
    mutate(
      `3` = `2` / `1`
    )

# d.  Renaming the columns to one, two and three.
annoying <-
  annoying |> 
    rename(
      three = `3`,
      two = `2`,
      one = `1`
    )

### Exercise 5 ----
# Demonstrate how to manually input the data table below into R using each of these functions:

#    `tibble()`
#    `tribble()`

# | price | store   | ounces |
#   |-------|---------|--------|
#   | 3.99  | target  | 128    |
#   | 3.75  | walmart | 128    |
#   | 3.00  | amazon  | 128    |

tibble(
  price = c(3.99, 3.75, 3.00),
  store = c("target", "walmart", "amazon"),
  ounces = c(128, 128, 128)
)

tribble(
  ~price, ~store, ~ounces,
    3.99, "target", 128,
    3.75, "walmart", 128,
    3.00, "amazon", 128
)


### Exercise 6 ----

# What function in `janitor` helps you deal with non-syntactic column names in R 
# and and also ensures column names are systematically handled? Demonstrate its use.

# clean_names function

# example

unclean_data_ex <-
  tibble(
    "Amazon Price" = c(5, 7),
    "Store Price" = c(1, 2),
  )

cleaned_data_ex <- unclean_data_ex |> clean_names()

cleaned_data_ex  

### Exercise 7 ----

# read in the large file
cc_est2016_alldata <- read_csv("data/cc-est2016-alldata.csv")

# print the first 5 rows
head(cc_est2016_alldata, 5)

# notes on gitignore steps ----
# 1. Start by committing and pushing your current work to GitHub! 
# 1. Then download the `cc-est2016-alldata.csv` file from Canvas and add it to the 
# `data` subdirectory. **Do not commit!** We need to add the file to the `.gitignore` file first.
# 1. **Add `cc-est2016-alldata.csv` to the .gitignore** file. That is, add 
# `data/cc-est2016-alldata.csv` to the file with an appropriate header. If the file has been added (meaning ignored) correctly, it will NOT appear in the Git pane to commit --- may need to refresh the pane. 
# 1. Once the file is successfully ignored, commit with the comment "large data ignored!"

# If you Commit a large file and try to push to GitHub you will have an issue! 
# Do NOT keep clicking Commit. You **MUST UNDO** the Commit issue before moving forward. 
# The more times you click Commit and generate the error the more Commits you will 
# then need to undo. To undo a Commit, in the Terminal type: `git reset --soft HEAD~1`
# 
# To automatically find and add files over 100MB to the .gitignore you can type 
# the following code in the Terminal: 
#   
#   ```{bash}
# #| label: terminal
# #| code-fold: false
# #| eval: false
# 
# find . -size +100M | sed 's|^\./||g' | cat >> .gitignore; awk '!NF || !seen[$0]++' .gitignore
# ```
# 
# Note: You will need to retype this **EVERY** time a new file over 100MB is added to your project.


### Case Study ----

# Consider the `tinder_data` file in the `data` subdirectory.
# This dataset was sourced from [Swipestats.io](https://www.swipestats.io/
# 
# Read in the `tinder_data`

tinder_data <- read_csv("data/tinder_data.csv")

# Is `tinder_data` a `tibble` and how do you know?

is_tibble(tinder_data)

# Yes, it is a tibble. The is_tibble function determined that it was one.

# For the variable `user_interested_in`, use the `if_else()` function to change "M and F" to "B" for both.

tinder_data <-
  tinder_data |> 
    mutate(
      user_interested_in = if_else(
        user_interested_in == "M and F", 
        "B",
        user_interested_in
      )
    )

# Convert `user_gender` and `user_interested_in` into factor variables.

tinder_data_clean <- 
  tinder_data |> 
    mutate(
      user_gender = factor(user_gender),
      user_interested_in = factor(user_interested_in)
    )

# Write out a copy of the clean dataset to the `data` sub-directory as a csv file named `tinder_clean.csv`.

write_csv(tinder_data_clean, "data/tinder_data_clean.csv")

# Write out a copy of the clean dataset to the `data` sub-directory as an RDS file named `tinder_clean.rds`.

write_rds(tinder_data_clean, "data/tinder_data_clean.rds")

# Read both `tinder_clean.csv` and `tinder_clan.rds` back into R. 

tinder_data_clean_csv_reread <- read_csv("data/tinder_data_clean.csv")

tinder_data_clean_rds_reread <- read_rds("data/tinder_data_clean.rds")

# Explore the two data frame objects and list the differences between the two. When might writing out to one file type (csv or rds) be more beneficial than the other?

class(tinder_data_clean_csv_reread$user_gender)

class(tinder_data_clean_rds_reread$user_gender)

class(tinder_data_clean_csv_reread$user_interested_in)

class(tinder_data_clean_rds_reread$user_interested_in)

# Writing out the files, we can see that the read in data frames look the same in terms of the number of observations, columns, column names, etc.
# However, when investigating the class of certain variables, one finds that the
# user_gender and user_interested_in for the rds file are listed as factors, while in the csv file they are listed as characters.
# This is because csv files do not retain r-specific objects. CSV saves them as characters or numeric values. 
