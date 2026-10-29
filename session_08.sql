-- SELECT
--     player_name,
--     points_per_game,
--     AVG(points_per_game) OVER() AS league_average,
--     points_per_game - AVG(points_per_game) OVER() AS difference_from_average
-- FROM players
-- ORDER BY difference_from_average DESC;

-- SELECT
--     player_name,
--     team_id,
--     points_per_game,
--     AVG(points_per_game) OVER(
--         PARTITION BY team_id
--     ) AS team_average,
--     points_per_game - AVG(points_per_game) OVER(
--         PARTITION BY team_id
--     ) AS difference_from_team_average
-- FROM players
-- ORDER BY difference_from_team_average DESC;

-- SELECT
--     player_name,
--     team_id,
--     minutes_per_game,
--     ROW_NUMBER() OVER(
--         PARTITION BY team_id
--         ORDER BY minutes_per_game DESC
--     ) AS minutes_rank
-- FROM players
-- ORDER BY team_id ASC, minutes_rank ASC;

-- SELECT
--     player_name,
--     points_per_game,
--     ROW_NUMBER() OVER(
--         ORDER BY points_per_game DESC
--     ) AS row_number_rank,
--     RANK() OVER(
--         ORDER BY points_per_game DESC
--     ) AS standard_rank,
--     DENSE_RANK() OVER(
--         ORDER BY points_per_game DESC
--     ) AS dense_rank
-- FROM players
-- ORDER BY points_per_game DESC;

-- SELECT
--     player_name,
--     team_id,
--     points_per_game,
--     SUM(points_per_game) OVER(
--         PARTITION BY team_id
--         ORDER BY points_per_game DESC
--         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--     ) AS cumulative_ppg
-- FROM players
-- ORDER BY team_id ASC, points_per_game DESC;

WITH player_rankings AS (
    SELECT
        player_name,
        team_id,
        points_per_game,
        ROW_NUMBER() OVER(
            PARTITION BY team_id
            ORDER BY points_per_game DESC
        ) AS scoring_rank,
        AVG(points_per_game) OVER(
            PARTITION BY team_id
        ) AS team_average
    FROM players
)

SELECT
    player_name,
    team_id,
    points_per_game,
    scoring_rank,
    team_average,
    points_per_game - team_average AS difference_from_average
FROM player_rankings
WHERE scoring_rank <= 2
ORDER BY team_id ASC, scoring_rank ASC;
