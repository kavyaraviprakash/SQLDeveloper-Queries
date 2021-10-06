-- definition of tables in the WITH clause
WITH flightCount AS
(SELECT airc_model, COUNT (*) numflights
FROM flight
GROUP BY airc_model)

-- Main query using the tables defined above starts here
SELECT COUNT (*)
FROM flightCount
WHERE numflights >2;

WITH flightCount AS
(SELECT airc_model, COUNT (*) numflights
FROM flight
GROUP BY airc_model),
certifiedPilots AS
(SELECT airc_model, COUNT (*) pilots
FROM certified
GROUP BY airc_model)

SELECT fc.airc_model, numFlights, pilots
FROM flightCount fc
JOIN certifiedPilots cp ON fc.airc_model = cp.airc_model
WHERE numflights >2;
