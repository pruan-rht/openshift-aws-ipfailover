#!/bin/bash -x

. /var/lib/ipfailover/keepalived/lib/failover-functions.sh

AWS_EC2_INSTANCE_ID=$(ec2metadata --instance-id)
VRRP_STATE=${3:-BACKUP}

for VIRTUAL_IP in $(expand_ip_ranges "${OPENSHIFT_HA_VIRTUAL_IPS}"); do
  if [ "$VRRP_STATE" == "MASTER" ]; then
    AWS_EC2_CURRENT_INSTANCE_ID=`aws ec2 describe-addresses --public-ips=$VIRTUAL_IP --query='Addresses[0].InstanceId' --output text`
    if [ "${AWS_EC2_CURRENT_INSTANCE_ID}" != "${AWS_EC2_INSTANCE_ID}" ]; then
      aws ec2 disassociate-address --public-ip $VIRTUAL_IP
      aws ec2 associate-address    --public-ip $VIRTUAL_IP --instance-id $AWS_EC2_INSTANCE_ID
    fi
  fi
done

