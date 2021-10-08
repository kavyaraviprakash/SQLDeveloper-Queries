-- List all flights whose average delay = 0
-- List all flights whose average delay <> 0

SELECT flt_no, flt_avgdelay
FROM flight
WHERE flt_avgdelay = 0;

SELECT flt_no, flt_avgdelay
FROM flight
WHERE flt_avgdelay <> 0;

-- List all flights whose average delay = 0 or is NULL

SELECT flt_no, flt_avgdelay
FROM flight
WHERE flt_avgdelay = 0 OR flt_avgdelay IS NULL;

-- One tricky thing = NULL won't work but also not throw an error

SELECT flt_no, flt_avgdelay
FROM flight
WHERE flt_avgdelay = NULL;

-- Arithmetic function return a null. Using NVL allows to define a string instead of null.
-- String needs to match the data type or oracle converts implicitly.

SELECT flt_no, flt_time, flt_avgdelay + 5
FROM flight;

SELECT flt_no, flt_time, NVL(flt_avgdelay, 0) + 5
FROM flight;

-- Another tricky thing

SELECT COUNT (*)
FROM flight;

SELECT COUNT (flt_no)
FROM flight;

SELECT COUNT (flt_avgdelay)
FROM flight;
