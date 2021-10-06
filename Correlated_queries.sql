Q1.
SELECT airc_model, flt_no, flt_distance
FROM flight oq
WHERE flt_distance = (
          SELECT MAX(flt_distance)
          FROM flight iq
          WHERE iq.airc_model = oq.airc_model
);

Q2.
SELECT airc_model, pilot_ID, cert_date
FROM certified outerquery
WHERE cert_date = (
  SELECT MAX(cert_date)
  FROM certified subquery
  WHERE subquery.airc_model = outerquery.airc_model
);

Q3.
SELECT airc_model, flt_no, flt_distance
FROM flight oq
WHERE flt_distance = (
       SELECT MAX(flt_distance)
       FROM flight iq
       WHERE iq.airc_model = oq.airc_model
);
