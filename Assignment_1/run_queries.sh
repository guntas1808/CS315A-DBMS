#!/bin/bash

# SQlite3
bash scripts/sqlite/query_sqlite_db.sh
bash scripts/sqlite/process_query_dump_sqlite.sh

# MariaDB
bash scripts/mariadb/query_mariadb.sh
bash scripts/mariadb/process_query_dump_mariadb.sh

# MariaDB(Indexed)
bash scripts/mariadb/query_mariadb_indexed.sh
bash scripts/mariadb/process_query_dump_mariadb_indexed.sh

# MongoDB
bash scripts/mongodb/query_mongodb.sh
bash scripts/mongodb/process_query_dump_mongodb.sh
