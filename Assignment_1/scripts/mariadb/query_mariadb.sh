#!/bin/bash
echo -e "\n-------------------------------------------------"
echo "......Querying MariaDB(without indexing)........."
echo -e "-------------------------------------------------\n"

rm -f data/query_dumps/mariadb/*

TUPLE_COUNT=("100" "100" "100" "1000" "1000" "1000" "10000" "10000" "10000")

for i in {0..8}; do
    for j in {1..7}; do
        echo "Running trial ${j} on database db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1)"

        mysql --password=guntas1032 --database=db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1) < scripts/sql_scripts/query_mariadb.sql  >> data/query_dumps/mariadb/db$(expr ${i} + 1)_query_dump${j}.txt
    done
    echo ""
done

# for j in {1..3}; do
#     echo "Running trial ${j} on database db_${TUPLE_COUNT[6]}_$(expr 6 % 3 + 1)"

#     mysql --password=guntas1032 --database=db_${TUPLE_COUNT[6]}_$(expr 6 % 3 + 1) < scripts/sql_scripts/query_mariadb.sql  >> data/query_dumps/mariadb/db$(expr 6 + 1)_query_dump${j}.txt
    
# done

echo "Done!"