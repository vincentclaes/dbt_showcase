# DBT Showcase

Connecting DBT with various engines


## Setup
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
 ```

## Redshift

#### Prerequisite

- follow the steps of this page to setup redshift: https://docs.getdbt.com/docs/get-started/getting-started/getting-set-up/setting-up-redshift 

```
database: dbtworkshop
user: dbtadmin
password: check profiles.yml
```
- go to security group of redshift and allow all inbound traffic so that I can access from IDE.

```bash
dbt seed --profile redshift
dbt run --profile redshift --select youtube
```


## Redshift Serverless

### Prerequisites

- tutorial: https://itnext.io/dbt-and-amazon-redshift-serverless-serverless-lakehouse-data-modeling-ef9106888137
- reuse security group settings of Redshift
- Query editor v2 > serverless cluster
```
create database dbtworkshop with owner dbtadmin;
```
### Run 

```bash
dbt seed --profile redshift-serverless

18:59:41  Running with dbt=1.3.0
18:59:41  Unable to do partial parsing because config vars, config profile, or config target have changed
18:59:41  Unable to do partial parsing because profile has changed
18:59:41  Unable to do partial parsing because a project dependency has been added
18:59:42  Found 4 models, 0 tests, 0 snapshots, 0 analyses, 327 macros, 0 operations, 2 seed files, 0 sources, 0 exposures, 0 metrics
18:59:42  

19:00:30  Concurrency: 4 threads (target='dev')
19:00:30  
19:00:30  1 of 2 START seed file datahub.content_owner_basic_a3 .......................... [RUN]
19:00:30  2 of 2 START seed file datahub.content_owner_estimated_revenue_a1 .............. [RUN]
19:00:34  1 of 2 OK loaded seed file datahub.content_owner_basic_a3 ...................... [INSERT 24 in 3.90s]
19:00:35  2 of 2 OK loaded seed file datahub.content_owner_estimated_revenue_a1 .......... [INSERT 24 in 4.77s]
19:00:36  
19:00:36  Finished running 2 seeds in 0 hours 0 minutes and 53.53 seconds (53.53s).
19:00:36  
19:00:36  Completed successfully
```
```Bash
dbt run --profile redshift-serverless --select youtube

19:01:06  Found 4 models, 0 tests, 0 snapshots, 0 analyses, 327 macros, 0 operations, 2 seed files, 0 sources, 0 exposures, 0 metrics
19:01:06  
19:01:09  Concurrency: 4 threads (target='dev')
19:01:09  
19:01:09  1 of 4 START sql view model datahub.join ....................................... [RUN]
19:01:12  1 of 4 OK created sql view model datahub.join .................................. [CREATE VIEW in 3.08s]
19:01:12  2 of 4 START sql view model datahub.filter_columns ............................. [RUN]
19:01:15  2 of 4 OK created sql view model datahub.filter_columns ........................ [CREATE VIEW in 2.31s]
19:01:15  3 of 4 START sql view model datahub.features ................................... [RUN]
19:01:17  3 of 4 OK created sql view model datahub.features .............................. [CREATE VIEW in 2.26s]
19:01:17  4 of 4 START sql view model datahub.transform .................................. [RUN]
19:01:19  4 of 4 OK created sql view model datahub.transform ............................. [CREATE VIEW in 2.41s]
19:01:21  
19:01:21  Finished running 4 view models in 0 hours 0 minutes and 14.50 seconds (14.50s).
19:01:21  
19:01:21  Completed successfully
19:01:21  
19:01:21  Done. PASS=4 WARN=0 ERROR=0 SKIP=0 TOTAL=4
```

### Documentation 

```bash
dbt docs generate --profile redshift-serverless
dbt docs serve --profile redshift-serverless
```

### Cost

- 100 users
- job takes 1 minute

__Redshift Serverless__
Example:

```
Query duration - The job runs 13 times between 7:00am-7:00pm, with each run taking 10 minutes and 30 seconds. This adds up to 8190 seconds.

Capacity used - 128 RPUs

Daily charges - $109.20 ((8190 seconds x 128 RPU * $0.375 per RPU-hour for the Region) / 3600 seconds in an hour)

https://docs.aws.amazon.com/redshift/latest/mgmt/serverless-billing.html
```

- Daily charges - $80 ((100 users x 60 seconds x 128 RPU * $0.375 per RPU-hour for the Region) / 3600 seconds in an hour)
- Monthly charges - 2400$

__Glue Python Shell__

For running dbt, we take a glue shell.
Best case we can use 0.0625 of DPU

- Daily charges - 0.14$
- Monthly charges - 4.2$

Using 1 DPU

- Daily charges - 0.82$
- Monthly charges - 24.6$

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
