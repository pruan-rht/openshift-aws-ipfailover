FROM openshift/origin-haproxy-router:latest
MAINTAINER Samuel Terburg <sterburg@redhat.com>
ENTRYPOINT /usr/local/bin/entrypoint.sh

USER 0
COPY bin/  /usr/local/bin/

ENV AWS_ACCESS_KEY_ID=""        \
    AWS_SECRET_ACCESS_KEY=""    \
    AZURE_STORAGE_ACCOUNT=""    \
    AZURE_STORAGE_ACCESS_KEY="" \
    AZURE_CONFIG_DIR=/root/.azure \
    AZURE_NON_INTERACTIVE_MODE=true \
    
### Install AWS CLI ###
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install python-pip   && \
    yum clean all && \
    pip install --upgrade awscli

COPY .aws/ /root/.aws/

### Install Azure CLI ###
ENV 
RUN curl -L https://aka.ms/InstallAzureCli | bash; \
    pip install --upgrade azure-cli


USER 1001
