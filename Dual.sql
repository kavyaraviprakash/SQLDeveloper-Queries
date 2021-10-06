Q1.
SELECT 'true' condition
FROM dual
WHERE 1 = ANY (1,2);

Q2.
SELECT 'true' condition
FROM dual
WHERE 1 = ANY (2, 3);

Q3.
SELECT 'true' condition
FROM dual
WHERE 1 <> ANY (1,2);

Q4.
SELECT 'true' condition
FROM dual
WHERE 1 <> ANY (1, 1)

Q5.
SELECT 'true' condition
FROM dual
WHERE 1 = ALL (1,2);

Q5.
SELECT 'true' condition
FROM dual
WHERE 1 = ALL (1,1,1);

Q6.
SELECT 'true' condition
FROM dual
WHERE 1 <> ALL (1,2)

Q7.
SELECT 'true' condition
FROM dual
WHERE 1 <> ALL (2,3);
