-- SELECT
--     player_name,
--     minutes_per_game,
--     CASE
--         WHEN minutes_per_game >= 35 THEN 'Heavy Minutes'
--         WHEN minutes_per_game >= 30 THEN 'Regular Rotation'
--         ELSE 'Limited Minutes'
--     END AS playing_time_category
-- FROM players
-- ORDER BY minutes_per_game DESC;

-- SELECT
--     player_name,
--     points_per_game,
--     NULL AS reported_ppg,
--     COALESCE(NULL, points_per_game) AS adjusted_ppg
-- FROM players
-- ORDER BY points_per_game DESC;

-- SELECT
--     player_name,
--     points_per_game,
--     minutes_per_game,
--     points_per_game / NULLIF(minutes_per_game, 0) AS points_per_minute
-- FROM players
-- ORDER BY points_per_minute DESC;

-- INSERT INTO teams (team_id, team_name)
-- VALUES
--     (40, 'New York Knicks'),
--     (50, 'Oklahoma City Thunder'),
--     (60, 'Cleveland Cavaliers'),
--     (70, 'Denver Nuggets'),
--     (80, 'Minnesota Timberwolves'),
--     (90, 'Houston Rockets'),
--     (100, 'San Antonio Spurs');

-- INSERT INTO players (
--     player_id,
--     player_name,
--     team_id,
--     points_per_game,
--     minutes_per_game
-- )
-- VALUES
--     -- Golden State Warriors
--     (11, 'Moses Moody', 10, 11.4, 25.2),
--     (12, 'Gary Payton II', 10, 6.8, 17.4),

--     -- Boston Celtics
--     (13, 'Jaylen Brown', 20, 25.2, 35.1),
--     (14, 'Payton Pritchard', 20, 16.1, 30.5),

--     -- Los Angeles Lakers
--     (15, 'LeBron James', 30, 24.4, 34.8),

--     -- New York Knicks
--     (16, 'Jalen Brunson', 40, 27.6, 35.4),
--     (17, 'Karl-Anthony Towns', 40, 24.1, 33.7),
--     (18, 'OG Anunoby', 40, 17.2, 34.5),
--     (19, 'Mikal Bridges', 40, 16.8, 35.0),
--     (20, 'Josh Hart', 40, 13.6, 36.2),

--     -- Oklahoma City Thunder
--     (21, 'Shai Gilgeous-Alexander', 50, 32.7, 34.6),
--     (22, 'Jalen Williams', 50, 21.6, 32.8),
--     (23, 'Chet Holmgren', 50, 18.4, 29.8),
--     (24, 'Isaiah Hartenstein', 50, 11.2, 27.4),
--     (25, 'Alex Caruso', 50, NULL, 21.5),

--     -- Cleveland Cavaliers
--     (26, 'Donovan Mitchell', 60, 26.8, 33.9),
--     (27, 'Darius Garland', 60, 20.5, 31.8),
--     (28, 'Evan Mobley', 60, 18.7, 32.4),
--     (29, 'Jarrett Allen', 60, 13.5, 29.6),
--     (30, 'Max Strus', 60, 9.8, NULL),

--     -- Denver Nuggets
--     (31, 'Nikola Jokic', 70, 29.6, 36.1),
--     (32, 'Jamal Murray', 70, 22.1, 34.2),
--     (33, 'Aaron Gordon', 70, 14.8, 29.5),
--     (34, 'Christian Braun', 70, 15.4, 32.6),
--     (35, 'Peyton Watson', 70, NULL, NULL),

--     -- Minnesota Timberwolves
--     (36, 'Anthony Edwards', 80, 28.2, 36.0),
--     (37, 'Julius Randle', 80, 18.9, 32.7),
--     (38, 'Rudy Gobert', 80, 11.4, 30.8),
--     (39, 'Jaden McDaniels', 80, 12.6, 31.5),
--     (40, 'Naz Reid', 80, 14.2, 27.9),

--     -- Houston Rockets
--     (41, 'Alperen Sengun', 90, 20.8, 32.5),
--     (42, 'Amen Thompson', 90, 14.9, 31.7),
--     (43, 'Jabari Smith Jr.', 90, 13.2, 29.4),
--     (44, 'Fred VanVleet', 90, NULL, 30.1),
--     (45, 'Tari Eason', 90, 11.3, NULL),

--     -- San Antonio Spurs
--     (46, 'Victor Wembanyama', 100, 25.8, 32.4),
--     (47, 'Devin Vassell', 100, 16.7, 30.2),
--     (48, 'Stephon Castle', 100, 14.6, 28.5),
--     (49, 'Keldon Johnson', 100, 12.1, 24.8),
--     (50, 'Jeremy Sochan', 100, NULL, 22.6);

-- SELECT
--     COUNT(*) AS total_players,
--     COUNT(DISTINCT team_id) AS total_teams,
--     COUNT(points_per_game) AS players_with_ppg,
--     COUNT(minutes_per_game) AS players_with_mpg
-- FROM players;

-- SELECT
--     t.team_name,
--     COUNT(p.player_id) AS player_count
-- FROM teams AS t
-- LEFT JOIN players AS p
--     ON t.team_id = p.team_id
-- GROUP BY t.team_id, t.team_name
-- ORDER BY player_count DESC, t.team_name ASC;

-- SELECT
--     player_name,
--     points_per_game,
--     CAST(points_per_game AS INTEGER) AS whole_number_ppg,
--     CAST(points_per_game AS TEXT) AS text_ppg
-- FROM players
-- ORDER BY points_per_game DESC;

-- SELECT
--     player_name,
--     team_id,
--     points_per_game
-- FROM players
-- WHERE player_name LIKE '%an%'
-- ORDER BY player_name ASC;

-- SELECT
--     player_name,
--     team_id,
--     points_per_game,
--     minutes_per_game
-- FROM players
-- WHERE points_per_game BETWEEN 15 AND 25 AND minutes_per_game >= 30
-- ORDER BY points_per_game DESC;

WITH player_report AS(
    SELECT
        player_name,
        team_id,
        points_per_game,
        minutes_per_game,
        CASE
            WHEN points_per_game IS NULL AND minutes_per_game IS NULL THEN 'Missing Both'
            WHEN points_per_game IS NULL THEN 'Missing PPG'
            WHEN minutes_per_game IS NULL THEN 'Missing MPG'
            ELSE 'Complete'
        END AS data_status,
        CASE
            WHEN points_per_game IS NULL THEN 'Unknown'
            WHEN points_per_game >= 25 THEN 'Elite Scorer'
            WHEN points_per_game >= 15 THEN 'Solid Scorer'
            ELSE 'Role Player'
        END AS scoring_category,
        points_per_game / NULLIF(minutes_per_game, 0) AS points_per_minute
    FROM players
)

SELECT
    player_name,
    team_id,
    points_per_game,
    minutes_per_game,
    data_status,
    scoring_category,
    points_per_minute
FROM player_report
ORDER BY team_id ASC, points_per_game DESC;