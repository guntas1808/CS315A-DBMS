#!/bin/bash

echo -e "\n-------------------------------------------------"
echo    "...........Querying MongoDB Database............."
echo -e "-------------------------------------------------\n"

rm -f data/query_dumps/mongodb/*

TUPLE_COUNT=("100" "100" "100" "1000" "1000" "1000" "10000" "10000" "10000")
B_SUFFIX=("-3-4" "-5-4" "-10-3" "-5-4" "-10-4" "-50-3" "-5-3" "-50-3" "-500-1")

for i in {0..8}; do
    for j in {1..7}; do
        echo "Running trial ${j} on database db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1)"
        
        mongo db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1) scripts/mongodb/query_mongodb.js > data/query_dumps/mongodb/db$(expr ${i} + 1)_query_dump${j}.txt
    done
    echo ""
done

# i=8
# for j in {2..7}; do
#     echo "Running trial ${j} on database db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1)"
        
#     mongo db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1) scripts/mongodb/query_mongodb.js > data/query_dumps/mongodb/db$(expr ${i} + 1)_query_dump${j}.txt
# done

echo "Done!"