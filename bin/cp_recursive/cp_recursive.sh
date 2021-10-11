#!/bin/bash
cd $(dirname $0)

while read line
do
  ${col1}=`echo ${line} | cut -d ',' -f 1`
  ${col2}=`echo ${line} | cut -d ',' -f 2`
  cp -r ${col1} ${col2}
done < config.csv

read -p "Press [Enter] to quit."

exit 0
