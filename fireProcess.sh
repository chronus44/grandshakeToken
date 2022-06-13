#!/bin/bash

# variable for infinite loop
noEnd=1

# infinite loop
while [ $noEnd -gt 0 ]
do

    # the sleep timer is to determined how long the system will check every sleep timer
    sleep 10m
    
    # run the creator script to check if there are any transaction needed or not, if there is, then the transaction file will be created
    bash /root/node/genesisfiles/files/creatorScript.sh
    echo "file extracted"

    # check how many file that needed for transactions
    fileCount=`ls /root/node/genesisfiles/files/txn_req_job*.txt | wc -l`

    # check date time of the process that then will be used for changing name of the files
    DATETIME="`date '+Y%m%d%H%M%S'`"
    
    echo "Number of transaction will be made is $fileCount transaction(s)"
    
    # the if statement that to call the expectFile.exp
    if [ $fileCount -ne 0 ];then
        expect /root/node/genesisfiles/files/expectFile.exp $fileCount
        bash pythonCall.sh
        mv transactionsFile.txt transactionsID-$DATETIME.txt
        mv transactionsID-*.txt transactionIDLogFiles
        mv txn_req_job*.txt extractionPoint/triggerHistory
        echo "If statement is done"
    else
        echo "There is no need to make any new Transaction at the moment!!!"
fi
done
