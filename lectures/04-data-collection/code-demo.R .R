# Use DBI and RSQLite to make SQL queries 
library(RSQLite)
connection <- dbConnect(drv = RSQLite::SQLite(), 
                        dbname = here::here("readings","05-database-programming", "data", "survey.db"))
results <- dbGetQuery(conn = connection, 
                      statement = "SELECT * FROM Person ORDER BY id DESC;")
print(results)

# practice with iris 
dbListTables(conn = connection) # show which tables are in database

# add iris to database
dbWriteTable(conn = connection, 
             name = "iris", value = iris, row.names = FALSE)
head(dbReadTable(conn = connection, name = "iris"))
dbListTables(conn = connection)

# remove iris to database
dbRemoveTable(conn = connection, name = "iris")
dbListTables(conn = connection)

