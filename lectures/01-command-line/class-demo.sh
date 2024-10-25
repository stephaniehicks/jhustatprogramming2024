# awk 

cat employee.txt
awk '{print}' employee.txt # default prints every line 
awk '/manager/ {print}' employee.txt # prints line that pattern match
awk '{print $1, $4}' employee.txt # splits lines into fields ($0 is the whole line)

# awk has built in variables 
awk '{print NR,$0}' employee.txt # NR command keeps a current count of the number of input records (or lines)
awk 'NR==3, NR==6 {print NR,$0}' employee.txt  # display lines 3 to 6

# Three ways to run R in the shell 

R -e "head(mtcars); tail(mtcars)" # will launch R and then run code
Rscript -e "head(mtcars); tail(mtcars)" # will run code without launching R 

# can also execute an R script
cat analysis.R
Rscript analysis.R




