-- For simplicity we cast here at filter_columns. 
SELECT CAST(date as DATE) AS date, channel_id, video_id, annotation_click_through_rate, card_click_rate from {{ ref('join') }}
