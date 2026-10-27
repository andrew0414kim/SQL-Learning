-- SELECT
--     players.player_name,
--     teams.team_name
-- FROM players
-- INNER JOIN teams
--     ON players.team_id = teams.team_id;

-- SELECT
--     players.player_name,
--     teams.team_name,
--     players.points_per_game
-- FROM players
-- INNER JOIN teams
--     ON players.team_id = teams.team_id
-- ORDER BY points_per_game DESC;

-- SELECT
--     p.player_name,
--     t.team_name,
--     p.minutes_per_game
-- FROM players AS p
-- INNER JOIN teams AS t
--     ON p.team_id = t.team_id
-- WHERE p.minutes_per_game >= 30
-- ORDER BY p.minutes_per_game DESC;

-- SELECT
--     p.player_name,
--     t.team_name,
--     p.points_per_game
-- FROM players AS p
-- LEFT JOIN teams AS t
--     ON p.team_id = t.team_id
-- ORDER BY p.points_per_game DESC;

-- SELECT
--     t.team_name,
--     COUNT(*) AS player_count
-- FROM players AS p
-- INNER JOIN teams AS t
--     ON p.team_id = t.team_id
-- GROUP BY t.team_name;

-- SELECT
--     t.team_name,
--     COUNT(*) AS player_count,
--     AVG(p.points_per_game) AS average_ppg,
--     MAX(p.points_per_game) AS highest_ppg
-- FROM players AS p
-- INNER JOIN teams AS t
--     ON p.team_id = t.team_id
-- GROUP BY t.team_name
-- ORDER BY average_ppg DESC;

SELECT
    t.team_name,
    COUNT(*) AS qualifying_players,
    AVG(p.points_per_game) AS average_ppg,
    MAX(p.points_per_game) AS highest_ppg
FROM players AS p
INNER JOIN teams AS t
    ON p.team_id = t.team_id
WHERE p.points_per_game >= 15
GROUP BY t.team_name
HAVING qualifying_players >= 2
ORDER BY average_ppg DESC;