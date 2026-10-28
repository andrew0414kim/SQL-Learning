-- SELECT player_name, points_per_game
-- FROM players
-- WHERE points_per_game > (
--     SELECT AVG(points_per_game)
--     FROM players
-- )
-- ORDER BY points_per_game DESC;

-- SELECT player_name, team_id, points_per_game
-- FROM players
-- WHERE team_id IN (
--     SELECT team_id
--     FROM players
--     GROUP BY team_id
--     HAVING AVG(points_per_game) > 20
-- )
-- ORDER BY points_per_game DESC;


-- SELECT
--     p.player_name,
--     p.team_id,
--     p.points_per_game
-- FROM players AS p
-- WHERE p.points_per_game < (
--     SELECT AVG(p2.points_per_game)
--     FROM players AS p2
--     WHERE p2.team_id = p.team_id
-- )
-- ORDER BY p.points_per_game ASC;

-- SELECT
--     p.player_name, (
--         SELECT team_name
--         FROM teams AS t
--         WHERE p.team_id = t.team_id
--     ) AS team_name,
--     minutes_per_game
-- FROM players AS p
-- ORDER BY minutes_per_game DESC;

SELECT
    p.player_name,
    t.team_name,
    p.points_per_game
FROM players AS p
INNER JOIN teams AS t
ON p.team_id = t.team_id
WHERE p.points_per_game > (
    SELECT AVG(p2.points_per_game)
    FROM players AS p2
    WHERE p2.team_id = p.team_id
)
ORDER BY p.points_per_game DESC;