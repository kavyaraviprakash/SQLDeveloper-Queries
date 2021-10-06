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


-- ************** Subqueries *********************

-- 1. List all user info for users who are 'college/grad student'

SELECT *
FROM mgreiner.movielens_user
WHERE occup_id IN ( SELECT occup_id
                    FROM MGREINER.movielens_occupation
                    WHERE occup_occupation = 'college/grad student');

-- 2. Select the max, min, and average for all Adventure movies
SELECT MAX(rat_rating), MIN(rat_rating), AVG (rat_rating)
FROM mgreiner.movielens_rating
WHERE movie_ID IN (SELECT movie_ID
                   FROM movielens_moviecategory
                   WHERE categ_ID IN (SELECT categ_ID
                                      FROM mgreiner.movielens_category
                                      WHERE categ_category = 'Adventure')
                   );

-- 3. Display movies with above average rating.

SELECT movie_ID, AVG (rat_rating)
FROM mgreiner.movielens_rating
GROUP BY movie_ID
HAVING AVG(rat_rating) > (SELECT AVG (rat_rating)
                          FROM mgreiner.movielens_rating);

-- 4. Display users who gave above average rating.
-- Display user_id, the average rating the user gave, and the average rating for all movies.

SELECT user_ID, AVG (rat_rating) avgRating, (SELECT AVG (rat_rating) FROM mgreiner.movielens_rating) AS avgRatingAllMovies
FROM mgreiner.movielens_rating
GROUP BY user_ID
HAVING AVG(rat_rating) > (SELECT AVG (rat_rating)
                          FROM mgreiner.movielens_rating);

-- 5. For each movie, display the movie id and the newest rating(s) (i.e., highest timestamp number).
-- Hint: You need a correlated subquery

SELECT movie_id, rat_rating, rat_timestamp
FROM mgreiner.movielens_rating oq
WHERE rat_timestamp = ( SELECT MAX(rat_timestamp)
                        FROM mgreiner.movielens_rating sq
                        WHERE sq.movie_id = oq.movie_id);

-- 6. For each user show the movie_id of the movie s/he rated last (i.e., rating with highest timestamp number).
-- HInt: You need a correlated subquery

SELECT user_id, movie_id, rat_timestamp
FROM mgreiner.movielens_rating oq
WHERE rat_timestamp = ( SELECT MAX(rat_timestamp)
                        FROM mgreiner.movielens_rating sq
                        WHERE sq.user_id = oq.user_id);

-- 7. Select the year(s) with the highest number of movies
-- This is a complex query with nested subqueries. You could also use WITH to organize your query. I'll show both.

-- Subqueries
SELECT movie_year
FROM (SELECT movie_year, COUNT (*) movieCount
 FROM mgreiner.movielens_movie
 GROUP BY movie_year) counters
WHERE counters.movieCount =
  (SELECT MAX(movieCount)
  FROM
    (SELECT movie_year, COUNT (*) movieCount
    FROM mgreiner.movielens_movie
    GROUP BY movie_year)
  );
  
-- WITH
WITH yearMovieCount AS
(SELECT movie_year, COUNT (*) movieCount
 FROM mgreiner.movielens_movie
 GROUP BY movie_year)

SELECT movie_year
FROM yearMovieCount
WHERE movieCount =
  (SELECT MAX(movieCount)
  FROM yearMovieCount)
;

-- 8. Are there any movies without ratings? Use a subquery to write a query that answers the question.

SELECT *
FROM mgreiner.movielens_movie
WHERE movie_id NOT IN (
    SELECT movie_id
    FROM mgreiner.movielens_rating
    );

SELECT *
FROM mgreiner.movielens_movie oq
WHERE NOT EXISTS (
    SELECT *
    FROM mgreiner.movielens_rating sq
    WHERE oq.movie_id = sq.movie_id
    );

-- 9. Are there any movies without ratings? Use a subquery to write a query that answers the question.

SELECT *
FROM mgreiner.movielens_user
WHERE user_id NOT IN (
    SELECT movie_id
    FROM mgreiner.movielens_rating
    );

SELECT *
FROM mgreiner.movielens_user oq
WHERE NOT EXISTS (
    SELECT *
    FROM mgreiner.movielens_rating sq
    WHERE oq.user_id = sq.user_id
    );


