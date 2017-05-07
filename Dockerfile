FROM docker.io/openshift/origin-keepalived-ipfailover:latest
MAINTAINER Samuel Terburg <sterburg@redhat.com>
ENTRYPOINT /usr/local/bin/entrypoint.sh

COPY bin/  /usr/local/bin/

ENV AWS_ACCESS_KEY_ID=""        \
    AWS_SECRET_ACCESS_KEY=""    \
    OPENSHIFT_HA_NOTIFY_SCRIPT=/usr/local/bin/notify_aws.sh
    
### Install AWS CLI ###
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install cloud-utils python-pip && \
    pip install --upgrade awscli

COPY .aws/ /root/.aws/

