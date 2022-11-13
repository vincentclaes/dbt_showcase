Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
# dbt_showcase

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

## Athena

```bash
# configure credentials for default profile
aws configure
# this does not work
# populate seeds to db
# dbt seed --profile athena
# check the files on s3
# https://s3.console.aws.amazon.com/s3/buckets/dbt-showcase?region=eu-west-1&prefix=athena/&showversions=false

# take2: 
# manually upload csv's
make setup-athena
# create a cawler
# https://eu-west-1.console.aws.amazon.com/glue/home?region=eu-west-1#/v2/data-catalog/crawlers/add
# give it a name dbt-showcase-load-seeds


# run dbt models
dbt run --profile athena --select youtube
 ```

