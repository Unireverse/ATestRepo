# /bin/bash

COUNT=0
while [ $COUNT -le 100 ]; do
    ((COUNT++))
    echo "$COUNT"
    sleep 0.2
done
