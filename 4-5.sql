-- Q5, find all conferences happening in June (Assume means recent, year 2018), where proceedings have more than 100 publications

WITH publications AS (
    SELECT booktitle, COUNT(*) AS number_of_publications, CAST(year AS INTEGER) AS year
    FROM INPROCEEDINGS
    GROUP BY booktitle, year
    UNION ALL
    SELECT booktitle, COUNT(*) AS number_of_publications, CAST(year AS INTEGER) AS year
    FROM PROCEEDINGS
    GROUP BY booktitle, year
)
SELECT booktitle
FROM publications
WHERE year = 2018 AND number_of_publications > 100;
	