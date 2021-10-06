Aggregate Functions
Aggregate functions (Links to an external site.) allow us to calculate a number for a group of rows. Common aggregate functions are:

COUNT  Number of values (rows) in a column (table)
SUM  Sum of values in a column
AVG  Average of values in a column
MAX  Maximum value in the column
MIN  Minimum value in a column
Without indicating a grouping with GROUP BY, all rows in the FROM clause are considered one group.

Run the query to list the minimum, maximum, average, and total flight distance for all flights.

SELECT MIN(flt_distance), MAX (flt_distance), AVG(flt_distance), SUM (flt_distance)
FROM flight;

Q2.
SELECT MIN(flt_distance) Minimum
       , MAX (flt_distance) Maximum
       , AVG(flt_distance) Average, SUM (flt_distance) Sum
FROM flight;

Another change is to round the average. Oracle uses a function ROUND ().

SELECT MIN(flt_distance) Minimum
       , MAX (flt_distance) Maximum
       , ROUND(AVG(flt_distance), 2) Average, SUM (flt_distance) Sum
FROM flight;

You can use DISTINCT in many aggregate functions. DISTINCT will only use distinct values in the row.

Run the following query and observe the difference.

SELECT
        MIN(flt_distance) Minimum, MAX (flt_distance) Maximum,
        AVG(flt_distance) Average, AVG(DISTINCT flt_distance) AverageDisti,
        SUM (flt_distance) Sum, SUM (DISTINCT flt_distance) SumDisti
FROM flight;

Q3.
SELECT airc_model
       , MIN(flt_distance) Minimum
       , MAX (flt_distance) Maximum
       , AVG(flt_distance) Average
       , SUM (flt_distance) SumOfTotalFlights
       , COUNT (*)
FROM flight
GROUP BY airc_model;

Q4.
SELECT airc_model, MIN (flt_distance), MAX (flt_distance)
     , AVG (flt_distance), COUNT (*), flt_distance
FROM flight
GROUP BY airc_model;

Q5.
SELECT airc_model, MIN (flt_distance), MAX (flt_distance)
      , AVG (flt_distance), COUNT (*), 'Hello', 12
FROM flight
GROUP BY airc_model;

Q6. ----------------Nesting Aggregate Functions----------------------
SELECT MAX(AVG(flt_distance))
FROM flight
GROUP BY airc_model;

You can cross-check by running:

SELECT AVG(flt_distance) avgdistance
FROM flight
GROUP BY airc_model
ORDER BY avgdistance DESC;

Q7. Using Count()

SELECT airc_model, COUNT (*), COUNT (flt_avgdelay)
FROM flight
GROUP BY airc_model;

COUNT (flt_avgdelay) only counts flights that have a known delay (which could include zero, because NULL is not zero).
