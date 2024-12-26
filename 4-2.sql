-- Q2, Find Authors who published at least 10 PVLDB papers and at least 10 SIGMOD papers 
WITH win1 AS (
    SELECT p.author
    FROM inproceedings p
    JOIN articles a ON a.author = p.author
    WHERE (p.booktitle LIKE '%VLDB%' OR a.title LIKE '%VLDB%')
      AND p.author IS NOT NULL
    GROUP BY p.author
    HAVING COUNT(*) >= 10
),
win2 AS (
    SELECT p.author
    FROM inproceedings p
    JOIN articles a ON a.author = p.author
    WHERE (p.booktitle LIKE '%SIGMOD%' OR a.title LIKE '%SIGMOD%')
      AND p.author IS NOT NULL
    GROUP BY p.author
    HAVING COUNT(*) >= 10
)
SELECT a.author
FROM win1 a
JOIN win2 b ON a.author = b.author;