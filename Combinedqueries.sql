/* Q1 Write a query to select the project id, project status, project name, and launch year for all projects.
-- Order by launch year descending. */ -- Confirmed

SELECT proj_id, proj_status, proj_name, proj_launched_at_year
FROM ks_project;

/* Q2 - Write a query that lists all possible unique values for project status. */ -- Confirmed

SELECT DISTINCT proj_status
FROM ks_project;

/*Q3  -- Write a query that lists the id and name of all projects that were successful (project status) */ -- Confirmed

SELECT proj_id, proj_name
FROM ks_project
WHERE proj_status = 'successful';

/* Q4 -- Write a query that lists all project id and names for projects
-- that have either more than 20 backers or more than 10 comments */  -- Confirmed

SELECT proj_id, proj_name, proj_no_of_backers, proj_no_of_comments 
FROM ks_project
WHERE proj_no_of_backers > 20 OR proj_no_of_comments > 20
;


/* Q5 -- Write a query that selects all rewards that do not specify a shipping preference
-- Display all columns */ -- confirmed

SELECT rew_shipping,
       rew_title,
       rew_id,
       rew_limit,
       rew_minimum_pledge,
       rew_backers_count,
       rew_minimum_pledge,
       rew_tier
FROM   ks_reward
WHERE  rew_shipping IN ( 'Anywhere in the world' ); 

/* Q6 -- Write a query that returns the average, minimum, and maximum limit for all rewards
-- Round the average to two decimals
-- Use appropriate aliase for the columns */

SELECT 
        MIN(rew_limit) Minimum, MAX (rew_limit) Maximum,
        ROUND(AVG(rew_limit), 2) Average, SUM (rew_limit) Sum
FROM ks_reward
;

/* Q7 -- Write a query that provides some project statistics for each category
-- Display the project category (cat_id), the number of projects, average goal, average number of backers, 
-- and average pledged amount for each project category
-- Only include projects in categories with the number 10 or below */

SELECT  cat_id, 
        proj_status,
        COUNT (*),
        AVG(proj_goal),
        AVG(proj_no_of_backers),
        AVG (proj_pledged)
FROM ks_project
WHERE cat_id <= 10
GROUP BY cat_id, proj_status
;
     
/* Q12 --- Write a query that lists all projects with an above average goal.
-- Display project id, status, name, and goal */

SELECT proj_id, proj_status, proj_name, proj_goal
FROM ks_project
WHERE (proj_goal) > (SELECT AVG(proj_goal) FROM ks_project)
;

/* Q8 - Write a query that counts the number of rewards for each project
-- Display the project id and the count of rewards
-- Only include projects with more than 5 rewards */ -- Confirmed

 

/* Q9 -- Write a query that shows the creator id and name of creators with successful projects
-- Use a IN (subquery) construct */ -- Confirmed

SELECT cre_name, cre_id
FROM ks_creator
WHERE cre_id IN
       (SELECT cre_id
        FROM ks_project
        WHERE proj_status = 'successful');

/* Q10 -- Write a query that shows the user id and user name of all users who wrote a comment for projects located in the US
-- (use column project country in project table)
-- Use a sequence of nested IN (subquery) constructs to solve this. */ -- Confirmed

SELECT user_id, user_name
FROM ks_user
WHERE user_id IN (
        SELECT user_id
        FROM ks_comment
        WHERE proj_id IN (
                SELECT proj_id
               FROM ks_project
               WHERE proj_country = 'US')
               );

/* Q 11 -- Write a query that lists all user id and user name of users who did not write a comment for a project
-- with a goal < 2000. Your result should also include users who did not write any comment.
-- In your query, use one of the following types of Set difference operation (MINUS, NOT IN, NOT EXISTS) */

SELECT user_id, user_name
FROM ks_user
WHERE user_id IN (
        SElECT user_id
        FROM ks_comment
        WHERE proj_id NOT IN (
               SELECT proj_id
               FROM ks_project
               WHERE proj_goal < 2000)
               );
/* Q13 -- Write a query that shows the project id, project name, project status, reward title, and reward tier
-- for all projects launched in 2018. Use a join. */
               
