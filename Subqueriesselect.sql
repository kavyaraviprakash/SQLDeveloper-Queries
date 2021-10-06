SELECT flt_no, flt_distance
       , (SELECT AVG(flt_distance) FROM flight)
       , (SELECT airc_rangekm FROM aircraft)
FROM flight
WHERE flt_distance > (
         SELECT AVG(flt_distance)
          FROM flight
);

SELECT flt_no, flt_distance
          , (SELECT AVG(flt_distance) FROM flight)
          , (SELECT airc_rangekm FROM aircraft iq WHERE iq.airc_model=oq.airc_model)
FROM flight oq
WHERE flt_distance > (
         SELECT AVG(flt_distance)
         FROM flight
);
