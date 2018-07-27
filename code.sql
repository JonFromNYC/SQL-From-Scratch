SELECT COUNT(DISTINCT utm_source) AS 'Sources', COUNT(DISTINCT utm_campaign) AS 'Campaigns'
FROM page_visits;
SELECT DISTINCT utm_source,utm_campaign
FROM page_visits;




SELECT DISTINCT page_name
FROM page_visits;




WITH first_touch AS (
    SELECT user_id,
           MIN(timestamp) as 'first_touch_at'
    FROM page_visits
    GROUP BY user_id),
first_touch_attr AS (
    SELECT first_touch.user_id,
           first_touch.first_touch_at,
           page_visits.utm_source,
           page_visits.utm_campaign
    FROM first_touch
    JOIN page_visits
         ON first_touch.user_id = page_visits.user_id
         AND first_touch.first_touch_at =  	page_visits.timestamp
)
SELECT first_touch_attr.utm_source AS 'Source',
       first_touch_attr.utm_campaign AS 'Campaign',
       COUNT(*) AS 'Number of first touches'
FROM first_touch_attr
GROUP BY 1,2
ORDER BY 3 DESC;




WITH last_touch AS (
    SELECT user_id,
           MAX(timestamp) as 'last_touch_at'
    FROM page_visits
    GROUP BY user_id),
last_touch_attr AS (
    SELECT last_touch.user_id,
           last_touch.last_touch_at,
           page_visits.utm_source,
           page_visits.utm_campaign,
           page_visits.page_name
    FROM last_touch
    JOIN page_visits
         ON last_touch.user_id = page_visits.user_id
         AND last_touch.last_touch_at =
             page_visits.timestamp
)
SELECT last_touch_attr.utm_source AS 'Source',
       last_touch_attr.utm_campaign AS 'Campaign',
       COUNT(*) 'Number of last touches'
FROM last_touch_attr
GROUP BY 1, 2
ORDER BY 3 DESC;


SELECT page_name, COUNT (DISTINCT user_id) AS 'Visits'
FROM page_visits
GROUP BY page_name;



WITH last_touch AS (
    SELECT user_id,
           MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id),
last_touch_attr AS (
    SELECT last_touch.user_id,
           last_touch.last_touch_at,
           page_visits.utm_source,
           page_visits.utm_campaign,
           page_visits.page_name
    FROM last_touch
    JOIN page_visits
         ON last_touch.user_id = page_visits.user_id
         AND last_touch.last_touch_at =
             page_visits.timestamp
)
SELECT last_touch_attr.utm_source AS 'Source',
       last_touch_attr.utm_campaign AS 'Campaign',
       COUNT(*) 'Number of last touches'
FROM last_touch_attr
GROUP BY 1, 2
ORDER BY 3 DESC;