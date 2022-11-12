
SELECT CAST(date as DATE), channel_id, video_id, annotation_click_through_rate, card_click_rate from {{ ref('join') }}
