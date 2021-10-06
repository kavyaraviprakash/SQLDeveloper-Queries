Q1. UNION operator

SELECT airc_model
FROM flight
WHERE flt_origin = 'London'
UNION
SELECT airc_model
FROM flight
WHERE flt_destination = 'New York';

Q2. UNION ALL operator

SELECT airc_model
FROM flight
WHERE flt_origin = 'London'
UNION ALL
SELECT airc_model
FROM flight
WHERE flt_destination = 'New York';

Q3. MINUS operator

SELECT airc_model
FROM flight
WHERE flt_origin = 'London'
MINUS
SELECT airc_model
FROM flight
WHERE flt_destination = 'New York';

Q4. INTERSECT

SELECT airc_model
FROM flight
WHERE flt_origin = 'London'
INTERSECT
SELECT airc_model
FROM flight
WHERE flt_destination = 'New York';


Q5.
