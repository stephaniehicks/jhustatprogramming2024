
###############################
#### 1. Create an R package
###############################

library(usethis)
create_package("~/Desktop/greetings")

###############################
#### 2. Create new function in a .R file in the R/ folder 
###############################

use_r("hello")

#' Print a Greeting
#'
#' Print a greeting for a custom name
#'
#' @details This function make a plot with a greeting to the
#'          name passed as an argument to the function
#'
#' @param name character, name of person to whom greeting should be directed
#'
#' @return nothing useful is returned.
#'
#' @import ggplot2
#' @export
#'
#' @examples
#' hello("Chris")
#'
hello <- function(name) {
        message <- paste0("Hello, ", name, "!")
        ggplot() +
                geom_text(aes(0, 0), label = message, size = 4) +
                theme_minimal()

}

###############################
#### 3. Editing the DESCRIPTION file
###############################

Package: greetings
Title: Displays a greeting plot
Version: 0.0.0.9000
Authors@R: 
    person(given = "Stephanie",
           family = "Hicks",
           role = c("aut", "cre"),
           email = "shicks19@jhu.edu", 
           comment = c(ORCID = "0000-0002-5682-5998"))
Description: This package displays a nice greeting for a custom name.
License: GPL (>= 3)
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.3.2


###############################
#### 4. Add a README.md and license filesfile
###############################

use_readme_md()
use_gpl3_license()


###############################
#### 5. Show devtools
###############################

load_all()
document()
check()
build()
install()

###############################
#### 6. Push to github and build pkgdown website
###############################

usethis::use_pkgdown_github_pages() 