-- WITH team_max_ppg AS (
--     SELECT 
--         team_id,
--         MAX(points_per_game) AS highest_ppg
--     FROM players
--     GROUP BY team_id
-- )

-- WITH team_averages AS (
--     SELECT
--         team_id,
--         AVG(points_per_game) AS average_ppg
--     FROM players
--     GROUP BY team_id
-- )

-- SELECT
--     p.player_name,
--     p.points_per_game,
--     ta.average_ppg
-- FROM players AS p
-- INNER JOIN team_averages AS ta
--     ON p.team_id = ta.team_id;

-- WITH team_averages AS (
--     SELECT
--         team_id,
--         AVG(points_per_game) AS average_ppg
--     FROM players
--     GROUP BY team_id
-- )

-- SELECT
--     p.player_name,
--     p.points_per_game,
--     ta.average_ppg,
--     p.points_per_game - ta.average_ppg AS ppg_difference
-- FROM players AS p
-- INNER JOIN team_averages AS ta 
--     ON p.team_id = ta.team_id
-- WHERE p.points_per_game > ta.average_ppg
-- ORDER BY ppg_difference DESC;

-- WITH team_scoring AS (
--     SELECT 
--         team_id,
--         AVG(points_per_game) AS average_ppg
--     FROM players
--     GROUP BY team_id
-- ),

-- team_minutes AS (
--     SELECT 
--         team_id,
--         AVG(minutes_per_game) AS average_mpg
--     FROM players
--     GROUP BY team_id
-- )

-- SELECT
--     ts.team_id,
--     ts.average_ppg,
--     tm.average_mpg,
--     ts.average_ppg / tm.average_mpg AS scoring_rate
-- FROM team_scoring AS ts 
-- INNER JOIN team_minutes AS tm 
--     ON ts.team_id = tm.team_id
-- ORDER BY scoring_rate DESC;

-- WITH league_average AS (
--     SELECT
--         AVG(points_per_game) AS average_ppg
--     FROM players
-- )

-- SELECT
--     p.player_name,
--     p.points_per_game,
--     la.average_ppg
-- FROM players AS p
-- CROSS JOIN league_average AS la
-- WHERE p.points_per_game > la.average_ppg
-- ORDER BY points_per_game DESC;

-- SELECT
--     player_name,
--     COALESCE(team_id, 0) AS cleaned_team_id
-- FROM players
-- ORDER BY player_name ASC;

WITH team_averages AS (
    SELECT
        team_id,
        AVG(points_per_game) AS average_ppg
    FROM players
    GROUP BY team_id
),

qualifying_players AS (
    SELECT
        player_name,
        team_id,
        points_per_game
    FROM players
    WHERE points_per_game >= 15
)

SELECT
    t.team_name,
    COUNT(*) AS qualifying_count,
    AVG(qp.points_per_game) AS average_qualifying_ppg,
    ta.average_ppg AS team_average_ppg
FROM teams AS t
INNER JOIN qualifying_players AS qp
    ON t.team_id = qp.team_id
INNER JOIN team_averages AS ta 
    ON t.team_id = ta.team_id
GROUP BY t.team_id, t.team_name, ta.average_ppg
HAVING COUNT(*) >= 2
ORDER BY average_qualifying_ppg DESC;