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

-- **************** Set-oriented operations *****************

-- 1. Find all users who did not rate a movie and display the list of user_IDs

SELECT user_ID
FROM mgreiner.movielens_user
MINUS
SELECT user_ID
FROM mgreiner.movielens_rating;

-- 2. Are there any movies without ratings? Use a subquery to write a query that answers the question.

SELECT movie_id
FROM mgreiner.movielens_movie
MINUS
SELECT movie_id
FROM mgreiner.movielens_rating;

-- 3. Show all movie information for movies sorted in either category 'Adventure' or category 'Western'

SELECT mov.*
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_moviecategory movcat ON mov.movie_id = movcat.movie_id
    JOIN mgreiner.movielens_category cat ON movcat.categ_id = cat.categ_id
WHERE cateG_category = 'Adventure'
UNION
SELECT mov.*
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_moviecategory movcat ON mov.movie_id = movcat.movie_id
    JOIN mgreiner.movielens_category cat ON movcat.categ_id = cat.categ_id
WHERE cateG_category = 'Western';

-- 4. Show all movie information for movies sorted in category 'Adventure' but not into 'Western'

SELECT mov.*
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_moviecategory movcat ON mov.movie_id = movcat.movie_id
    JOIN mgreiner.movielens_category cat ON movcat.categ_id = cat.categ_id
WHERE cateG_category = 'Adventure'
MINUS
SELECT mov.*
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_moviecategory movcat ON mov.movie_id = movcat.movie_id
    JOIN mgreiner.movielens_category cat ON movcat.categ_id = cat.categ_id
WHERE cateG_category = 'Western';

-- 5. Show all movie information for movies sorted in both category 'Adventure' and 'Western'

SELECT mov.*
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_moviecategory movcat ON mov.movie_id = movcat.movie_id
    JOIN mgreiner.movielens_category cat ON movcat.categ_id = cat.categ_id
WHERE cateG_category = 'Adventure'
INTERSECT
SELECT mov.*
FROM mgreiner.movielens_movie mov
    JOIN mgreiner.movielens_moviecategory movcat ON mov.movie_id = movcat.movie_id
    JOIN mgreiner.movielens_category cat ON movcat.categ_id = cat.categ_id
WHERE cateG_category = 'Western';

-- 6. DIVISION: Are there any users who rated movies in all categories?

SELECT user_id
FROM mgreiner.movielens_user
MINUS
SELECT user_id
FROM (
    SELECT categ_id, user_id
    FROM mgreiner.movielens_moviecategory movcat CROSS JOIN mgreiner.movielens_user
    MINUS
    SELECT categ_id, user_id
    FROM mgreiner.movielens_rating mov
        JOIN mgreiner.movielens_moviecategory movcat ON mov.movie_id = movcat.movie_id
    );
