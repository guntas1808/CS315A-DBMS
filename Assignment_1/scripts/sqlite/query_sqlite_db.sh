#!/bin/bash

# Query
rm -f data/query_dumps/sqlite/*

TUPLE_COUNT=("100" "100" "100" "1000" "1000" "1000" "10000" "10000" "10000")

echo -e "\n-------------------------------------------------"
echo "...........Querying SQlite3 Database............."
echo -e "-------------------------------------------------\n"


for i in {0..8}; do
    for j in {1..7}; do
        echo "Running trial ${j} on database db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1)"

        sqlite3 data/sqlite3_db/db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1) ".read scripts/sql_scripts/query_sqlite.sql"  >> data/query_dumps/sqlite/db$(expr ${i} + 1)_query_dump${j}.txt
    done
done

echo "Done!"