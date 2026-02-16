#!/bin/bash

FILE="cluster_start.txt"

if [ -f $FILE ]; then
  START=$(cat $FILE)
  NOW=$(date +%s)
  HOURS=$(( (NOW - START) / 3600 ))

  if [ $HOURS -ge 48 ]; then
    cd terraform
    terraform destroy -auto-approve
  fi
fi
