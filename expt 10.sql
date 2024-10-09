CREATE OR REPLACE PROCEDURE calculate_avg_progressive_passes(OUT avg_progressive_passes NUMERIC) AS $$
BEGIN
    -- Calculate average progressive passes
    SELECT AVG(pgp)
    INTO avg_progressive_passes
    FROM teams;
END;
$$ LANGUAGE plpgsql;

CALL calculate_avg_progressive_passes(avg_progressive_passes := 0);

CREATE OR REPLACE PROCEDURE calculate_avg_possession(OUT avg_possession_percentage NUMERIC) AS $$
BEGIN
    -- Calculate average possession percentage
    SELECT AVG(possession_in_percentage)
    INTO avg_possession_percentage
    FROM teams;
END;
$$ LANGUAGE plpgsql;

CALL calculate_avg_possession(avg_possession_percentage := 0);

CREATE OR REPLACE PROCEDURE calculate_avg_pgc(OUT avge_pgc NUMERIC) AS $$
BEGIN
	SELECT AVG(pgc)
	INTO avge_pgc
	FROM teams;
END;
$$ LANGUAGE plpgsql;

CALL calculate_avg_pgc(avge_pgc := 0);


SELECT * FROM teams;