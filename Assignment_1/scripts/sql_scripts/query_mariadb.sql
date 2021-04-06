SET GLOBAL query_cache_size=0;

SET PROFILING=1;

RESET QUERY CACHE;

SELECT SQL_NO_CACHE * FROM A WHERE A1<=50;

SELECT SQL_NO_CACHE * FROM B ORDER BY BINARY B3;

SELECT SQL_NO_CACHE avg(X) FROM (SELECT count(B1) AS X FROM B GROUP BY B2) AS T;

SELECT SQL_NO_CACHE A2, B1, B2, B3 FROM A INNER JOIN B ON A.A1=B.B2;

SHOW PROFILES;