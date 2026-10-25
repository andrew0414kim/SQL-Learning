
-- ALTER TABLE players
-- ADD COLUMN points_per_game REAL;

-- ALTER TABLE players
-- ADD COLUMN minutes_per_game REAL;

-- UPDATE players
-- SET points_per_game = 27.1,
--     minutes_per_game = 36.4
-- WHERE player_id = 3;

-- SELECT player_name, minutes_per_game
-- FROM players
-- WHERE minutes_per_game >= 30;

-- SELECT player_name, points_per_game, minutes_per_game
-- FROM players
-- WHERE points_per_game < 20
-- OR minutes_per_game < 30;

-- SELECT player_name, minutes_per_game
-- FROM players
-- WHERE minutes_per_game > 25
-- ORDER BY minutes_per_game ASC;

-- SELECT player_name, points_per_game, minutes_per_game
-- FROM players
-- WHERE points_per_game > 20
-- AND minutes_per_game > 30
-- ORDER BY points_per_game DESC
-- LIMIT 2;

SELECT player_name, points_per_game, minutes_per_game
FROM players
WHERE points_per_game >= 18
AND minutes_per_game < 35
ORDER BY points_per_game DESC
LIMIT 1;