SELECT a.rew_title, a.rew_tier, u.proj_name, u.proj_status, u.proj_id
FROM ks_project u
       JOIN ks_reward a ON u.proj_id = a.proj_id
       WHERE u.proj_launched_at_year = 2018; 
       
/* Q14 -- Write a query to display the user id, user name, comment, project id,
-- project name, and the location type for all users who wrote a comment
-- Use multiple joins.*/

SELECT u.user_id, u.user_name, c.com_comment, p.proj_id, p.proj_name, p.proj_country
FROM ks_user u
JOIN ks_comment c ON u.user_id = c.user_id
JOIN ks_project p ON p.proj_id = c.proj_id;

/* Q15 -- Write a query that lists the creator id, name, location name (creator bio table), and location id of all creators.
-- If the creator has no bio, then the columns for location name and loation id should be NULL. */ -- confirmed


--SELECT *
--FROM ks_creator_bio b
--LEFT JOIN ks_creator c ON b.cre_id = c.cre_id;


SELECT *
FROM ks_creator c
LEFT JOIN ks_creator_bio b ON c.cre_id = b.cre_id;

/* Q 16 -- Write a query that displays the category hierarchy (two levels).
-- Display the category id and category name as well as the second level category and category name.
-- The parent id contains the number of the higher level (first level) category.
-- For example, the category Dance has sub categories Residencies, Worshops, Spaces, and Performances
-- The first row would show 6 Dance 255 Residencies
-- The second row would show 6 Dance 257 Workshops
-- The third rwo would show 6 Dance 256 Spaces
-- Order by category id ascending. */

SELECT a.cat_name sub_category,
       b.cat_name main_category
FROM   ks_category  a
       INNER JOIN ks_category b
               ON a.parent_id = b.cat_id; 

/* Q 17 -- Write a query that shows the projects that have comments
-- Display the project id and project name only
-- Use a semi-join */

SELECT proj_id, proj_name
FROM ks_project
WHERE EXISTS
(SELECT proj_id FROM ks_comment
WHERE ks_project.proj_id = ks_comment.proj_id )
ORDER BY proj_id;


/* Q18 -- Write a query of all creators that do not have projects in the US (use column proj_country in project table)
-- Display the creator id and name only
-- Use NOT EXISTS */

SELECT cre_id, cre_name
FROM ks_creator
WHERE NOT EXISTS (
          SELECT cre_id
          FROM ks_project
          WHERE proj_country = 'US'
          AND ks_creator.cre_id = ks_project.cre_id
);

/* Q19 -- Write a query that display all projects that were successful
-- and all projects that are located in a 'Town' (ks_location column loc_type)
-- Display the project id, name, status, and url
-- Use a UNION operator */
-- Using Union approach
SELECT proj_id, proj_name, proj_status, proj_url
FROM ks_project
WHERE proj_status = 'successful'
UNION
SELECT proj_id, proj_name, proj_status, proj_url
FROM ks_project
WHERE loc_id IN (
     SELECT loc_id
     FROM ks_location
     WHERE loc_type = 'Town');
     
/* Q20 -- Write a query that shows the project id, name, and the difference between the project pledge and project goal
-- In addition, show a column that shows the level of pledge fullfillment
-- If nothing was pleged, then show the text 'nothing pledge'
-- If the pledge amount exceeds then goal, then show the text 'enough money pledged'
-- If the pledge amount exceeds then goal, then show the text 'not enough money pledged'
-- If the pledge amount exactly equals the goal, then show the text 'exactly right' */

SELECT proj_id,proj_name,p.proj_goal, p.proj_pledged, (p.proj_pledged - p.proj_goal) as difference,
           CASE
                WHEN (p.proj_pledged - p.proj_goal) < p.proj_goal THEN 'not enough money pledged'
                WHEN (p.proj_pledged - p.proj_goal) > p.proj_goal THEN 'enough money pledged'
                WHEN (p.proj_pledged - p.proj_goal) = p.proj_goal THEN 'exactly right'
                ELSE 'nothing pledge'
           END pledge_fullfillment
