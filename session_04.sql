-- SELECT 
--     team_id,
--     COUNT(*) AS player_count
-- FROM players
-- GROUP BY team_id;

-- INSERT INTO teams (team_id, team_name)
-- VALUES (30, 'Los Angeles Lakers');

-- SELECT
--     team_id,
--     COUNT(*) AS player_count
-- FROM players
-- GROUP BY team_id
-- ORDER BY team_id;

-- SELECT 
--     team_id,
--     COUNT(*) AS player_count,
--     AVG(points_per_game) AS average_ppg,
--     MAX(points_per_game) AS highest_ppg
-- FROM players
-- GROUP BY team_id
-- ORDER BY average_ppg DESC;

-- SELECT
--     team_id,
--     COUNT(*) AS player_count,
--     AVG(points_per_game) AS average_ppg
-- FROM players
-- GROUP BY team_id
-- HAVING player_count >= 3
-- ORDER BY average_ppg DESC;

-- SELECT 
--     team_id,
--     COUNT(*) AS player_count,
--     AVG(points_per_game) AS average_ppg
-- FROM players
-- WHERE minutes_per_game >= 30
-- GROUP BY team_id
-- HAVING COUNT(*) >= 2
-- ORDER BY average_ppg DESC;

SELECT
    team_id,
    COUNT(*) AS qualifying_players,
    AVG(points_per_game) AS average_ppg,
    MAX(minutes_per_game) AS highest_mpg
FROM players
WHERE points_per_game >= 20
GROUP BY team_id
HAVING COUNT(*) >= 2
ORDER BY average_ppg DESC;