Q1.
SELECT promo_category "promotional category", 
SUM (od.od_extprice) sales_total FROM oltppromo_subcategory 
subcat JOIN oltppromotion prom ON subcat.promo_subcategory = prom.promo_subcategory 
JOIN oltporder_detail od ON prom.promo_id = od.promo_id 
GROUP BY promo_category 
ORDER BY sales_total DESC;

Q2.
SELECT sc.cat_name, sr.region_name, sum(od.od_extprice) total
FROM oltporder o
       JOIN oltpcustomer c ON o.cust_ID = c.cust_ID
       JOIN oltpcountry co ON co.country_ID = c.country_ID
       JOIN oltpsubregion sr ON co.subregion_name = sr.subregion_name
       JOIN oltporder_detail od ON od.order_ID = o.order_ID
       JOIN oltpproduct pr ON pr.prod_ID = od.prod_ID
       JOIN oltpsubcategory sc ON sc.subcat_name = pr.subcat_name
GROUP BY sc.cat_name, sr.region_name
ORDER BY sc.cat_name, sr.region_name, total;

Q3.
SELECT promo_category "promotional category"
      , SUM(od.od_qty), SUM(od.od_extprice) sales_total
      , AVG(od.od_qty), AVG(od.od_extprice)avg_total, AVG(od.od_price)
FROM mgreiner.oltppromo_subcategory subcat
       JOIN mgreiner.oltppromotion prom ON subcat.promo_subcategory = prom.promo_subcategory
       JOIN mgreiner.oltporder_detail od ON prom.promo_id = od.promo_id
GROUP BY promo_category
ORDER BY sales_total DESC

Q4.
SELECT promo_category "promotional category"
     , SUM(od.od_qty)
     , SUM(od.od_extprice) sales_total
     , AVG(od.od_qty)
     , AVG(od.od_extprice) sales_total
     , AVG(od.od_price)
FROM mgreiner.oltppromo_subcategory subcat
      JOIN mgreiner.oltppromotion prom
                  ON subcat.promo_subcategory = prom.promo_subcategory
       JOIN mgreiner.oltporder_detail od
                  ON prom.promo_id = od.promo_id
GROUP BY promo_category
ORDER BY sales_total DESC;

Basic Select Queries:
Q1.
SELECT pilot_name
FROM pilot;

Q2.
SELECT DISTINCT airc_model
FROM flight;

Q3.
SELECT airc_model, airc_manufact, airc_rangekm
FROM aircraft
WHERE airc_rangekm > 10000;

Q4.
SELECT flt_no, flt_origin, flt_destination
FROM flight
WHERE flt_origin = 'Los Angeles' AND flt_origin = 'New York';

Q5.
SELECT flt_no, flt_origin, flt_destination
FROM flight
WHERE flt_origin = 'Los Angeles' OR 'New York';

Q6.
SELECT flt_no, flt_origin, flt_destination
FROM flight
WHERE flt_origin = 'Los Angeles'
          OR flt_origin = 'New York'
          OR flt_origin ='London';
          
Q7.
SELECT flt_no, flt_origin, flt_destination
FROM flight
WHERE flt_origin IN ('Los Angeles', 'New York', 'London');

Q8.
SELECT flt_no, flt_origin, flt_destination
FROM flight
WHERE NOT (flt_origin = 'Los Angeles');

Q9List all flights with a distance of at least 400 and at most 1000 km.
SELECT flt_no, flt_distance
FROM flight
WHERE flt_distance BETWEEN 400 and 1000;

Note that the boundaries (400, 1000) are included.

List all flights not associated with an aircraft.
SELECT flt_no, flt_origin, flt_destination
FROM flight
WHERE airc_model IS NULL;

List all distinct pilot ids of pilots certified to fly a  Boeing aircraft.
SELECT DISTINCT pilot_ID
FROM certified
WHERE airc_model LIKE 'Boeing%';



