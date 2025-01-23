-- Leetcode: Game Play Analysis 1 (EASY)

SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

-- Leetcode: Game Play Analysis 2 (EASY)

WITH rank_cte AS
(
SELECT player_id, device_id,
DENSE_RANK() OVER (PARTITION BY player_id ORDER BY event_date ASC) AS rank_device
FROM Activity
)
SELECT player_id, device_id
FROM rank_cte
WHERE rank_device = 1;

-- Leetcode: Game Play Analysis 3 (MEDIUM)

SELECT player_id, event_date,
SUM(games_played) OVER (partition by player_id ORDER BY event_date) AS games_played_so_far
FROM Activity;

-- Leetcode: Game Play Analysis 4 (MEDIUM)

SELECT ROUND(COUNT(DISTINCT player_id)/
                (SELECT COUNT(DISTINCT player_id)
                 FROM activity),2) AS fraction
FROM Activity
WHERE (player_id,DATE_SUB(event_date, INTERVAL 1 DAY)) IN 
                    (SELECT player_id, MIN(event_date) AS first_login
                     FROM activity GROUP BY player_id);

