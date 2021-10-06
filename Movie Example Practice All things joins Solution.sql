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


-- ************** All things JOINS ***************

-- 1. List the movie ID, movie title, and number of ratings for each movie

SELECT m.movie_ID, m.movie_title, count (*)
FROM mgreiner.movielens_movie m JOIN mgreiner.movielens_rating r ON m.movie_ID = r.movie_ID
GROUP BY m.movie_ID, m.movie_title;

-- 2. List the user id, gender, zipcode, occupation, and age for all users who rated a movie.
-- Each user should appear once. Order your result.

SELECT DISTINCT us.user_id, user_gender, user_zipcode, age_range, occup_occupation
FROM mgreiner.movielens_user us
    JOIN mgreiner.movielens_age age ON us.age_id = age.age_id
    JOIN mgreiner.movielens_occupation occ ON us.occup_id = occ.occup_id
    JOIN mgreiner.movielens_rating rat ON rat.user_id = us.user_id
ORDER BY user_id;

SELECT us.user_id, user_gender, user_zipcode, age_range, occup_occupation
FROM mgreiner.movielens_user us
    JOIN mgreiner.movielens_age age ON us.age_id = age.age_id
    JOIN mgreiner.movielens_occupation occ ON us.occup_id = occ.occup_id
WHERE user_id IN (
    SELECT user_id
    FROM mgreiner.movielens_rating)
ORDER BY user_id;

-- 3. Select the max, min, and average for all Adventure movies

SELECT MAX(rat_rating), MIN(rat_rating), AVG (rat_rating)
FROM mgreiner.movielens_rating rat
  JOIN mgreiner.movielens_moviecategory mcat ON rat.movie_ID = mcat.movie_ID
  JOIN mgreiner.movielens_category cat ON mcat.categ_ID = cat.categ_ID
WHERE categ_category = 'Adventure';



-- 4. List all user info for users who are 'college/grad student'

SELECT us.*
FROM mgreiner.movielens_user us
    JOIN mgreiner.movielens_occupation occ ON us.occup_id = occ.occup_id
WHERE occup_occupation = 'college/grad student';

-- 5. List all user_id and movie_id for each rating. Include all user_ids, even if the user did not rate a movie.

SELECT u.user_ID, movie_id
FROM mgreiner.movielens_user u LEFT JOIN mgreiner.movielens_rating r ON u.user_ID = r.user_ID;

-- 6. Find all users who did not rate a movie and display the list of user_IDs only (use a left or right join)

SELECT u.user_ID
FROM mgreiner.movielens_user u LEFT JOIN mgreiner.movielens_rating r ON u.user_ID = r.user_ID
WHERE r.user_ID IS NULL;

-- 7. Find all users who did not rate a movie and display the list of user_IDs (Antijoin, use NOT EXISTS)

SELECT user_ID
FROM mgreiner.movielens_user
WHERE NOT EXISTS
(SELECT user_ID
 FROM mgreiner.movielens_rating
 WHERE mgreiner.movielens_user.user_ID = mgreiner.movielens_rating.user_ID);

-- 8. Find all users who did not rate a movie and display the list of user_IDs  (Antijoin, use NOT IN)

SELECT user_ID
FROM mgreiner.movielens_user
WHERE user_ID NOT IN(
 SELECT user_ID
 FROM mgreiner.movielens_rating);

-- 9. Self-join: List all movie_titles that are duplicates.
-- Hint: This requires a self-join. The idea would be that movies could join on the same title but still have different movie_ids.

SELECT DISTINCT movie1.movie_title
FROM mgreiner.movielens_movie movie1
    JOIN mgreiner.movielens_movie movie2 ON movie1.movie_title = movie2.movie_title AND movie1.movie_id <> movie2.movie_id;

-- 10. Self-join: List all pairs of movies that were released in the same year.
-- The result should contain three columns: movie_id first movie, movie_id second movie, year.
-- A pair should appear only once in the output.

SELECT movie1.movie_id, movie2.movie_id, movie1.movie_year
FROM mgreiner.movielens_movie movie1
    JOIN mgreiner.movielens_movie movie2 ON movie1.movie_year = movie2.movie_year
WHERE movie1.movie_id > movie2.movie_id;






