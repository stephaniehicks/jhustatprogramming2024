#######################################
#### Create a flexdashboard 
######################################
library(here)

# Create a new RMarkdown document based on a template
rmarkdown::draft(
  file = here("lectures", "10-flexdashboard", "dashboard.Rmd"), 
  template = "flex_dashboard",
  package = "flexdashboard"
)
