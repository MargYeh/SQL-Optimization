# SQL-Optimization

This mini project runs some queries on a dataset of computer science papers with PostgresSQL. The full writeup is located in ```SQL Optimization Writeup.pdf```.

## Table Creation
Tables are set up in Postgres using the instructions in ```SQL Optimization Project Instructions.pdf```

## Sample SQL and Optimization
1. Prompt: Write a SQL Query to find all the conferences held in 2018 that have published at least 200 papers in a single decade
   - Original Query:
```
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
```

Query plan from EXPLAIN:

![image](https://github.com/user-attachments/assets/e82922ae-1110-48e5-a46d-9fec3d64db02)

Runtime with EXPLAIN ANALYZE:

![image](https://github.com/user-attachments/assets/14b34e0d-7d06-4c9b-9f58-d4a15b5fa73a)

Runtime after indexing using:
```
CREATE INDEX idx_inproceedings_year ON inproceedings (year);
CREATE INDEX idx_inproceedings_booktitle ON inproceedings (booktitle);
```
![image](https://github.com/user-attachments/assets/ec5265f1-9a9d-4610-9776-8e644f846c1a)

Changing the query - Using joins for the tables instead of IN, some change in selection to avoid repeat lookup:
```
WITH win1 AS (
    SELECT booktitle
    FROM inproceedings
    WHERE year BETWEEN '2008' AND '2017'
    GROUP BY booktitle
    HAVING COUNT(*) >= 200
)
SELECT DISTINCT i.booktitle
FROM inproceedings i
JOIN win1 w ON i.booktitle = w.booktitle
WHERE i.year = '2018';
```
Runtime after all changes:

![image](https://github.com/user-attachments/assets/959b9f4f-d072-4371-bcdd-3ac8660a0673)

The answers for the rest of the questions 2-5 are located within the writeup PDF.

##

## Answer to Miniproject questions:
1. How do you improve query performance from your initial query?
  - Queries can be optimized by either rewriting the query so that it is more efficient, such as avoiding anything that scans the entire table. Reorganizing the order of filters within the query and optimizing joins can also lead to faster runtimes. 
2. Where do you create new indexes?
  - Creating indexes for popular columns should also improve runtimes. Below is a list of indexes that were created. They are picked from common targets used by all 5 queries.  
3. What was the impact of new index creation in terms of query cost and performance?
  - Usually after indexing, the query cost planning time increased but the execution time decreased. 

