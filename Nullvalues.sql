SELECT pilot_id, airc_model, cert_date
FROM certified
WHERE airc_model = 'Airbus A380';


Q2.
SELECT pilot_id, airc_model, cert_date
FROM certified
WHERE airc_model NOT IN
          (SELECT airc_model
           FROM flight);
           
Q3.
SELECT flt_no, flt_avgdelay, flt_avgdelay + 5
FROM flight
WHERE flt_schedule = 'Weekdays';
