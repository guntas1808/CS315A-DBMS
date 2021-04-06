#!/bin/bash

rm -f data/sqlite3_db/*

TUPLE_COUNT=("100" "100" "100" "1000" "1000" "1000" "10000" "10000" "10000")
B_SUFFIX=("-3-4" "-5-4" "-10-3" "-5-4" "-10-4" "-50-3" "-5-3" "-50-3" "-500-1")

echo "\n-------------------------------------------------"
echo "...........Creating SQlite3 Database............."
echo "-------------------------------------------------\n"


for i in {0..8}; do
    echo "Creating database db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1)"

    cat scripts/sql_scripts/create_sql_db.sql > scripts/sql_scripts/temp.sql
    echo ".import dbs/A-${TUPLE_COUNT[i]}.csv A" >> scripts/sql_scripts/temp.sql
    echo ".import dbs/B-${TUPLE_COUNT[i]}${B_SUFFIX[i]}.csv B" >> scripts/sql_scripts/temp.sql
    # echo "db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1) "
    sqlite3 data/sqlite3_db/db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1)  ".read scripts/sql_scripts/temp.sql"
    rm scripts/sql_scripts/temp.sql
done

echo "Done!"