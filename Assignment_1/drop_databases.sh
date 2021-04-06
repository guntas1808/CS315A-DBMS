#!/bin/bash

# SQlite3
bash scripts/sqlite/drop_sqlite_db.sh

# MariaDB
bash scripts/mariadb/drop_mariadb.sh

# MariaDB(Indexed)
bash scripts/mariadb/drop_mariadb_indexed.sh

# MongoDB
bash scripts/mongodb/drop_mongodb.sh
