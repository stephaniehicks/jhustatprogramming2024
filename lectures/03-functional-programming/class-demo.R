#### map practice
tmp_dat <- data.frame(
  x = 1:5,
  y = 6:10
)
# Use map to calculate the mean for the columns
map(.x = tmp_dat, .f = mean)
tmp_dat %>% map(.f = mean)



#### Arguments 
# e.g. if you want to pass na.rm=TRUE to mean(), you could use an anonymous function: 
x <- list(1:5, c(1:10, NA))
map_dbl(x, ~ mean(.x, na.rm = TRUE))

# Or can use ...
map_dbl(x, mean, na.rm = TRUE)


#### Stratified analyses in R 
unique(mtcars$cyl) # different numbers of cylinders

# This creates a list of three data frames: the cars with 4, 6, and 8 cylinders respectively.
by_cyl <- split(mtcars, mtcars$cyl)
length(by_cyl)
str(by_cyl)

# fit a linear model to understand how the miles per gallon (`mpg`) associated with the weight (`wt`)
lm(mpg ~ wt, data = mtcars)

# fit the model with purrr (returns a list from each lm fit for each cylinder)
by_cyl |>
  map(.f = ~ lm(mpg ~ wt, data = .x))

# QUESTION
# How to extract the second coefficient (i.e. the slope)

# using all observations in mtcars: 
lm.fit <- lm(mpg ~ wt, data = mtcars)
coef(lm.fit)

# how to do with this with map using stratified analsyes? 
##  try it out 

# in base R with a for loop
Or, of course, you could use a for loop:

slopes <- double(length(by_cyl))
for (i in seq_along(by_cyl)) {
  model <- lm(mpg ~ wt, data = by_cyl[[i]])
  slopes[[i]] <- coef(model)[[2]]
}
slopes 


#### modify()
df <- data.frame(
  x = 1:3,
  y = 6:4)

# using map returns a list 
map(df, ~ .x * 2)

# using modify() returns the same type of output as the input
modify(df, ~ .x * 2)

#### walk() and friends
# when you want to apply a function (e.g. cat(), write_csv(), or ggsave()), but do not return output, try walk and friend
# example: consider saving a dataset

tmp_fldr <- tempdir()

# map will force an output, e.g. NULL.
map2(.x = by_cyl,
     .y = 1:length(by_cyl),
     .f = ~saveRDS(.x, 
                   file = paste0(tmp_fldr, "/",.y, ".rds"))
)

# walk is just like map, but no output returned
walk2(.x = by_cyl,
      .y = (1:length(by_cyl)),
      .f = ~saveRDS(.x, 
                    file = paste0(tmp_fldr, "/",.y, ".rds"))
)