--Challenge 1:

-- SELECT
--     COUNT(*) AS total_players,

--     SUM(
--         CASE
--             WHEN points_per_game IS NOT NULL AND minutes_per_game IS NOT NULL THEN 1
--             ELSE 0
--         END
--     ) AS complete_records,

--     SUM(
--         CASE
--             WHEN points_per_game IS NULL THEN 1
--             ELSE 0
--         END 
--     ) AS missing_ppg,

--     SUM(
--         CASE
--             WHEN minutes_per_game IS NULL THEN 1
--             ELSE 0
--         END 
--     ) AS missing_mpg,

--     AVG(NULLIF(points_per_game, 0)) AS average_ppg
-- FROM players

--Challenge 2:

-- WITH team_average AS (
--     SELECT
--         team_id,
--         AVG(points_per_game) AS team_average
--     FROM players
--     GROUP BY team_id
-- )

-- SELECT
--     t.team_name,
--     COUNT(*) AS total_players,
--     COUNT(points_per_game) AS players_with_ppg,
--     avg(points_per_game) AS average_ppg,
--     RANK() OVER(
--         ORDER BY ta.team_average DESC
--     ) AS team_rank
-- FROM players AS p
-- INNER JOIN teams AS t
--     ON p.team_id = t.team_id
-- INNER JOIN team_average AS ta
--     ON p.team_id = ta.team_id
-- GROUP BY team_name
-- ORDER BY team_rank ASC;

--Challenge 3:

-- WITH team_stats AS (
--     SELECT
--         p.player_name AS player_name,
--         t.team_name AS team_name,
--         p.points_per_game AS points_per_game,
--         p.minutes_per_game AS minutes_per_game,
--         points_per_game / NULLIF(minutes_per_game, 0) AS points_per_minute
--     FROM players AS p
--     INNER JOIN teams AS t
--         ON p.team_id = t.team_id
-- )

-- SELECT
--     player_name,
--     team_name,
--     points_per_game,
--     minutes_per_game,
--     points_per_minute,
--     RANK() OVER(
--         ORDER BY points_per_minute DESC
--     ) AS efficiency_rank
-- FROM team_stats
-- WHERE minutes_per_game >= 25 AND points_per_game IS NOT NULL AND minutes_per_game IS NOT NULL
-- ORDER BY efficiency_rank ASC
-- LIMIT 10;

--Challenge 4:

-- WITH individual_stats AS (
--     SELECT
--         p.team_id,
--         t.team_name,
--         p.player_name,
--         p.points_per_game,
--         ROW_NUMBER() OVER(
--             PARTITION BY p.team_id
--             ORDER BY p.points_per_game DESC
--         ) AS scoring_rank
--     FROM players AS p
--     JOIN teams AS t
--         ON p.team_id = t.team_id
-- ),

-- team_stats AS (
--     SELECT
--         team_id,

--         AVG(points_per_game) OVER(
--             PARTITION BY team_id
--         ) AS team_average_ppg,

--         SUM(points_per_game) OVER(
--             PARTITION BY team_id
--         ) AS team_total_ppg
--     FROM players
-- )

-- SELECT
--     ind.team_name,
--     ind.player_name,
--     ind.points_per_game AS points_per_game,
--     ind.scoring_rank,
--     ts.team_average_ppg,
--     ts.team_total_ppg,
--     ind.points_per_game / NULLIF(ts.team_total_ppg, 0) AS scoring_share
-- FROM individual_stats AS ind
-- INNER JOIN team_stats AS ts 
--     ON ind.team_id = ts.team_id
-- WHERE points_per_game IS NOT NULL
-- GROUP BY ind.player_name
-- HAVING ind.scoring_rank <= 2
-- ORDER BY team_name ASC, scoring_rank ASC;

--Challenge 5:

WITH ranked_players AS (
    SELECT
        t.team_name,
        p.team_id,
        p.player_name,
        p.points_per_game,

        ROW_NUMBER() OVER(
            PARTITION BY p.team_id
            ORDER BY p.points_per_game DESC
        ) AS scoring_rank

    FROM players AS p

    INNER JOIN teams AS t
        ON t.team_id = p.team_id
    WHERE p.points_per_game IS NOT NULL
),

team_summary AS (
    SELECT
        team_name,
        team_id,

        MAX(
            CASE
                WHEN scoring_rank = 1 THEN player_name
            END
        ) AS top_scorer,

        MAX(
            CASE
                WHEN scoring_rank = 2 THEN player_name
            END
        ) AS second_scorer,

        SUM(points_per_game) AS team_total_ppg,

        SUM(
            CASE
                WHEN scoring_rank <= 2 THEN points_per_game
                ELSE NULL
            END 
        ) AS top_two_ppg,

        SUM(
            CASE
                WHEN scoring_rank <= 2 THEN points_per_game
                ELSE NULL
            END 
        ) / NULLIF(SUM(points_per_game), 0) AS top_two_share

    FROM ranked_players

    GROUP BY team_id
)

SELECT
    team_name,
    top_scorer,
    second_scorer,
    team_total_ppg,
    top_two_ppg,
    top_two_share,
    RANK() OVER(
            ORDER BY top_two_share DESC
        ) AS dependency_rank
FROM team_summary
ORDER BY dependency_rank ASC;

