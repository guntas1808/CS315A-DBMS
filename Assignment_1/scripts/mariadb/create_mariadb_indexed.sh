#!/bin/bash
echo -e "\n-------------------------------------------------"
echo    "....Creating MariaDB Database(with indexing)....."
echo -e "-------------------------------------------------\n"

mysql --password=guntas1032 -v < scripts/sql_scripts/create_mariadb_indexed.sql

echo "Done!"