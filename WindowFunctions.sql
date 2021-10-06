-- ******************** Windows Functions ***********************************

/* List aircraft model, the number of flights the aircraft model is used on,
   and flight numbers for the aircraft model. */

-- We could do this with a correlated subquery in the SELECT clause

SELECT airc_model
    ,(SELECT COUNT(*)
      FROM flight sq
      WHERE fli.airc_model = sq.airc_model) NumOfFlights
    , flt_no
FROM flight fli
ORDER BY airc_model;

-- Or we could do it with a Windows Functions
/* The OVER starts the Windows Functions and
the PARTITION BY specifies the window on which the COUNT (*) is applied */

SELECT airc_model
    , COUNT (*) OVER (PARTITION BY airc_model) NumOfFlights
    , flt_no
FROM flight;

-- Add a column that gives you the running total of flight numbers

SELECT airc_model
    , COUNT (*) OVER (PARTITION BY airc_model) NumOfFlights
    , COUNT (*) OVER (ORDER BY airc_model) TotalOfNumOfFlights
    , flt_no
FROM flight;

-- Ordering within a PARTITION

SELECT pilot.pilot_id, pilot_name, airc_model, cert_date
      , COUNT (*) OVER (PARTITION BY pilot.pilot_id) countCert
      , COUNT (*) OVER (PARTITION BY pilot.pilot_id ORDER BY EXTRACT (year from cert_date)) runningTotal
FROM pilot
    JOIN certified ON pilot.pilot_id = certified.pilot_id
ORDER BY pilot_id, cert_date;

-- Other aggregate functions and running total

SELECT flt_no, flt_distance
    , COUNT (*) OVER (ORDER BY flt_no) countFlights
    , SUM (flt_distance) OVER (ORDER BY flt_no) SumOfFlightDistance
    , AVG (flt_distance) OVER (ORDER BY flt_no) TotalOfNumOfFlights
FROM flight
ORDER BY flt_no;
