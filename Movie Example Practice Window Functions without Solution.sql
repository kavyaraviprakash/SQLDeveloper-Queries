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



-- 2. Similar to the previous question, but this time, do not show the movie ids, but the genres the user rated.
-- This will require a join and a subquery. A simple join will not work, since a movie have several categories
-- and this would inflate the count of the ratings.


-- 3. Rank the movies according to their rating count.
-- Order your result by ratingCount descending and movie id ascending.



-- 4. For each year, count the number of movies, using a Window Function
-- Order your result by movie year.



-- 5. Similar to the previous query. For each year, count the number of movies, and calculate a running sum.



-- 6. For each year, calculate the average movie rating using a Window Function.



-- 7. Similar to previous query: For each year, calculate the average movie rating, and a moving average.
-- I did use a subquery for this, and calculated the moving average on the subquery.

