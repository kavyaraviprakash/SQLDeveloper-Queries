1. Equijoin

SELECT pilot_name, airc_model
FROM pilot
       JOIN certified ON pilot.pilot_id = certified.pilot_id;
       
FROM table1 JOIN table2 ON table1.column = table2.column
FROM customer JOIN salesrep ON customer.cust_zipcode = salesrep.srep_zipcode


2.Non-Equi Join

SELECT fl.flt_no, fl.airc_model, fl.flt_distance, a.airc_model, a.airc_rangekm
FROM flight fl
         JOIN aircraft a ON join-condition;
         
SELECT fl.flt_no, fl.airc_model, fl.flt_distance, air.airc_model, air.airc_rangekm
FROM flight fl
       JOIN aircraft air ON fl.flt_distance <= air.airc_rangekm
ORDER BY fl.flt_no;

SELECT fl.flt_no, fl.airc_model, fl.flt_distance, air.airc_model, air.airc_rangekm
FROM flight fl
            JOIN aircraft air ON air.airc_rangekm BETWEEN fl.flt_distance AND fl.flt_distance+3000
ORDER BY fl.flt_no;


2. Equijoin USING

SELECT *
FROM aircraft
            JOIN flight ON aircraft.airc_model = flight.airc_model;

SELECT *
FROM aircraft
          JOIN flight USING (airc_model);

Both queries do the same. The advantage of the second is less writing.

There are a few caveats, though, that you should know and that make me to not recommend USING and instead recommend always ON even if a tad less convenient.

First, the join columns have to have same name.
Second, the duplicate column will be removed. So, you cannot reference tableA.joinColumn and tableB.joinColumn (e.g., when doing outer joins and wanting to remove rows where the column in one row is NULL) in the SELECT or WHERE clause.
Third, not all RDBMS support USING.
Fourth, with many joining tables that have the same columns USING might get confusing or joins are incorrectly done.
 
