#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
DELEGATOR='Your delegator address'
VALIDATOR='Your validator address'
NET='What net this script should be used for, eg. rizond, omniflix, .etc'
CURRENCY='Specific currency'
CHAIN_ID='Specific chain-id'
FEE='Specific fee amount'
KEYPHRASE='password from cli'
DELAY=3600 #in secs - how often restart the script 
WALLET_NAME='Your wallet name'
NODE=http://localhost:26657 #change it only if you use another rpc port of your node

for (( ;; )); do
        BAL=$(${NET} query bank balances ${DELEGATOR} --node ${NODE});
        echo -e "BALANCE: ${GREEN}${BAL}${NC} ${CURRENCY}\n"
        echo -e "Claim rewards\n"
        echo -e "${KEYPHRASE}\n${KEYPHRASE}\n" | ${NET} tx distribution withdraw-rewards ${VALIDATOR} --chain-id ${CHAIN_ID} --from ${WALLET_NAME} --node ${NODE} --commission -y --fees ${FEE}${CURRENCY}
        for (( timer=10; timer>0; timer-- ))
        do
                printf "* sleep for ${RED}%02d${NC} sec\r" $timer
                sleep 1
        done
        BAL=$(${NET} query bank balances ${DELEGATOR} --node ${NODE} -o json | jq -r '.balances | .[].amount');
        BAL=$((BAL-1000000));
        echo -e "BALANCE: ${GREEN}${BAL}${NC} ${CURRENCY}\n"
        echo -e "Stake ALL\n"
        echo -e "${KEYPHRASE}\n${KEYPHRASE}\n" | ${NET} tx staking delegate ${VALIDATOR} ${BAL}${CURRENCY} --chain-id ${CHAIN_ID} --from ${WALLET_NAME} --node ${NODE} -y --fees  ${FEE}${CURRENCY}
        for (( timer=${DELAY}; timer>0; timer-- ))
        do
                printf "* sleep for ${RED}%02d${NC} sec\r" $timer
                sleep 1
        done
done