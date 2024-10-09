DO $$
DECLARE
    avg_xg NUMERIC;
BEGIN
    -- Calculate average xG
    SELECT AVG(xg)
    INTO avg_xg
    FROM teams;

    -- Output the result
    RAISE NOTICE 'Average xG for all teams: %', avg_xg;
END $$;

DO $$
DECLARE
    avg_xg_per_90 NUMERIC;
BEGIN
    -- Calculate average xG
    SELECT AVG(xg_per_90)
    INTO avg_xg_per_90
    FROM teams;

    -- Output the result
    RAISE NOTICE 'Average xGper90 for all teams: %', avg_xg_per_90;
END $$;

DO $$
DECLARE
    avg_t_pg INT;
BEGIN
    -- Calculate average total progressive distance
    SELECT AVG(total_pg_distance)
    INTO avg_t_pg
    FROM teams;

    -- Output the result
    RAISE NOTICE 'Average progressive distance for all teams: %', avg_t_pg;
END $$;

CREATE OR REPLACE FUNCTION get_team_information(input_team_id VARCHAR) RETURNS VARCHAR AS $$
DECLARE
    team_info RECORD;
BEGIN
    -- Retrieve team information
    SELECT *
    INTO team_info
    FROM teams
    WHERE team_id = input_team_id;

    -- Display team information
    RAISE NOTICE 'Team Information:';
    RAISE NOTICE 'Team ID: %', team_info.team_id;
    RAISE NOTICE 'Team Name: %', team_info.team_name;
	RAISE NOTICE 'Total Passes Completed: %', team_info.total_passes_completed;
	RAISE NOTICE 'Key Passes: %', team_info.key_passes;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION get_team_information(input_team_id VARCHAR);

SELECT * FROM get_team_information('T105');

CREATE OR REPLACE FUNCTION check_key_passes(input_team_id VARCHAR) RETURNS BOOLEAN AS $$
DECLARE
    team_info RECORD;
    yes_or_no BOOLEAN := FALSE;  -- Initialize the variable
BEGIN
    -- Retrieve team information
    SELECT team_id, team_name, total_passes_completed, key_passes
    INTO team_info
    FROM teams
    WHERE team_id = input_team_id;

    FOR team_info IN SELECT * FROM teams LOOP
        IF team_info.key_passes > (SELECT AVG(key_passes) FROM teams) THEN
            yes_or_no := TRUE;
        END IF;  -- Add missing semicolon
    END LOOP;

    -- Return the result
    RETURN yes_or_no;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM check_key_passes('T105');

DROP FUNCTION check_avg_passes_completed(input_team_id VARCHAR);

CREATE OR REPLACE FUNCTION check_prog_passes(input_team_id VARCHAR) RETURNS BOOLEAN AS $$
DECLARE
    team_info RECORD;
    yes_or_no BOOLEAN := FALSE;  -- Initialize the variable
BEGIN
    -- Retrieve team information
    SELECT team_id, team_name, total_passes_completed, key_passes
    INTO team_info
    FROM teams
    WHERE team_id = input_team_id;

    FOR team_info IN SELECT * FROM teams LOOP
        IF team_info.pgp > (SELECT AVG(pgp) FROM teams) THEN
            yes_or_no := TRUE;
        END IF;  -- Add missing semicolon
    END LOOP;

    -- Return the result
    RETURN yes_or_no;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM check_prog_passes('T106');

CREATE OR REPLACE FUNCTION select_avg_age(input_team_id VARCHAR) RETURNS DECIMAL AS $$
DECLARE
    team_info RECORD;
    age DECIMAL;  -- Initialize the variable
BEGIN
    -- Retrieve team information
	SELECT avg_age
	INTO age
	FROM teams;
	
	-- Return the result
    RETURN age;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM select_avg_age('T106');



SELECT * FROM teams;