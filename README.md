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

- tutorial: https://itnext.io/dbt-and-amazon-redshift-serverless-serverless-lakehouse-data-modeling-ef9106888137
- reuse security group settings of Redshift
- Query editor v2 > serverless cluster
```
create database dbtworkshop with owner dbtadmin;
```

```bash
dbt seed --profile redshift-serverless
dbt run --profile redshift --select youtube
```

### Documentation 

```bash
dbt docs generate --profile redshift-serverless
dbt docs serve --profile redshift-serverless
```

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
