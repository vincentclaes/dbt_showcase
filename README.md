# DBT Showcase

```bash
make setup
poetry shell
```

## DuckDB

```bash
# install duckdb
make setup-duckdb
# populate seeds to db
dbt seed --profile duckdb
# run dbt models
dbt run --profile duckdb --select youtube

# view tables
duckdb
.open duckdb/db

SHOW tables;

┌────────────────────────────────────┐
│                name                │
├────────────────────────────────────┤
│ content_owner_basic_a3             │
│ content_owner_estimated_revenue_a1 │
│ features                           │
│ filter_columns                     │
│ join                               │
│ transform                          │
└────────────────────────────────────┘

SELECT * from datahub.transform;

┌────────────┬──────────────┬────────────┬────────────────┬───────────────────────────────┬──────────────┐
│    date    │  channel_id  │  media_id  │ time_dimension │          metric_name          │ metric_value │
├────────────┼──────────────┼────────────┼────────────────┼───────────────────────────────┼──────────────┤
│ 2022-01-08 │ channel_id_1 │ video_id_1 │ week           │ annotation_click_through_rate │ 0.05         │
│ 2022-01-08 │ channel_id_1 │ video_id_2 │ week           │ annotation_click_through_rate │ 0.05         │
│ 2022-01-08 │ channel_id_2 │ video_id_1 │ week           │ annotation_click_through_rate │ 0.05         │
└────────────┴──────────────┴────────────┴────────────────┴───────────────────────────────┴──────────────┘


 ```

 ### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

