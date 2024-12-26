-- Q3, Find Total Conference Publications for each decade, starting from 1970 and ending in 2019
with win1 AS(
	SELECT year, count(*)
	FROM publications
	WHERE year is NOT NULL
	GROUP BY year
)
SELECT
    SUM(CASE WHEN year BETWEEN '1970' AND '1979' THEN count ELSE 0 END) AS "1970s",
    SUM(CASE WHEN year BETWEEN '1980' AND '1989' THEN count ELSE 0 END) AS "1980s",
	SUM(CASE WHEN year BETWEEN '1990' AND '1999' THEN count ELSE 0 END) AS "1990s",
	SUM(CASE WHEN year BETWEEN '2000' AND '2009' THEN count ELSE 0 END) AS "2000s",
	SUM(CASE WHEN year BETWEEN '2010' AND '2019' THEN count ELSE 0 END) AS "2010s"
FROM win1;
	