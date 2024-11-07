######## 
## Explore more about anonymous functions in R and with map()
########

df <- data.frame(
 x = 1:3,
 y = 6:4)

# Let’s guess the output
map(df, ~ .x)
map(df, ~ .x * 2)
map(df, ~ length(.x))
map(df, ~ runif(2))
map(df, ~ mean(1:5))





######## 
## Use map() to apply this function row-wise and add the results as a new column in mtcars
######## 

# Function to assign fuel efficiency category based on mpg
fuel_efficiency <- function(row) {
  mpg <- row["mpg"]
  if (mpg > 25) {
    "High"
  } else if (mpg >= 20) {
    "Medium"
  } else {
    "Low"
  }
}



######## 
## Explore more about anonymous functions in R and with map()
########

# splits the data frame along the rows
asplit(mtcars, MARGIN = 1) 

# Apply fuel efficiency function to each row
map_chr(asplit(mtcars, 1), fuel_efficiency) 

# assign it a new column
mtcars$fuel_efficiency <- map_chr(asplit(mtcars, 1), fuel_efficiency)


######## 
## GitHub API
########

owner <- "stephaniehicks"
github_url <- paste0("https://api.github.com/users/", owner,"/repos")

# Read JSON file directly into R 
library(jsonlite)
library(tidyverse)
jsonData <- read_json(github_url, simplifyVector = TRUE)
glimpse(jsonData)






######## 
## Use httr2 to make a request to GitHub API
########

# Create the GET request
request(github_url)

# Make the GET request 
response <- request(github_url) %>%
  req_perform()
response

# resp_body_json() returns a parsed JSON file
stephanie <- resp_body_json(response, simplifyVector = TRUE)

# How many public repositories do I have?
stephanie$forks

# What’s the most popular language?
table(stephanie$language)

# How many repos have open issues do I have on my repos?
table(stephanie$open_issues)





######## 
## Use httr2 to make a request to GitHub API with PAT for authentication
########

# Read the PAT from environment variables
github_pat <- Sys.getenv("GITHUB_PAT")

# Make the GET request with PAT for authentication
response <- request(github_url) %>%
  req_auth_bearer_token(github_pat) %>%
  req_perform()

# return a parsed JSON file
stephanie <- resp_body_json(response, simplifyVector = TRUE)
head(stephanie)



######## 
## Try out the most important CSS selectors in rvest with a simple example
########

html <- minimal_html("
  <h1>This is a heading</h1>
  <p id='first'>This is a paragraph</p>
  <p class='important'>This is an important paragraph</p>
")

# use html_element() (or html_elements()) to extract a single (or all) elements
html %>% html_elements("h1") # all h1 elements

# try it out: retrieve the p elements
html %>% html_elements("p") 

 # all elements with the class='important'
html %>% html_elements(".important")

# all the elements with with id attribute equal to "first"
html %>% html_elements("#first") 




######## 
## Try out extracting text using html_text2()
########

html <- minimal_html("
  <ol>
    <li>apple &amp; pear</li>
    <li>banana</li>
    <li>pineapple</li>
  </ol>
")

html %>% 
  html_elements("li") %>% 
  html_text2()




######## 
## Extract attributes using html_attr() or html_attrs()
########

# Attributes are used to record the destination of links (e.g. the href 
#     attribute of <a> elements) and the source of images (the src 
#     attribute of the <img> element)

html <- minimal_html("
  <p><a href='https://en.wikipedia.org/wiki/Cat'>cats</a></p>
  <img src='https://cataas.com/cat' width='100' height='200'>
")

# The value of an attribute can be retrieved with html_attr()
html %>% 
  html_elements("a") %>% 
  html_attr("href")

# try it out: retrieve the src attribute of the img element
html %>% 
  html_elements("img") %>% 
  html_attr("src")

# try it out: retrieve the src attribute of the img element
html %>% 
  html_elements("img") %>% 
  html_attr("width")


######## 
## Extract out movie titles
########

html <- read_html("https://rvest.tidyverse.org/articles/starwars.html")

html %>% 
  html_elements("#main h2") %>% 
  html_text2()

######## 
## Extract out paragraphs of the movie intro
########

html %>% 
  html_elements(".crawl p") %>% 
  html_text2() %>% 
  .[1:4]