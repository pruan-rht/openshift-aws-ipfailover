#!/bin/bash

. /var/lib/ipfailover/keepalived/lib/failover-functions.sh

AWS_EC2_INSTANCE_ID=$(ec2metadata --instance-id)
VRRP_STATE=${3:-BACKUP}

for VIRTUAL_IP in $(expand_ip_ranges "${OPENSHIFT_HA_VIRTUAL_IPS}"); do
  aws ec2 disassociate-address --public-ip $VIRTUAL_IP
  if [ "$VRRP_STATE" == "MASTER" ]; then
     aws ec2 associate-address    --public-ip $VIRTUAL_IP --instance-id $AWS_EC2_INSTANCE_ID
  fi
done

