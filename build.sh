# /bin/bash

COUNT=0
while [ $COUNT -le 30 ]; do
    ((COUNT++))
    echo "$COUNT" >> log
    sleep 1
done