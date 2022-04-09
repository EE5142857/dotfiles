#!/bin/bash
cd $(dirname $0)

while IFS=, read src dest
do
  cp -r ${src} ${dest}
done < mylist.txt

read -p "Press any key to quit."

exit 0
