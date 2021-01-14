#!/usr/bin/bash

cd $(dirname $BASH_SOURCE)

if [ -z "$1" ]; then
	echo "ERROR: folder name not provided"
	exit 1
fi

for filename in /mnt/burke/landing_zone/$1/*; do
	name=`basename $filename`
	if [[ $name =~ ^(.+)\.csv$ ]]; then
		tranFile=$name
		break
	fi
done;

if [ -z {$tranFile+x} ]; then
	echo "no file found for $1, exiting early"
	exit 0
fi


echo "loading file: $tranFile"

psql -U postgres -d budget -c "Call load_raw_transactions('$1', '$tranFile')"

echo "copying file to archive"
mv /mnt/burke/landing_zone/$1/$tranFile /mnt/burke/landing_zone/$1/archive
