#!/bin/sh

# this is for making a transaction between primary account to secondary account
# require extra variables from the provided text file
input=`ls /root/node/genesisfiles/files/txn_req_job_*.txt`

# date time
DATETIME="`date '+Y%m%d%H%M%S'`"

for textFile in ${input}
do

    # getting the information from the trigger file
    enrollID=`cat $textFile | awk 'BEGIN {FS="-"};{print $1}'`
    amount=`cat $textFile | awk 'BEGIN {FS="-"};{print $2}'`
    uniqueID=`cat $textFile | awk 'BEGIN {FS="-"};{print $3}'`

    # code to make a transaction
    echo "Transaction Start"
    goal asset send -a $amount --assetid 91537231 -f <primary account or asset creator> -t <secondary account> --creator <primary account or asset creator> --note ENROLLMENTID-$enrollID/AMOUNTBEINGTRANSFERRED-$amount/UNIQUEID-$uniqueID -d /root/node/genesisfiles/testnet | tee gettingTxid.txt

    # the command to get the line that only contain the word txid and save it into txid text file
    grep txid gettingTxid.txt > txid.txt
    
    # running the taking txid only script
    bash /root/node/genesisfiles/files/takingTxidOnly.sh
    echo "Transaction ID has been Recorded to a file"
    echo "Transaction is Complete"

done
echo "For Loop is done"
echo "Should be printed once, no more than 1"
