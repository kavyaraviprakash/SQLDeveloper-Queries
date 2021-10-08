-- ************************ Division *****************

-- List the names of pilots certified to fly all aircraft.  (List the names of pilots for whom there is no aircraft they are not certified to fly.)

-- First approach

-- Remove from all possible pilot_ID, airc_model pairings the actual pairings, then we get values not part of the solution
-- Remember, for Minus the data types and number of attributes in the SELECT clause need to match
SELECT pilot_ID, airc_model
FROM pilot CROSS JOIN aircraft
MINUS
SELECT pilot_ID, airc_model
FROM certified;

-- Then only select the pilot_ID from the query above to get all pilot_IDs that are not part of the solution

SELECT pilot_ID
FROM (
 SELECT pilot_ID, airc_model
 FROM pilot, aircraft
 MINUS
 SELECT pilot_ID, airc_model
 FROM certified
 );
 
 -- Now, remove from all pilot_IDs the pilot_IDs that not part of the solution
 
SELECT pilot_ID
FROM pilot
 MINUS
SELECT pilot_ID
FROM (
 SELECT pilot_ID, airc_model
 FROM pilot, aircraft
 MINUS
 SELECT pilot_ID, airc_model
 FROM certified
 );
 
 -- Now, get the pilot_name and your are done

SELECT pilot_name
FROM pilot
WHERE pilot_ID IN(
    SELECT pilot_ID
    FROM pilot
     MINUS
    SELECT pilot_ID
    FROM (
        SELECT pilot_ID, airc_model
        FROM pilot, aircraft
         MINUS
        SELECT pilot_ID, airc_model
        FROM certified
        )
    );

-- All pilots certified for Airbus

SELECT pilot_name
FROM pilot
WHERE pilot_ID IN(
    SELECT pilot_ID
    FROM pilot
     MINUS
    SELECT pilot_ID
    FROM (
        SELECT pilot_ID, airc_model
        FROM pilot, aircraft
        WHERE airc_manufact = 'Airbus'
         MINUS
        SELECT pilot_ID, airc_model
        FROM certified));

-- Second approach
-- Double negative can be helpful to understand the query. There is no aircraft I can't fly.
-- This is a query that lists all pilots for whom there does not exist an aircraft they are not certified to fly.
-- The following query mimics that double negative

SELECT pilot_name
FROM pilot
WHERE NOT EXISTS (
   SELECT *
   FROM aircraft
   WHERE NOT EXISTS (
       SELECT *
       FROM certified
       WHERE certified.airc_model = aircraft.airc_model
        AND certified.pilot_id = pilot.pilot_id));

-- This is a query that lists all pilots for whom there does not exist
-- an aircraft they are not certified to fly.
-- This is a division, where values from one table are identified that match all values from another table.

-- Third Appraoch
-- An alternative that is simpler but assumes that pilot-aircraft-combination in certified is unique and also unique aircrafts in the aircraft table
-- Count all aircraft models and then see which pilot has as many certification as aircrafts
-- Another negative: Queries like, list all pilots that are certified to fly all aircrafts from Airbus does not work with this.
-- So, better use one from the two approaches above.

SELECT pilot_ID, count (*)
FROM certified
WHERE airc_model IN
  (SELECT airc_model FROM aircraft)
GROUP BY pilot_ID
HAVING COUNT (*) = (SELECT COUNT (*) FROM aircraft);

-- The above can be done easier, I believe ...

SELECT pilot_ID, count (*)
FROM certified
GROUP BY pilot_ID
HAVING COUNT (*) = (SELECT COUNT (*) FROM aircraft);

-- Get name

SELECT pilot_name
FROM pilot
WHERE pilot_ID IN
(
  SELECT pilot_ID
  FROM certified
  WHERE airc_model IN
    (SELECT airc_model FROM aircraft)
  GROUP BY pilot_ID
  HAVING COUNT (*) = (SELECT COUNT (*) FROM aircraft)
);
