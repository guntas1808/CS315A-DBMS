#!/bin/bash

# Process dumps to extract time
echo -e "\n-------------------------------------------------"
echo    "...Processing MariaDB(Non-indexed) Query Dump...."
echo -e "-------------------------------------------------\n"

rm -f data/query_time_data/mariadb/*

TUPLE_COUNT=("100" "100" "100" "1000" "1000" "1000" "10000" "10000" "10000")

for i in {0..8}; do
    echo "Processing query dump for db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1)"
    for j in {1..7}; do
        cat data/query_dumps/mariadb/db$(expr ${i} + 1)_query_dump${j}.txt | grep SELECT | cut -c3- | sed 's/SELECT.*//' >> data/query_time_data/mariadb/db$(expr ${i} + 1).txt
    done
done

echo "Done!"