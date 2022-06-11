#!/bin/bash

catchupPointTestnet=`curl https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/testnet/latest.catchpoint`
catchupPointBetanet=`curl https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/betanet/latest.catchpoint`
catchupPointMainnet=`curl https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/mainnet/latest.catchpoint`

#the code is all depends on the server that is being run, if it is the wrong server, it will not give or do anything

# uncomment the code below to get the catchup point from the Testnet server
#goal node catchup $catchupPointTestnet -d ../testnet

# uncomment the code below to get the catchup point from the Testnet server
#goal node catchup $catchupPointBetanet -d ../betanet

# uncomment the code below to get the catchup point from the Testnet server
#goal node catchup $catchupPointMainnet
