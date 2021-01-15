#!/usr/bin/bash

cd $(dirname $BASH_SOURCE)

LOG_FILE=/mnt/burke/budget/logs/raw_data.log
exec 1>> >(ts '[%Y-%m-%d %H:%M:%S]' >> "$LOG_FILE") 2>&1


echo
echo "**********************************************************************"
echo "****************  Begin Load Raw Transactions Job  *******************"
echo "**********************************************************************"
echo

# Load Chase Checking
bash ../scripts/load_file.sh chase_checking

# Load Alliant Savings
bash ../scripts/load_file.sh alliant_savings

# Load Chase Sapphire Reserve
bash ../scripts/load_file.sh chase_sapphire_reserve

# Load Chase Freedom
bash ../scripts/load_file.sh chase_freedom

# Discover Card
bash ../scripts/load_file.sh discover_card


# Process raw transaction data
echo
echo "processing raw transaction data"
echo

psql -U postgres -d budget -c "Call process_raw_transactions()"

echo
echo "job complete"
