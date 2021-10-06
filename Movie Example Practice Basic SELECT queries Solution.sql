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

-- ************** Basic SELECT queries ***********

-- 1. List the years movies appeared. Remove duplicates. Order your result.

SELECT DISTINCT movie_year
FROM mgreiner.movielens_movie
ORDER BY movie_year;

-- 2. List the movie titles and year of movies released after 1995
 SELECT movie_title, movie_year
 FROM mgreiner.movielens_movie
 WHERE movie_year > 1995;

--3. List the movie titles and year of movies released in 1990 or 1995
 SELECT movie_title, movie_year
 FROM mgreiner.movielens_movie
 WHERE movie_year IN (1990, 1995);
 
-- 4. List the movies that did not appear in 1990 or 1995. Order your result by year with the newer movies first.
SELECT *
FROM mgreiner.movielens_movie
WHERE movie_year NOT IN (1990, 1995)
ORDER BY movie_year DESC;

-- 5. List all movie information for movies starting with A. Order your result by the title.

SELECT *
FROM mgreiner.movielens_movie
WHERE movie_title LIKE 'A%'
ORDER BY movie_title;

-- 6. List all movie ids and year that appeared in the year between (and including) 1993 and 1996. Order by movie_year.

SELECT movie_id, movie_year
FROM mgreiner.movielens_movie
WHERE movie_year BETWEEN 1993 AND 1996
ORDER BY movie_year;

SELECT movie_id, movie_year
FROM mgreiner.movielens_movie
WHERE movie_year >= 1993 and movie_year <= 1996
ORDER BY movie_year;

-- 7. List all users who live in zipcode 5548 or who have occupation with id 4 and age_range of 18.

SELECT *
FROM mgreiner.movielens_user
WHERE user_zipcode = 5548 OR (occup_id=4 AND age_id =18);



