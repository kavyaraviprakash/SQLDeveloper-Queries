CREATE SEQUENCE pilot_id_sq
INCREMENT BY 100
START WITH 9000;

INSERT INTO pilot (pilot_name, pilot_ID, pilot_salary)
VALUES ('Morgensen', pilot_id_sq.nextval,  98000);

SELECT *
FROM pilot;

-- A sequence is a separate database object and does not belong to table

SELECT pilot_ID_sq.currval
FROM dual;

SELECT pilot_ID_sq.nextval
FROM dual;

INSERT INTO pilot (pilot_name, pilot_ID, pilot_salary)
VALUES ('Black', pilot_id_sq.nextval,  98500);

