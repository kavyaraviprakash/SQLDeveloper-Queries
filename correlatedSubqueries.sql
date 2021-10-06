-- For each aircraft, list the pilot most recently certified to fly that aircraft.

-- Let's start small
-- I want to find the aircraft model and pilot and cert date where aircraft model is equal to boeing 757

SELECT airc_model, pilot_ID, cert_date
FROM certified
WHERE airc_model = 'Boeing 757';

-- How do I get only this one row? The row with the max date?

SELECT airc_model, pilot_ID, cert_date
FROM certified
WHERE airc_model = 'Boeing 757'
  AND cert_date = (
    SELECT MAX(cert_date)
    FROM certified
    WHERE airc_model = 'Boeing 757'
    );

-- so that is the kind of output that we want
-- But what's not good? It's only for one specific one
-- How do we do that for all?
-- Let me change that around - see, the aircraft model in the subquery is the same as the one in the outer query

SELECT airc_model, pilot_ID, cert_date
FROM certified
WHERE airc_model = 'Boeing 757'
  AND cert_date = (
    SELECT MAX(cert_date)
    FROM certified
    WHERE airc_model = airc_model
    );

-- How do I make it so that the aircraft model on the right of the equal sign references the outer query
-- and the aircraft model on the left of the equal sign references the subquery?
-- Aliase

SELECT airc_model, pilot_ID, cert_date
FROM certified outerquery
WHERE airc_model = 'Boeing 757'
  AND cert_date = (
    SELECT MAX(cert_date)
    FROM certified subquery
    WHERE subquery.airc_model = outerquery.airc_model
    );

-- Remove the Restriction that only displays Boeing 757

SELECT airc_model, pilot_ID, cert_date
FROM certified outerquery
WHERE cert_date = (
  SELECT MAX(cert_date)
  FROM certified subquery
  WHERE subquery.airc_model = outerquery.airc_model
);

