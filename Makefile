BUCKET := dbt-showcase
setup:
	poetry install

setup-duckdb:
	rm -rf duckdb/
	wget https://github.com/duckdb/duckdb/releases/download/v0.5.1/duckdb_cli-linux-amd64.zip -O duckdb.zip
	unzip duckdb.zip
	sudo mv duckdb /usr/local/bin/duckdb
	rm -f duckdb.zip
	mkdir -p duckdb
