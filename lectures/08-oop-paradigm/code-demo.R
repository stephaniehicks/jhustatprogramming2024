############################
#### sloop 
############################

library(sloop)
otype(1:10) # base OOP system

library(palmerpenguins)
otype(penguins) # S3 OOP system

mle_obj <- stats4::mle(function(x = 1) (x - 2) ^ 2)
otype(mle_obj) # S4 OOP system

# Let's guess these as a group
library(tidyverse)
otype("Happy Fall Yall")
otype(rpois(10, lambda = 1))
otype(read.csv)
otype(mtcars)
otype(tibble(mtcars))







############################
#### is.object() = tell diff between base an OO object
############################

# A base object
is.object(1:10)

# An OO object
is.object(mtcars)

# Technically, the difference between base and OO objects 
#   is that OO objects have a “class” attribute:

attr(1:10, "class")
attributes(1:10)
attr(mtcars, "class")
attributes(mtcars)




############################
#### class() = find out class of an object in R 
#### typeof() = All objects (base or OO objects) have a base type
############################
class(1:10)
class("is in session.")
class(factor("is in session."))
class(mtcars)
class(class)
otype(class)

typeof(1:10)
typeof(mtcars)
typeof(NULL)
typeof(1L)
typeof(1i)



f <- factor(c("a", "b", "c"))
typeof(f)
attributes(f)


############################
#### Create a S3 class called 'dog' 
############################

new_dog <- function(name, age, sleep_status) {
  structure(
    list(
      name = name,
      age = age,
      sleep_status = sleep_status
    ),
    class = "dog"
  )
}

# Create our first dog (or object)
d <- new_dog(name = "Milo", age = 4, sleep_status = "asleep")
d

# We can interact with our object using $ to retrieve
#   fields of the object and try to print it:
d$name
d$age
d$sleep_status
print(d)
attr(d, "class")
attributes(d)

# We can see that our dog gets printed out like a regular list.
#   Let’s fix that by defining a print() function for our dog class.
#
#   **IMPORTANT**: As the print() generic function is already available in R,
#                  the only thing we need to do is to define a function 
#                  with a specific naming scheme print.<NAME_OF_OUR_CLASS>:

print.dog <- function(x) {
  cat("Dog: \n")
  cat("\tName: ", x$name, "\n", sep = "")
  cat("\tAge: ", x$age, "\n", sep = "")
  cat("\tSleep status: ", x$sleep_status, "\n", sep = "")
}

# Now our dog class provides its own implementation of the print() function. 
#   Let’s try to print our dog again:
print(d)


# Let's try to create another dog named Max who is 1 years old and is awake
## add here 



# If you want to create a new method (beyond print), it's called a generic
#   Let's create a generic method that returns if the dog is asleep or awake

# Step 1 is always to create the generic method UseMethod()
is_awake <- function(x) { UseMethod("is_awake") }

# Step 2: Define what’s inside the method
#   Note: You define a method for each class or 
#         <NAME_OF_OUR_GENERIC>.<NAME_OF_OUR_CLASS>:
is_awake.dog <- function(x){
    x$sleep_status == "awake"
}
is_awake(d)

# Let's create a generic method that makes the sound a dog makes
make_sound <- function(x) { UseMethod("make_sound") }
make_sound.dog <- function(x) { cat(x$name, "says", "Wooof!\n") }
make_sound(d)






############################
#### Inheritance
############################

# What if we wanted to create classes for specific dog breeds (e.g. Golden Retrievers)? 
# Modify the new_dog constructor to allow for subclasses by
#    pre-pending the name of the subclass like this:

new_dog <- function(name, age, sleep_status = sleep_status,
                    class = character()) {
  structure(
    list(
      name = name,
        age = age,
        sleep_status = sleep_status
    ),
    class = c(class, "dog")
  )
}

new_golden_retriever <- function(name, age, sleep_status = sleep_status) {
  new_dog(
    name = name,
    age = age,
    sleep_status = sleep_status,
    class = "golden_retriever"
  )
}
pp <- new_golden_retriever(name = "Penny", age = 5, sleep_status = "asleep")
print(pp)
is_awake(pp)
make_sound(pp)

# Finally, let's create a generic method for our golden retriever
known_facts <- function(x) { UseMethod("known_facts") }
known_facts.golden_retriever <- function(x) { 
    cat("Golden Retriever are friendly!\n") 
}
known_facts(pp)
known_facts(d)







############################
#### S4 bus and party_bus classes
############################

# Here is an example of how to construct a S4 class for bus and party_bus:

setClass(Class = "bus_S4",
         slots = list(n_seats = "numeric", 
                      top_speed = "numeric",
                      current_speed = "numeric",
                      brand = "character"))

setClass(Class = "party_bus_S4",
         slots = list(n_subwoofers = "numeric",
                      smoke_machine_on = "logical"),
         contains = "bus_S4")

# Create bus objects using the new() function. The new() function’s
#   arguments are the name of the class and values for each
#   “slot” in our S4 object.

my_bus <- new("bus_S4", n_seats = 20, top_speed = 80, 
              current_speed = 0, brand = "Volvo")
my_bus

my_party_bus <- new("party_bus_S4", n_seats = 10, top_speed = 100,
                    current_speed = 0, brand = "Mercedes-Benz", 
                    n_subwoofers = 2, smoke_machine_on = FALSE)
my_party_bus

# You can use the @ operator to access the slots of an S4 object:
my_bus@n_seats
my_party_bus@top_speed






############################
#### S4 bus and party_bus methods
############################

# Create a generic function called is_bus_moving() to see if
#   a bus_S4 object is in motion:

setGeneric("is_bus_moving", function(x){
  standardGeneric("is_bus_moving")
})

# Now, we need to actually define the function,
#   which we can to with setMethod() -- takes two arguments
#       1. the name of the method as a string (or f)
#       2. the method signature (signature), which specifies the class

setMethod(f = "is_bus_moving",
          signature = c(x = "bus_S4"),
          definition = function(x){
                          x@current_speed > 0
                      }
          )

is_bus_moving(my_bus)

# but if we change the speed 
my_bus@current_speed <- 1
is_bus_moving(my_bus)
