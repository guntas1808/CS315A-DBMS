#!/bin/bash

# SQlite3
bash scripts/sqlite/create_sqlite_db.sh

# MariaDB
bash scripts/mariadb/create_mariadb.sh

# MariaDB(Indexed)
bash scripts/mariadb/create_mariadb_indexed.sh

# MongoDB
bash scripts/mongodb/create_mongodb.sh
