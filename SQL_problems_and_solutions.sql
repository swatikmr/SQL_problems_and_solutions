-- Leetcode 511: Game Play Analysis 1

SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

-- Leetcode 512: Game Play Analysis 2

WITH rank_cte AS
(
SELECT player_id, device_id,
DENSE_RANK() OVER (PARTITION BY player_id ORDER BY event_date ASC) AS rank_device
FROM Activity
)
SELECT player_id, device_id
FROM rank_cte
WHERE rank_device = 1;

-- Leetcode 534: Game Play Analysis 3

SELECT player_id, event_date,
SUM(games_played) OVER (partition by player_id ORDER BY event_date) AS games_played_so_far
FROM Activity;

-- Leetcode 550: Game Play Analysis 4

SELECT ROUND(COUNT(DISTINCT player_id)/
                (SELECT COUNT(DISTINCT player_id)
                 FROM activity),2) AS fraction
FROM Activity
WHERE (player_id,DATE_SUB(event_date, INTERVAL 1 DAY)) IN 
                    (SELECT player_id, MIN(event_date) AS first_login
                     FROM activity GROUP BY player_id);

-- Leetcode 1045: Customers who bought all products
-- Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

SELECT c.customer_id
FROM Customer c
GROUP BY c.customer_id
HAVING COUNT(DISTINCT c.Product_key) = (SELECT COUNT(product_key) FROM Product)
ORDER BY c.customer_id;

-- Leetcode 570: Manager with atleast 5 direct reports

SELECT e.name
FROM employee e
JOIN employee m ON e.id=m.managerId
GROUP BY m.managerId
HAVING COUNT(m.managerId)>=5;

-- Leetcode 607: Sales Person
-- Write a solution to find the names of all the salespersons who did not have any orders related to the company with the name "RED".

SELECT s.name
FROM SalesPerson s
WHERE s.name NOT IN
    (SELECT s.name
    FROM SalesPerson s
    JOIN Orders o ON s.sales_id=o.sales_id
    LEFT JOIN Company c ON o.com_id=c.com_id
    WHERE c.name="RED");





