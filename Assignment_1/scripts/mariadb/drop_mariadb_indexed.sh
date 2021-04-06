#!/bin/bash
echo -e "\n-------------------------------------------------"
echo    "....Dropping MariaDB Database(with indexing)....."
echo -e "-------------------------------------------------\n"

mysql --password=guntas1032 < scripts/sql_scripts/drop_mariadb_indexed.sql

echo "Done!"