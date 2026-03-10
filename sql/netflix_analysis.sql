-- =====================================================
-- Netflix Data Dashboard Project
-- Author: Mia
-- Purpose: Data exploration for Netflix dataset
-- =====================================================


-- -----------------------------------------------------
-- Total number of titles in the dataset
-- -----------------------------------------------------

SELECT COUNT(*) AS total_titles
FROM netflix_titles;


-- -----------------------------------------------------
-- Distribution of Movies vs TV Shows
-- -----------------------------------------------------

SELECT type, COUNT(*) AS total
FROM netflix_titles
GROUP BY type;


-- -----------------------------------------------------
-- Number of titles released per year
-- -----------------------------------------------------

SELECT release_year, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

-- -----------------------------------------------------
-- Top 10 countries with the most Netflix titles
-- -----------------------------------------------------

SELECT country, COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- -----------------------------------------------------
-- Distribution of content ratings (cleaned)
-- -----------------------------------------------------

SELECT rating, COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
AND rating NOT LIKE '%min%'
GROUP BY rating
ORDER BY total_titles DESC;

-- NOTE:
-- Some rows in the dataset contain duration values in the rating column
-- due to a known dataset formatting issue. These rows are filtered out.

-- -----------------------------------------------------
-- Titles added to Netflix per year
-- -----------------------------------------------------

SELECT SUBSTR(date_added, -4) AS year_added,
       COUNT(*) AS total_titles
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;

-- -----------------------------------------------------
-- Most common individual genres
-- -----------------------------------------------------

WITH RECURSIVE split_genres(show_id, genre, rest) AS (
    
    SELECT 
        show_id,
        '',
        listed_in || ','
    FROM netflix_titles

    UNION ALL

    SELECT
        show_id,
        TRIM(SUBSTR(rest, 0, INSTR(rest, ','))),
        SUBSTR(rest, INSTR(rest, ',') + 1)
    FROM split_genres
    WHERE rest <> ''
)

SELECT genre, COUNT(*) AS total_titles
FROM split_genres
WHERE genre <> ''
GROUP BY genre
ORDER BY total_titles DESC
LIMIT 10;

-- NOTE:
-- The 'listed_in' column contains multiple genres separated by commas.
-- This query splits the values into individual genres before counting them.