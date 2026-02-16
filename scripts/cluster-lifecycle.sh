#!/bin/bash

ACTION=$1

if [ "$ACTION" == "create" ]; then
  terraform apply -auto-approve
  echo "Cluster created at $(date)" > cluster_start_time.txt
fi

if [ "$ACTION" == "destroy" ]; then
  terraform destroy -auto-approve
fi
