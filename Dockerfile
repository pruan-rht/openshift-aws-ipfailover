FROM openshift/origin-haproxy-router:latest

USER 0

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install python-pip   && \
    yum clean all && \
    pip install --upgrade --user awscli

COPY .aws/ /root/.aws/
COPY bin/  /usr/local/bin/

USER 1001
