-- SELECT COUNT(*)
-- FROM players;

-- SELECT COUNT(*) AS warriors_players
-- FROM players
-- WHERE team_id = 10;

-- SELECT SUM(minutes_per_game) AS combined_mpg
-- FROM players
-- WHERE team_id = 10;

-- SELECT AVG(points_per_game) AS average_ppg
-- FROM players
-- WHERE minutes_per_game > 30;

-- SELECT
--     AVG(points_per_game) AS average_ppg,
--     MAX(points_per_game) AS highest_ppg,
--     MIN(minutes_per_game) AS lowest_mpg
-- FROM players
-- WHERE team_id = 10;

SELECT
    COUNT(*) AS qualifying_players,
    AVG(points_per_game) AS average_ppg,
    MAX(minutes_per_game) AS highest_mpg
FROM players
WHERE points_per_game >= 20 AND minutes_per_game < 35;
