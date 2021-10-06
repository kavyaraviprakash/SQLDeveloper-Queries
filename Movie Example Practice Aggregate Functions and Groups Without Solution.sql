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


-- ************** Aggregate Functions and Groups ****************

-- 1. Select the maximum, minimum, and average for all ratings


-- 2. Count the number of ratings


-- 3. Count the number of all movie_titles and count the number of all unique movie_titles


-- 4. Count the number of movies that are released each year and order by year.


-- 5. Count the number of movies for each category. The result should show the category name and the number of movies.
-- Sort your result by category name.

-- 6. Find out whether there is a difference in average movie rating for different occupations.
 

-- 7. Find all user_ID who only rated one movie. List the user ids.


-- 8. Display all user information of all users who only rated one movie.
-- Tip: Subqueries with IN, EXISTS, and JOIN will work here. Try all three options.

-- 9. Which user rated the most movies? And how many?
-- For this query, you should show the user_id and number of movies rated for all users and sort the result by number of movies
-- so that the highest number of movies are shown first.


-- 10. List the movie ID, movie title, and number of ratings
-- But only include movies with ratings > 1000


-- 11. List the movie ID, movie title, and number of ratings
-- But only include movies from year 1990.
-- Sort your result that the movie with the highest count is at the top.


-- 12. Find all movies with duplicate movie titles, list the movie_title


-- 13. Based on the previous query, count the number of movies with duplicate movie titles.


-- 14. How many users live in each zipcode? List the zipcode and number of users who live in that zipcode.
-- Sort your result so that the highest number of users are shown first.


-- 15. Find the max and min average rating for each category.
-- The result should show category name, and max and min average rating for all movies in that category.
-- This is a more complex query and there may be different ways to solve it. Start small and build on the results.
