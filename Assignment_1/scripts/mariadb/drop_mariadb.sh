#!/bin/bash
echo -e "\n-------------------------------------------------"
echo "...Dropping MariaDB Database(without indexing)..."
echo -e "-------------------------------------------------\n"

mysql --password=guntas1032 < scripts/sql_scripts/drop_mariadb.sql

echo "Done!"