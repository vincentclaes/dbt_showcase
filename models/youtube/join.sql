SELECT a.date as date, a.channel_id as channel_id, a.video_id as video_id, annotation_click_through_rate, card_click_rate FROM {{ ref('content_owner_basic_a3') }} as a 
JOIN {{ ref('content_owner_estimated_revenue_a1') }} as b
ON a.date=b.date AND a.channel_id=b.channel_id AND a.video_id=b.video_id
