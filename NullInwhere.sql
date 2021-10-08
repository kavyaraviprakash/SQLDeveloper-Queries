
SELECT 'true' "Value"
FROM dual
WHERE NULL IS NULL;

SELECT 'true' "Value"
from dual
WHERE NULL = NULL;

SELECT 'true' "Value"
from dual
WHERE NOT (NULL = NULL);

SELECT 'true' "Value"
FROM dual
WHERE NULL = 0;

SELECT 'true' "Value"
FROM dual
WHERE NOT (NULL = 0);

SELECT 'true' "Value"
from dual
WHERE NULL <> 0;

SELECT 'true' "Value"
FROM dual
WHERE NOT(NULL <> 0);

SELECT 'true' "Value"
from dual
WHERE 5 IN (5, NULL);

SELECT 'true' "Value"
from dual
WHERE 5 NOT IN (1, NULL);

SELECT NULL+5 "Value"
from dual;

SELECT '' "Value"
from dual;

SELECT ' ' "Value"
from dual;
