#!/usr/bin/bash

# parses well-known csv files into a format readable by the database

function parse_chase_credit_card {
	while IFS=, read -r tdate pdate desc category ttype amt memo; do
		[ "$tdate" == "Transaction Date" ] && echo "transaction_date,description,amount"
		[ "$tdate" != "Transaction Date" ] && echo "$tdate,$desc,$amt"
	done < /mnt/burke/landing_zone/$1/$2
}

function parse_chase_checking {
	while IFS=, read -r details pdate desc amt ttype balance checkNum; do
		[ "$details" == "Details" ] && echo "transaction_date,description,amount"
		[ "$details" != "Details" ] && echo "$pdate,$desc,$amt"
	done < /mnt/burke/landing_zone/$1/$2
}

function parse_discover {
	while IFS=, read -r tdate pdate desc amt category; do
		[ "$tdate" == "Trans. Date" ] && echo "transaction_date,description,amount"
		[ "$tdate" != "Trans. Date" ] && echo "$tdate,$desc,$amt"
	done < /mnt/burke/landing_zone/$1/$2
}

function parse_alliant {
	
}

if [[ $1 == "chase_freedom" || $1 == "chase_sapphire_reserve" ]]; then
	parse_chase_credit_card $1 $2
elif [[ $1 == "chase_checking" ]]; then
	parse_chase_checking $1 $2
elif [[ $1 == "discover_card" ]]; then
	parse_discover $1 $2
elif [[ $1 == "alliant_savings" ]]; then
	parse_alliant $1 $2
fi
