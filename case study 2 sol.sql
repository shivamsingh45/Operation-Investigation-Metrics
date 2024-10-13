use operation_analytics;

-- weekly user engagement 
SELECT 
    WEEK(occurred_at) AS weeks,
    COUNT(DISTINCT user_id) AS engage_users
FROM events
WHERE event_type = 'engagement'
GROUP BY weeks;

select * from events;

WITH weekly_engagement AS (
    SELECT 
        WEEK(occurred_at) AS week,
        COUNT(DISTINCT user_id) AS user_count
    FROM 
        events
    WHERE 
        event_type = 'engagement'
    GROUP BY 
        WEEK(occurred_at)
)
SELECT 
    max(user_count) AS avg_weekly_engagement
FROM 
    weekly_engagement;
    
-- User growth analysis
WITH weekly_users  AS (
    SELECT 
        year(created_at) as Years,
        week(created_at) as Weeks,
        
)
