-- There are five different tables that belong to this database
-- mgreiner.movielens_movie : contains the ID, movie title, and movie year for a selection of movies.
-- mgreiner.movielens_category : contains all movie genres
-- mgreiner.movielens_moviecategory : associates movie and category. A movie can be categorized in several categories, a category can belong to several movies
-- mgreiner.movielens_occupation : contains a list of occupation occup_ID is foreign key in user table
-- mgreiner.movielens_age : contains a list of age ranges age_ID is a foreign key in user table
-- mgreiner.movielens_user : user table that contains user id, gender, zipcode, age, and occupation
-- mgreiner.movielens_rating : rating table that associated user with movie. Each rating has a rating and a timestamp (seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970).
-- A user can rate many movies. A movie can be rated by many users
-- The UNIX timestamp can be converted with the following query:

SELECT to_char(TO_DATE('19700101','yyyymmdd') + numtodsinterval(rat_timestamp,'second'), 'YYYY-MON-DD HH24:MI AM') "thedate"
FROM mgreiner.movielens_rating;

-- First, do a SELECT * on all seven movies and familiaries yourself with the columns and data
-- describe can also be used to get more information about the table structure
SELECT *
FROM mgreiner.movielens_movie;

SELECT *
FROM mgreiner.movielens_category;

SELECT *
FROM  mgreiner.movielens_moviecategory;

SELECT *
FROM mgreiner.movielens_occupation;

SELECT *
FROM mgreiner.movielens_age;

SELECT *
FROM mgreiner.movielens_user;

SELECT *
FROM mgreiner.movielens_rating;

describe  mgreiner.movielens_rating;

-- ************* CASE **********************

-- 1. Replace the years with decade, e.g., '90s' for moviees released between and including 1990 and 1999
-- Do these for all years present in the dataset. Tip, write a query that gives you the max and min of the years first.
-- Display movie_id, title, year, and decade. Order by the movie_id

SELECT MAX(movie_year), MIN (movie_year)
FROM mgreiner.movielens_movie;

SELECT movie_id,  movie_title, movie_year,
    CASE
        WHEN movie_year BETWEEN 1910 AND 1919 THEN '10s'
        WHEN movie_year BETWEEN 1920 AND 1929 THEN '20s'
        WHEN movie_year BETWEEN 1930 AND 1939 THEN '30s'
        WHEN movie_year BETWEEN 1940 AND 1949 THEN '40s'
        WHEN movie_year BETWEEN 1950 AND 1959 THEN '50s'
        WHEN movie_year BETWEEN 1960 AND 1969 THEN '60s'
        WHEN movie_year BETWEEN 1970 AND 1979 THEN '70s'
        WHEN movie_year BETWEEN 1980 AND 1989 THEN '80s'
        WHEN movie_year BETWEEN 1990 AND 1999 THEN '90s'
        WHEN movie_year BETWEEN 2000 AND 2009 THEN '00s'
        ELSE 'N/A'
    END decade
FROM mgreiner.movielens_movie
ORDER BY movie_id;

SELECT movie_id,  movie_title, movie_year,
    CASE
        WHEN movie_year <= 1919 THEN '10s'
        WHEN movie_year <= 1929 THEN '20s'
        WHEN movie_year <= 1939 THEN '30s'
        WHEN movie_year <= 1949 THEN '40s'
        WHEN movie_year <= 1959 THEN '50s'
        WHEN movie_year <= 1969 THEN '60s'
        WHEN movie_year <= 1979 THEN '70s'
        WHEN movie_year <= 1989 THEN '80s'
        WHEN movie_year <= 1999 THEN '90s'
        WHEN movie_year <= 2009 THEN '00s'
        ELSE 'N/A'
    END decade
FROM mgreiner.movielens_movie
ORDER BY movie_id;

-- 2. Display all movie ratings. Display movie_id, user_id, rating, timestamp.
-- In addition, for each rating display:
-- 1 = 'Very low'
-- 2 = 'Low'
-- 3 = 'Neutral'
-- 4 = 'High'
-- 5 = 'Very high'

SELECT movie_id, user_id, rat_rating, rat_timestamp,
    CASE rat_rating
        WHEN 1 THEN 'Very low'
        WHEN 2 THEN 'Low'
        WHEN 3 THEN 'Neutral'
        WHEN 4 THEN 'High'
        WHEN 5 THEN 'Very high'
    END rating
FROM mgreiner.movielens_rating;
