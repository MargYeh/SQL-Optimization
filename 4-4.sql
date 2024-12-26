-- Q4, Find top 10 authors publishing in journals and conferences that have the word 'data' in the title
WITH win AS (
	SELECT a.author, a.title FROM articles a
	WHERE a.title LIKE '%Data%'
	AND a.author IS NOT NULL
	UNION
	SELECT p.author, p.title FROM inproceedings p
	WHERE p.title LIKE '%Data%'
	AND p.author IS NOT NULL
	)

SELECT author, COUNT(*) AS num_titles FROM win
GROUP BY author
ORDER BY num_titles DESC
LIMIT 10;	
