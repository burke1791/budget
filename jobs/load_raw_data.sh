#!/usr/bin/bash

cd $(dirname $BASH_SOURCE)

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


echo
echo "job complete"
