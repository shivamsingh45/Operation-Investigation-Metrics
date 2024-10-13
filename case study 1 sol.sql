use operation_analytics;

-- job reviewed over time
WITH per_day_avg AS (
    SELECT 
        ds, 
        ROUND(3600 / AVG(time_spent),1) AS avg_per_hour
    FROM job_data
    GROUP BY ds
)
SELECT 
    ds,
	avg_per_hour,
    ROUND((SELECT AVG(avg_per_hour) FROM per_day_avg),0) AS overall_avg_per_hour
FROM per_day_avg;


select ds, 3600/avg(time_spent) as avg_per_hour 
from job_data
group by ds;


-- Throughput analysis 
SELECT 
    ds, 
    ROUND(COUNT(event) / SUM(time_spent), 3) AS daily_throughput, 
    (
        SELECT ROUND(COUNT(event) / SUM(time_spent), 2) 
        FROM job_data
    ) AS weekly_throughput
FROM job_data
GROUP BY ds;


-- language share analysis 
SELECT 
    language, 
    COUNT(language) AS count,
    (COUNT(language) / (SELECT COUNT(*) FROM job_data)) * 100 AS percentage_share
FROM job_data
GROUP BY language;



-- Duplicate Rows Detection
SELECT 
    ds, job_id, actor_id, event, language, time_spent, org, COUNT(*)
FROM 
    job_data
GROUP BY 
    ds, job_id, actor_id, event, language, time_spent, org
HAVING 
    COUNT(*) > 1;

SELECT * 
FROM 
    job_data;
    
-- case study 2
-- 