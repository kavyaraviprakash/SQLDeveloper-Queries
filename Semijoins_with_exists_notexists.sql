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
