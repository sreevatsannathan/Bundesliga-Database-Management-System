CREATE TABLE players(player_id VARCHAR(10) PRIMARY KEY, team_id VARCHAR(5),player_name VARCHAR(50),position VARCHAR(20), dob DATE, jersey_no INT,assists INT, goals INT, FOREIGN KEY(team_id) REFERENCES teams(team_id));

CREATE TABLE managers(manager_id VARCHAR(10) PRIMARY KEY, team_id VARCHAR(10),manager_name VARCHAR(50), manager_since DATE, dob DATE, FOREIGN KEY(team_id) REFERENCES teams(team_id));

CREATE TABLE referees(referee_id VARCHAR(10) PRIMARY KEY, match_id INT, referee_name VARCHAR(50), dob DATE, FOREIGN KEY(match_id) REFERENCES matches(match_id));

SELECT * FROM teams;

SELECT * FROM matches
ORDER BY match_id ASC;

ALTER TABLE matches
ADD CONSTRAINT home_team_id 
