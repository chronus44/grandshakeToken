#!/bin/bash

file="/root/node/genesisfiles/files/txid.txt"
OLDIFS=$IFS
DATETIME="`date '+Y%m%d%H%M%S'`"

while IFS=',' read x1 x2
do
    while IFS=" " read y1 y2 y3 y4 y5 y6 y7 y8 y9
    do
        # taking only the seventh word from the line
        echo "$y7"
        txid="$y7"
        
        # Store the seventh word or the transaction ID into a file
        echo $txid >> transactionsFile.txt
    done < "$file"

done < "$file"
IFS=$OLDIFS
