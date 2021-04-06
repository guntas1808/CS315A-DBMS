#!/bin/bash

echo -e "\n-------------------------------------------------"
echo    "...........Dropping MongoDB Database............."
echo -e "-------------------------------------------------\n"

mongo scripts/mongodb/drop_mongodb.js

echo -e "\nDone"