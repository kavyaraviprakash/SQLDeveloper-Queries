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


-- ************** Window Functions *****************

-- 1. For each user, show the id, number of movie rated, and movie ids the user rated.

SELECT user_id, COUNT (*) OVER (PARTITION BY user_id), movie_id
FROM mgreiner.movielens_rating;

-- 2. Similar to the previous question, but this time, do not show the movie ids, but the genres the user rated.
-- This will require a join and a subquery. A simple join will not work, since a movie have several categories
-- and this would inflate the count of the ratings.

SELECT DISTINCT user_id, ratCount, categ_category
FROM(SELECT user_id, COUNT (*) OVER (PARTITION BY user_id) ratCount, movie_id
    FROM mgreiner.movielens_rating) rat
    JOIN mgreiner.movielens_moviecategory movcat ON rat.movie_id = movcat.movie_id
    JOIN mgreiner.movielens_category cat ON cat.categ_id = movcat.categ_id;

-- 3. Rank the movies according to their rating count.
-- Order your result by ratingCount descending and movie id ascending.

SELECT movie_id, COUNT (*) ratCount, RANK() OVER (ORDER BY COUNT (*) DESC)
FROM mgreiner.movielens_rating
GROUP BY movie_id
ORDER BY ratCount DESC, movie_id ASC;

-- 4. For each year, count the number of movies, using a Window Function
-- Order your result by movie year.

SELECT DISTINCT movie_year, COUNT(*) OVER (PARTITION BY movie_year) numOfMovies
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_rating rat ON mov.movie_id = rat.movie_id
ORDER BY movie_year;

-- 5. Similar to the previous query. For each year, count the number of movies, and calculate a running sum.

SELECT DISTINCT movie_year, COUNT(*) OVER (PARTITION BY movie_year) numOfMovies, COUNT (*) OVER (ORDER BY movie_year) totalSum
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_rating rat ON mov.movie_id = rat.movie_id
ORDER BY movie_year;

-- 6. For each year, calculate the average movie rating using a Window Function.

SELECT DISTINCT movie_year, ROUND(AVG(rat_rating) OVER (PARTITION BY movie_year), 2) ratAvg
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_rating rat ON mov.movie_id = rat.movie_id
ORDER BY movie_year;

-- 7. Similar to previous query: For each year, calculate the average movie rating, and a moving average.
-- I did use a subquery for this, and calculated the moving average on the subquery.

SELECT movie_year, ratAvg, ROUND(AVG (ratAvg) OVER (ORDER BY movie_year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2)  movAverage
FROM (
    SELECT DISTINCT movie_year, ROUND(AVG(rat_rating) OVER (PARTITION BY movie_year), 2) ratAvg
    FROM mgreiner.movielens_movie mov
        JOIN mgreiner.movielens_rating rat ON mov.movie_id = rat.movie_id
    )
ORDER BY movie_year;
