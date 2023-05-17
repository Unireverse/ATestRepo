# /bin/bash

COUNT=0
while [ $COUNT -le 30 ]; do
    ((COUNT++))
    echo "$COUNT"
    sleep 1
done
