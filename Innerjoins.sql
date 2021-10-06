Q1.
Joins are used to connect tables based on shared values. The most common join is an inner join that matches rows from two tables if the join column values of the first table matches a join column value in the other table.

The basic syntax is

SELECT column(s)
FROM table1
        table2 ON table1.joincol = table2.joincol

For example, if we want to list the flight numbers, aircraft models, and aircraft manufacturer for each flight, then we need data from tables flight and table aircraft.

Q2.
SELECT flt_no, airc_model, airc_manufact
FROM flight
           JOIN aircraft ON airc_model = airc_model;
           
 
Q3.
SELECT pilot_name, airc_model
FROM pilot
       JOIN certified ON pilot.pilot_id = certified.pilot_id
       JOIN aircraft ON join-condition;
       
Q4.
SELECT pilot_name, airc_model, airc_manufact
FROM pilot
       JOIN certified ON pilot.pilot_id = certified.pilot_id
       JOIN aircraft ON aircraft.airc_model = certified.airc_model;
       

Q5.
SELECT pilot_name, certified.airc_model, airc_manufact
FROM pilot
       JOIN certified ON pilot.pilot_id = certified.pilot_id
       JOIN aircraft ON aircraft.airc_model = certified.airc_model;
       
Q6.
SELECT pilot_name, cert.airc_model, airc_manufact
FROM pilot
        JOIN certified cert ON pilot.pilot_id = cert.pilot_id
        JOIN aircraft ac ON ac.airc_model = cert.airc_model;
        
 Q7.
 Table with alias
 
 SELECT a.name, b.cert_date
FROM pilot a, certified b
WHERE a.Pilot_id = b.Pilot_id;

Q8.
SELECT DISTINCT pilot_id
FROM certified cert
       JOIN aircraft ac ON cert.airc_model = ac.airc_model
WHERE airc_manufact = 'Boeing Commercial Airplanes';

Q9.
SELECT flt_no, pilot_name
FROM pilot
       JOIN certified cert ON pilot.pilot_id = cert.pilot_id
       JOIN aircraft ac ON ac.airc_model = cert.airc_model
       JOIN flight fl ON fl.airc_model = ac.airc_model
ORDER BY flt_no;

Q10.
SELECT flt_no, pilot_name
FROM pilot
       JOIN certified cert ON pilot.pilot_id = cert.pilot_id
        JOIN flight fl ON fl.airc_model = cert.airc_model
ORDER BY flt_no;
