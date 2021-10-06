Q1.
SELECT DISTINCT pilot_ID
FROM certified
WHERE airc_model LIKE 'Boeing%';

Q2.
SELECT DISTINCT pilot_id
FROM certified
WHERE airc_model IN ('Boeing 757', 'Boeing 747', 'Boeing 777');

Q3.
SELECT airc_model
FROM aircraft
WHERE airc_manufact = 'Boeing Commercial Airplanes';

Q4.
SELECT DISTINCT pilot_id
FROM certified
WHERE airc_model IN
                (SELECT airc_model
                  FROM aircraft
                  WHERE airc_manufact = 'Boeing Commercial Airplanes');
                  
Q5.
SELECT *
FROM flight
WHERE flt_distance > (
      SELECT flt_distance
      FROM flight
      WHERE flt_origin = 'Omaha'
      );
      
Q6.
SELECT *
FROM flight
WHERE flt_distance > (
         SELECT MAX( flt_distance)
          FROM flight
          WHERE flt_origin = 'Atlanta'
          );
          
Q7.---------------Nested Subqueries---------------------

SELECT pilot_name
FROM pilot
WHERE pilot_ID IN (
        SELECt pilot_ID
        FROM certified
        WHERE airc_model IN (
                SELECT airc_model
               FROM flight
               WHERE flt_no = 2807)
               );



                  
