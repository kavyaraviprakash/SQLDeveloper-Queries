Q1.
SELECT column(s)
FROM tableA
WHERE EXISTS (
         SELECT whatever columns
         FROM tableB
        WHERE tableA.column = tableB.column);
        
Q2.
SELECT p.pilot_id, pilot_name
FROM pilot p
          JOIN certified c ON p.pilot_ID = c.pilot_ID
WHERE airc_model = 'Airbus A340';


Q3.
SELECT pilot_name
FROM pilot
WHERE EXISTS (
          SELECT *
          FROM certified
         WHERE airc_model = 'Airbus A340'
                             AND pilot.pilot_ID = certified.pilot_ID
);
Q4.
SELECT pilot_name
FROM pilot
WHERE EXISTS (
       SELECT cert_date, pilot_id
       FROM certified
       WHERE airc_model = 'Airbus A340'
                           AND pilot.pilot_ID = certified.pilot_ID
);

SELECT pilot_name
FROM pilot
WHERE EXISTS (
       SELECT 'woah'
       FROM certified
       WHERE airc_model = 'Airbus A340'
                           AND pilot.pilot_ID = certified.pilot_ID
);

 

SELECT pilot_name
FROM pilot
WHERE EXISTS (
       SELECT 1
       FROM certified
       WHERE airc_model = 'Airbus A340'
                           AND pilot.pilot_ID = certified.pilot_ID
);

Q5-------------------LEFT JOIN-------------------------------------
SELECT pilot_name
FROM pilot
           JOIN certified ON pilot.pilot_ID = certified.pilot_ID
WHERE certified.airc_model <> 'Airbus A340';

SELECT pilot.pilot_id, certified.pilot_id, pilot_name, certified.airc_model
FROM pilot JOIN certified ON pilot.pilot_ID = certified.pilot_ID;

SELECT *
FROM pilot
           LEFT JOIN certified ON pilot.pilot_ID = certified.pilot_ID
WHERE airc_model = 'Airbus A340';


Q6.
SELECT pilot_name
FROM pilot
WHERE pilot_id NOT IN (
       SELECT certified.pilot_id
       FROM certified
       WHERE airc_model = 'Airbus A340');
       
 Q7.
 SELECT airc_model
FROM aircraft
WHERE airc_model NOT IN (
         SELECT flight.airc_model
         FROM flight);
         
