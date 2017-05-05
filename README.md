# origin-haproxy-cloud-router
Add support for ipfailover for cloud-provider.

# How it works
Use the aws-cli / azure-cli to move a floating-ip from one VM to the other VM.

# How to use
```
oc -n openshift new-build https://github.com/sterburg/origin-cloud-ipfailover.git#aws
oc -n default   adm ipfailover --virtual-ips=52.48.65.140 --images=172.30.74.17:5000/openshift/origin-cloud-ipfailover:latest
```

