SELECT date, channel_id, video_id as media_id, dimension, metric_name, metric_value FROM {{ ref('features') }} WHERE