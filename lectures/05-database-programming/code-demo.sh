

# Run is SQL
SELECT family, personal FROM Person;
SeLeCt FaMiLy, PeRsOnAl FrOm PeRsOn;
SELECT personal, family FROM Person;
SELECT id, id, id FROM Person;

# The * operator 
SELECT * FROM Person;

# Sorting and removing duplicates
SELECT quant FROM Survey;

# Use DISTINCT to return unique values
SELECT DISTINCT quant FROM Survey;

# Use DISTINCT keyword on multiple columns (returns distinct sets of values)
SELECT DISTINCT taken, quant FROM Survey;

# Use ORDER BY to sort 
SELECT * FROM Person ORDER BY id;

# Try it: use DESC to sort in a descending order
SELECT * FROM person ORDER BY id DESC;

# Use WHERE to filter 
SELECT * FROM Survey WHERE person = "dyer";

# Calculating new values 
SELECT 1.05 * reading FROM Survey WHERE quant = 'rad';

# Aggregation
SELECT dated FROM Visited;
SELECT MIN(dated) FROM Visited;
SELECT MAX(dated) FROM Visited;
SELECT AVG(reading) FROM Survey WHERE quant = 'sal';
SELECT COUNT(reading) FROM Survey WHERE quant = 'sal';
SELECT SUM(reading) FROM Survey WHERE quant = 'sal';
SELECT MIN(reading), MAX(reading) FROM Survey WHERE quant = 'sal' AND reading <= 1.0;

# GROUP BY 
SELECT   person, COUNT(reading), ROUND(AVG(reading), 2)
FROM     Survey
WHERE    quant = 'rad'
GROUP BY person;