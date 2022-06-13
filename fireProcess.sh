#!/bin/bash

# variable for infinite loop
noEnd=1

while [ $noEnd -gt 0 ]
do
    sleep 10m
    bash /root/node/genesisfiles/files/creatorScript.sh
    echo "file extracted"

    fileCount=`ls /root/node/genesisfiles/files/txn_req_job*.txt | wc -l`

    DATETIME="`date '+Y%m%d%H%M%S'`"

    echo "Number of transaction will be made is $fileCount transaction(s)"
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
