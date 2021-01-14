#!/usr/bin/bash

# Copy log files to an archive folder

cd $(dirname $BASH_SOURCE)

date=`date +"%Y-%m-%d"`

# Raw data logs
mv ../logs/raw_data.log ../logs/archive/raw_data_$date.log
