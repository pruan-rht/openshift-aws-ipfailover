#!/bin/bash

envsubst < /root/.aws/config.tpl       >/root/.aws/config
envsubst < /root/.aws/credentials.tpl  >/root/.aws/credentials
envsubst < /root/.azure/azure.conf.tpl >/root/.azure/azure.conf

exec /usr/bin/openshift-router $@
