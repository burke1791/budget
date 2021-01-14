#!/usr/bin/bash

cd $(dirname $BASH_SOURCE)

LOG_FILE=/mnt/burke/budget/logs/backup_databases.log
exec 1>> >(ts '[%Y-%m-%d %H:%M:%S]' >> "$LOG_FILE") 2>&1

echo
echo "**********************************************************************"
echo "*******************  Begin Database Backup Job  **********************"
echo "**********************************************************************"
echo

# DB: budget
bash ../scripts/backup_database.sh budget

echo
echo "job complete"
