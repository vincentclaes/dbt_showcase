SELECT MAX(date) as date, 
       channel_id, 
       video_id as media_id,
       'week' as time_dimension, 
       'annotation_click_through_rate' as metric_name, 
       AVG(annotation_click_through_rate) as metric_value 
       FROM {{ ref('features') }} 
       WHERE day_of_year > 8 - 7 
       GROUP BY channel_id,video_id
