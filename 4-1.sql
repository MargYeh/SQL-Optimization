-- Q1, Find conferences held in 2018 that have published at least 200 papers in a single decade
WITH win1 AS (
    SELECT booktitle
    FROM inproceedings
    WHERE year BETWEEN '2008' AND '2018'
    GROUP BY booktitle
    HAVING COUNT(*) >= 200
)
SELECT DISTINCT booktitle
FROM inproceedings
WHERE year = '2018'
  AND booktitle IN (SELECT booktitle FROM win1);