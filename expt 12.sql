DO $$
DECLARE
    team_cursor CURSOR FOR
        SELECT * FROM teams;
    team_record teams%ROWTYPE;
BEGIN
    -- Open the cursor
    OPEN team_cursor;

    -- Fetch and process each row
    LOOP
        FETCH team_cursor INTO team_record;
        EXIT WHEN NOT FOUND;
        
        -- Process the current row
        -- For example, print team name
        RAISE NOTICE 'Team Name: %', team_record.team_name;
        
    END LOOP;

    -- Close the cursor
    CLOSE team_cursor;
END $$;

DO $$
DECLARE
    team_cursor CURSOR FOR
        SELECT team_name, goals FROM teams;
    team_record RECORD;
    total_goals INT;
BEGIN
    -- Open the cursor
    OPEN team_cursor;

    -- Fetch and process each row
    LOOP
        FETCH team_cursor INTO team_record;
        EXIT WHEN NOT FOUND;

        -- Calculate total goals scored by the current team
        total_goals := team_record.goals; -- Assign the goals directly from the cursor record

        -- Print the total goals scored by the current team
        RAISE NOTICE 'Team: %, Total Goals: %', team_record.team_name, total_goals;

    END LOOP;

    -- Close the cursor
    CLOSE team_cursor;
END $$;


DO $$
DECLARE
    avg_possession_percentage NUMERIC;
    total_possession NUMERIC := 0;
    num_teams INT := 0;
    team_record NUMERIC; -- Assuming possession_in_percentage is of type NUMERIC
BEGIN
    -- Declare a cursor to select the possession_in_percentage column from the teams table
    FOR team_record IN SELECT possession_in_percentage FROM teams LOOP
        -- Add the possession_in_percentage value to the total
        total_possession := total_possession + team_record;
        -- Increment the number of teams
        num_teams := num_teams + 1;
    END LOOP;

    -- Calculate the average possession percentage
    IF num_teams > 0 THEN
        avg_possession_percentage := total_possession / num_teams;
    ELSE
        -- Handle the case where there are no teams (to avoid division by zero)
        avg_possession_percentage := NULL;
    END IF;

    -- Print the average possession percentage
    RAISE NOTICE 'Average Possession Percentage: %', avg_possession_percentage;
END $$;


SELECT * FROM teams;
SELECT * FROM matches;