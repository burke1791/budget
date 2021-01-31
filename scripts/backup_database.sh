#!/usr/bin/bash

cd $(dirname $BASH_SOURCE)

if [ -z "$1" ]; then
	echo "database to backup not provided"
	exit 1
fi

date=`date +"%Y-%m-%d"`
filename=backup_$1_$date

echo "backing up database: $1"
pg_dump -U postgres $1 | gzip > $filename.gz

echo "copying backup file to s3"
/usr/local/bin/aws s3 cp backup_$1_$date.gz s3://burkcules-budget/backups/$filename.gz --storage-class=ONEZONE_IA

echo "deleting local backup file"
rm $filename.gz

exit 0
