# DBT Showcase

```bash
make setup
poetry shell
```

## DuckDB

- sqlite for analytics
- process datasets bigger than memory: https://duckdb.org/2021/12/03/duck-arrow.html
- why duckdb: https://duckdb.org/why_duckdb.html

### Install & configure duckdb
```bash
make setup-duckdb
```
- Configure connection to duckdb in [./profiles.yml](./profiles.yml)

### Run data pipeline

- Dump ingested files to duckdb. These can be found under [seeds/](./seeds)

```bash
# populate seeds to db
dbt seed --profile duckdb

19:40:43  Found 4 models, 2 tests, 0 snapshots, 0 analyses, 292 macros, 0 operations, 2 seed files, 0 sources, 0 exposures, 0 metrics
19:40:43  
19:40:43  Concurrency: 1 threads (target='dev')
19:40:43  
19:40:43  1 of 2 START seed file datahub.content_owner_basic_a3 .......................... [RUN]
19:40:43  1 of 2 OK loaded seed file datahub.content_owner_basic_a3 ...................... [INSERT 24 in 0.18s]
19:40:43  2 of 2 START seed file datahub.content_owner_estimated_revenue_a1 .............. [RUN]
19:40:43  2 of 2 OK loaded seed file datahub.content_owner_estimated_revenue_a1 .......... [INSERT 24 in 0.11s]
19:40:43  
19:40:43  Finished running 2 seeds in 0 hours 0 minutes and 0.39 seconds (0.39s).
19:40:43  
19:40:43  Completed successfully
19:40:43  
```
- Run the steps of the datapipeline in the correct order. Tasks can be found under [models/](./models/youtube)
```bash
# run dbt models
dbt run --profile duckdb --select youtube

19:41:13  Found 4 models, 2 tests, 0 snapshots, 0 analyses, 292 macros, 0 operations, 2 seed files, 0 sources, 0 exposures, 0 metrics
19:41:13  
19:41:13  Concurrency: 1 threads (target='dev')
19:41:13  
19:41:13  1 of 4 START sql view model datahub.join ....................................... [RUN]
19:41:14  1 of 4 OK created sql view model datahub.join .................................. [OK in 0.18s]
19:41:14  2 of 4 START sql view model datahub.transform .................................. [RUN]
19:41:14  2 of 4 OK created sql view model datahub.transform ............................. [OK in 0.14s]
19:41:14  3 of 4 START sql view model datahub.filter_columns ............................. [RUN]
19:41:14  3 of 4 OK created sql view model datahub.filter_columns ........................ [OK in 0.13s]
19:41:14  4 of 4 START sql view model datahub.features ................................... [RUN]
19:41:14  4 of 4 OK created sql view model datahub.features .............................. [OK in 0.14s]
19:41:14  
19:41:14  Finished running 4 view models in 0 hours 0 minutes and 0.69 seconds (0.69s).
19:41:14  
19:41:14  Completed successfully
19:41:14  
19:41:14  Done. PASS=4 WARN=0 ERROR=0 SKIP=0 TOTAL=4
```
- View tables in DuckDB
```bash
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

### Macro's as tasks for the datapipeline

- Define functions for generic stuff in [macros](./macros)
- https://docs.getdbt.com/docs/build/jinja-macros#macros
### Tests

- Define tests in [models/youtube/schema.yml](./models/youtube/schema.yml)

```
dbt test --profile duckdb --select youtube

19:45:28  Found 4 models, 2 tests, 0 snapshots, 0 analyses, 292 macros, 0 operations, 2 seed files, 0 sources, 0 exposures, 0 metrics
19:45:28  
19:45:28  Concurrency: 1 threads (target='dev')
19:45:28  
19:45:28  1 of 2 START test accepted_values_transform_time_dimension__day__week__month__month_3  [RUN]
19:45:28  1 of 2 PASS accepted_values_transform_time_dimension__day__week__month__month_3  [PASS in 0.04s]
19:45:28  2 of 2 START test not_null_transform_metric_value .............................. [RUN]
19:45:28  2 of 2 PASS not_null_transform_metric_value .................................... [PASS in 0.02s]
19:45:28  
19:45:28  Finished running 2 tests in 0 hours 0 minutes and 0.13 seconds (0.13s).
19:45:28  
19:45:28  Completed successfully
19:45:28  
```

- Writing your own custom tests: https://docs.getdbt.com/guides/legacy/writing-custom-generic-tests
- Test utils: https://hub.getdbt.com/dbt-labs/dbt_utils/latest/
- Integration with great-expectations: https://hub.getdbt.com/calogica/dbt_expectations/latest/

### Cost

- 100 users
- job takes 1 minute

__Glue Python Shell__

For running dbt on duckdb we take a glue python shell
with a 1 DPU (4 cpu - 16 GB RAM - 50 GB Disk)

- Daily charges - 0.82$
- Monthly charges - 24.6$

### Compile DBT Models

```
dbt compile --profile duckdb --select youtube
```
check output in [target/compiled/dbt_showcase/models/youtube](./target/compiled/dbt_showcase/models/youtube)


 ### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

