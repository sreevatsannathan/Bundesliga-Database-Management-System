SELECT * FROM matches;

SELECT * FROM teams;

SELECT home_team FROM matches
union 
SELECT team_name FROM teams; 

SELECT home_team FROM matches
intersect
SELECT team_name FROM teams; 

SELECT home_team FROM matches
EXCEPT
SELECT team_name FROM teams;

SELECT home_team FROM matches
EXCEPT
SELECT team_name FROM teams
WHERE team_name like 'D%'OR team_name LIKE '%g';

SELECT home_team FROM matches
INTERSECT
SELECT team_name FROM teams
WHERE team_name like 'D%'OR team_name LIKE '%g';

SELECT home_team FROM matches
INTERSECT
SELECT team_name FROM teams
WHERE total_passes_completed>(SELECT AVG(total_passes_completed) FROM teams);

UPDATE teams
SET team_name='Mainz'
WHERE team_name='Mainz 05';