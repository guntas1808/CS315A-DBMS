#!/bin/bash
echo -e "\n-------------------------------------------------"
echo "...Creating MariaDB Database(without indexing)..."
echo -e "-------------------------------------------------\n"


mysql --password=guntas1032 -v < scripts/sql_scripts/create_mariadb.sql

echo "Done!"