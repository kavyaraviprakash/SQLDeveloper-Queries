Q1.
SELECT user_id,
        (CASE user_gender
               WHEN 'M' THEN 'male'
               WHEN 'F' THEN 'female'
               ELSE 'Unknown'
         END)
FROM mgreiner.movielens_user;

Q2.
SELECT flt_no, flt_distance,
           CASE
                 WHEN flt_distance <=1000 THEN 'Short range'
                WHEN flt_distance <=2000 THEN 'Medium range'
                WHEN flt_distance <=3000 THEN 'Long range'
                ELSE 'Very long range'
           END distance
FROM flight;

Q3.
SELECT airc_model,
           COUNT (
                 CASE flt_origin
                 WHEN 'London' THEN 1
                 ELSE null
                 END
           ) "London flights",
           count(
                 CASE flt_origin
                 WHEN 'Los Angeles' THEN 1
                 ELSE null
                 END
           ) "LA flights",
           count(
                 CASE flt_origin
                 WHEN 'Atlanta' THEN 1
                 ELSE null
                 END
           ) "Atlanta flights"
FROM flight
GROUP BY airc_model;
