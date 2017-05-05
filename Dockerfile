FROM docker.io/openshift/origin-keepalived-ipfailover:latest
MAINTAINER Samuel Terburg <sterburg@redhat.com>
ENTRYPOINT /usr/local/bin/entrypoint.sh

COPY bin/  /usr/local/bin/

ENV AWS_ACCESS_KEY_ID=""        \
    AWS_SECRET_ACCESS_KEY=""    \
    AZURE_STORAGE_ACCOUNT=""    \
    AZURE_STORAGE_ACCESS_KEY="" \
    AZURE_CONFIG_DIR=/root/.azure \
    AZURE_NON_INTERACTIVE_MODE=true \
    OPENSHIFT_HA_NOTIFY_SCRIPT=/usr/local/bin/notify_aws.sh
    
### Install AWS CLI ###
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install cloud-utils python-pip && \
    pip install --upgrade awscli

COPY .aws/ /root/.aws/

### Install Azure CLI ###
RUN yum -y install gcc libffi-devel python-devel openssl-devel && \
    yum clean all && \
    curl -L https://aka.ms/InstallAzureCli | bash; \
    pip install --upgrade azure-cli

