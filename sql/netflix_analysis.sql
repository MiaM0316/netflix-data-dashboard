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