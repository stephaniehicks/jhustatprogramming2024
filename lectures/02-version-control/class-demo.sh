### How to create a .gitignore file to not track certain files in git

# create new files we don't want tracked
mkdir results
touch a.dat b.dat c.dat results/a.out results/b.out

# create an empty new file titled .gitignore
touch .gitignore

# Next, add the following lines to the .gitignore file and save it. 
*.dat
results/

# Check the status with git status
git status

# You can track the .gitignore file too
git add .gitignore
git commit -m "tracking gitignore file"
git status

