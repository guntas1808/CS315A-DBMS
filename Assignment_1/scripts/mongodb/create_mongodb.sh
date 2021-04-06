#!/bin/bash

echo -e "\n-------------------------------------------------"
echo "...........Creating MongoDB Database............."
echo -e "-------------------------------------------------\n"

TUPLE_COUNT=("100" "100" "100" "1000" "1000" "1000" "10000" "10000" "10000")
B_SUFFIX=("-3-4" "-5-4" "-10-3" "-5-4" "-10-4" "-50-3" "-5-3" "-50-3" "-500-1")

for i in {0..8}; do
    echo -e "\nImporting db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1).."
    mongoimport --type csv -d db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1) -c A --headerline --drop dbs/A-${TUPLE_COUNT[i]}.csv
    mongoimport --type csv -d db_${TUPLE_COUNT[i]}_$(expr ${i} % 3 + 1) -c B --headerline --drop dbs/B-${TUPLE_COUNT[i]}${B_SUFFIX[i]}.csv
done

echo "Done!"