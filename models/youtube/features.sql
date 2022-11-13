SELECT * , DATEDIFF(days, '2009-01-08', date) AS day_of_year FROM {{ ref('filter_columns') }}