FROM ks_project p;

/*Q21-- Write a query that shows the project id, country (proj_country column), project status
-- and the number of backers for projects.
-- For each country, show the project(s) that the highest number of backers.
-- Use a correlated subquery to solve this. (hint: you do not need GROUP BY for this query)*/ -- confirmed

SELECT proj_id, proj_country, proj_status, proj_no_of_backers
FROM ks_project oq
WHERE proj_no_of_backers = (
      SELECT MAX(proj_no_of_backers)
      FROM ks_project iq
      WHERE iq.proj_country = oq.proj_country);
      
/* Q22 -- Write a query that ranks the projects for each year by number of backers.
-- The result displays the project year, number of backers, the ranking of the project within
-- each year by number of backers (highest number of backers first), the project id, and the count of
-- of the number of projects in that year.
-- This query requires a window function.
-- For example, the year 2009 has four projects, the first five rows of the result show
-- 2009, 15, 1, (proj_id number), 4
-- 2009, 7, 2, (proj_id number), 4
-- 2009, 1, 3, (proj_id number), 4
-- 2009, 0, 4, (proj_id number), 4
-- 2010, 89, 1, (proj_id number), 26 */ --- confirmed

SELECT proj_launched_at_year
       , proj_no_of_backers 
       , RANK () OVER (PARTITION BY proj_launched_at_year ORDER BY proj_no_of_backers DESC) ranks
       ,proj_id
       , COUNT (*) OVER (PARTITION BY proj_launched_at_year) counts
FROM ks_project
ORDER BY proj_launched_at_year, proj_no_of_backers DESC
;

/* Q23 -- Create an index on the proj_country in the project table. */ -- need to check

CREATE INDEX ks_project_idx
ON ks_project (proj_country);


/* Q24 -- Write a query that calculates the number of projects for each country (proj_country column in project table) .
-- Display the country and number of projects.
-- Only include countries with more than 3 projects.
-- Order by number of projects descending, and country ascending.
-- Use a WITH clause */ -- confirmed

WITH cte_count AS (
  SELECT proj_country,
  COUNT (*) OVER (PARTITION BY proj_country) proj_count
  FROM ks_project  
 )
 
SELECT proj_country, proj_count
FROM cte_count
WHERE proj_count > 3
ORDER BY proj_country ASC, proj_count DESC;

/* Q 25 -- Write a query that shows the project id, name, goal, pledged,
-- the difference between pledged and goal (pledged - goal), and the
-- percentage the goal was fulfilled by the pledge (e.g., goal = 2000, pledge = 1000, fulfilled: 50(%))
-- Round the percentage to two decimals. */

SELECT proj_id,proj_name,p.proj_goal, p.proj_pledged, 
       (p.proj_pledged - p.proj_goal) as difference, 
       ROUND(((p.proj_pledged/p.proj_goal)*100),2) as percentage_fulfilled
FROM ks_project p       

/* Q26 -- Write a CREATE statement that creates a table that establishes a
-- many to many relationship between ks_user and ks_project
-- Name the table ks_favorite
-- Columns: fav_id is data type NUMBER (*,0)
--          proj_id is the same data type as the proj_id column in ks_project
--          user_id is the same data type as the user_id column in ks_user
--          fav_rank is data type NUMBER (*,0)
-- primary key is column fav_id
-- foreign key proj_id links to the proj_id column in ks_project
-- foreign key user_id links to the user_id column in ks_user
-- Remember that the Oracle data types can be found in the CREATE Kickstarter.sql file. */


CREATE TABLE ks_favorite(
	fav_id  NUMBER (*,0),
	proj_id NUMBER (*,0),
	user_id VARCHAR2 (100),
	fav_rank  NUMBER (*,0),
	CONSTRAINT pk_favorite PRIMARY KEY (fav_id),
	CONSTRAINT fk_favorite_project FOREIGN KEY (proj_id) REFERENCES ks_project (proj_id),
	CONSTRAINT fk_favorite_user FOREIGN KEY (user_id) REFERENCES ks_user (user_id)
);