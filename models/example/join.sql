SELECT * FROM  ({{ ref('content_owner_basic_a3') }}) as a JOIN ( {{ ref('content_owner_estimated_revenue_a1') }} ) as b JOIN ON a.date=b.date AND a.channel_id=b.channel_id AND a.video_id=b.video_id
