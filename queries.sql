DROP VIEW IF EXISTS lessons_per_month;
DROP VIEW IF EXISTS student_siblings;
DROP VIEW IF EXISTS show_instructors;
DROP VIEW IF EXISTS ensembles_next_week;


-- VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW VIEW


-- Show the number of lessons given per month during a specified year
-- Expected to be performed a few times per week
-- total number of lessons per month
-- the specific number of individual lessons, group lessons and ensembles (three numbers per month)
CREATE VIEW lessons_per_month AS
SELECT EXTRACT(YEAR from bo.date) AS year, EXTRACT(MONTH from bo.date) AS month,
COUNT(*) AS lessons_given,
SUM(CASE WHEN le.lesson_type_id = 1 THEN 1 ELSE 0 END) AS individual,
SUM(CASE WHEN le.lesson_type_id = 2 THEN 1 ELSE 0 END) AS group,
SUM(CASE WHEN le.lesson_type_id = 3 THEN 1 ELSE 0 END) AS ensemble
FROM lesson AS le 
INNER JOIN booking AS bo ON bo.id = le.booking_id
GROUP BY month, year
ORDER BY month;



-- Show how many students there are with no sibling, with one sibling, with two siblings
-- expected to be performed a few times per week
CREATE VIEW student_siblings AS
SELECT siblings, COUNT(*) AS students FROM (SELECT COUNT(sibling_id) AS siblings FROM sibling GROUP BY student_id) AS a
GROUP BY siblings
UNION
SELECT 0, (SELECT SUM(CASE WHEN id NOT IN (SELECT student_id FROM sibling) THEN 1 ELSE 0 END) AS b)
FROM student
ORDER BY siblings;



-- List all instructors who has given more than a specific number of lessons during the current month
-- Sum all lessons, independent of type, and sort the result by the number of given lessons
-- will be executed daily
CREATE VIEW show_instructors AS 
SELECT ins.name, ins.person_number, ins.phone, COUNT(*) AS lessons_given FROM instructor AS ins 
INNER JOIN booking AS bo ON ins.id = bo.instructor_id 
WHERE (SELECT EXTRACT(MONTH FROM bo.date)) = (SELECT EXTRACT(MONTH FROM NOW()))
GROUP BY ins.name, ins.person_number, ins.phone
ORDER BY COUNT(*) DESC;


-- List all ensembles held during the next week
-- sorted by music genre and weekday
-- For each ensemble tell whether it's full booked, has 1-2 seats left or has more seats left.
CREATE VIEW ensembles_next_week AS
SELECT EXTRACT(dow from bo.date) AS day_of_week, g.genre AS genre, le.booking_id AS booking_id, bo.date, bo.time AS start_time, 
CASE
    WHEN le.max_number_of_students - COUNT(*) FILTER (WHERE student_id IN (SELECT student_id FROM booked_students)) < 0 THEN 'fully booked'
    WHEN le.max_number_of_students - COUNT(*) FILTER (WHERE student_id IN (SELECT student_id FROM booked_students)) > 2 THEN 'more than 2 seats left'
    WHEN le.max_number_of_students - COUNT(*) FILTER (WHERE student_id IN (SELECT student_id FROM booked_students)) BETWEEN 1 AND 2 THEN '1-2 seats left'
END AS situation
FROM lesson AS le
INNER JOIN booking AS bo ON bo.id = le.booking_id 
INNER JOIN lesson_type AS lt ON lt.id = le.lesson_type_id
INNER JOIN genre AS g ON g.id = le.genre_id
INNER JOIN booked_students AS bs ON bs.booking_id=le.booking_id
WHERE (SELECT EXTRACT(WEEK FROM bo.date)) = (SELECT EXTRACT(WEEK FROM NOW() + INTERVAL '1 WEEK'))
GROUP BY day_of_week, le.booking_id, bo.date, bo.time, type, genre, le.max_number_of_students
ORDER BY day_of_week, genre;

-- QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY QUERY

-- Show the number of lessons given during a specific year.
SELECT * FROM lessons_per_month WHERE year = '2022';

-- Show the number of students that have 0,1... siblings in the school.
SELECT * FROM student_siblings;

-- Show instructors that have given more than 1 lesson this month.
SELECT * FROM show_instructors WHERE lessons_given > 1;

-- Show the ensembles that are given in the next week.
SELECT * FROM ensembles_next_week;