-- Join tables flight and aircraft together. Before we do so, inspect both tables.

SELECT *
FROM flight;

SELECT *
FROM aircraft;

-- There are flights without an aircraft (flight number 8746)
-- There are aircrafts without a fligt (Airbus A 380)

SELECT *
FROM flight
    JOIN aircraft ON flight.airc_model = aircraft.airc_model;

-- The flight 8746 and the aircraft Airbus A380 do not appear.
-- What if I write right? Get all aircrafts.

SELECT *
FROM flight
    RIGHT JOIN aircraft ON flight.airc_model = aircraft.airc_model;

-- What if I write left? Get all flights.

SELECT *
FROM flight
    LEFT JOIN aircraft ON flight.airc_model = aircraft.airc_model;

-- FULL OUTER gives me all aircrafts, all flights, and all matching.

SELECT *
FROM flight
    FULL JOIN aircraft ON flight.airc_model = aircraft.airc_model;

-- How do we get only the aircraft without matching flight?

SELECT flt_no, aircraft.airc_model, airc_manufact
FROM flight
    RIGHT JOIN aircraft ON flight.airc_model = aircraft.airc_model
WHERE flight.flt_no IS NULL;

-- How do we get only the flights without matching aircraft and aircrafts without matching flight?

SELECT flt_no, aircraft.airc_model, airc_manufact
FROM flight
    FULL JOIN aircraft ON flight.airc_model = aircraft.airc_model
WHERE flight.flt_no IS NULL OR aircraft.airc_model IS NULL;


