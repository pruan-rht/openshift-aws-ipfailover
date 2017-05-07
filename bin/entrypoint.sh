#!/bin/bash

OPENSHIFT_HA_NOTIFY_SCRIPT=${OPENSHIFT_HA_NOTIFY_SCRIPT:-/usr/local/bin/notify_aws.sh}

envsubst < /root/.aws/config.tpl       >/root/.aws/config
envsubst < /root/.aws/credentials.tpl  >/root/.aws/credentials

exec /var/lib/ipfailover/keepalived/monitor.sh $@
