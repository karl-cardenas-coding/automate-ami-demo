#!/bin/bash

echo -n $(aws organizations list-accounts --profile $PROFILE --output json --query Accounts[*].Id | sed 's/[][]//g') >> $FILE
