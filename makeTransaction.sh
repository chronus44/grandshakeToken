#!/bin/sh

# this is for making a transaction between primary account to secondary account
# require extra variables from the provided text file
input=`ls /root/node/genesisfiles/files/txn_req_job_*.txt`


DATETIME="`date '+Y%m%d%H%M%S'`"

for textFile in ${input}
do

    enrollID=`cat $textFile | awk 'BEGIN {FS="-"};{print $1}'`
    amount=`cat $textFile | awk 'BEGIN {FS="-"};{print $2}'`
    uniqueID=`cat $textFile | awk 'BEGIN {FS="-"};{print $3}'`

    # code to make a transaction
    echo "Transaction Start"

    goal asset send -a $amount --assetid 91537231 -f <primary account or asset creator> -t <secondary account> --creator <primary account or asset creator> --note ENROLLMENTID-$enrollID/AMOUNTBEINGTRANSFERRED-$amount/UNIQUEID-$uniqueID -d /root/node/genesisfiles/testnet | tee gettingTxid.txt

    grep txid gettingTxid.txt > txid.txt
    bash /root/node/genesisfiles/files/takingTxidOnly.sh
    echo "Transaction ID has been Recorded to a file"
    echo "Transaction is Complete"

done
echo "For Loop is done"
echo "Should be printed once, no more than 1"
