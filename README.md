# openshift-aws-ipfailover
On OpenShift Container Platform, add support for ipfailover on AWS cloud-provider.

# How it works
Using the aws-cli / azure-cli to move an elastic-ip from one VM to the other VM instance.

# How to use
```
oc -n openshift new-build https://github.com/sterburg/origin-cloud-ipfailover.git#aws
oc -n default   adm ipfailover --virtual-ips=1.2.3.4 --images=172.30.74.17:5000/openshift/origin-cloud-ipfailover:latest --selector=router=public
oc -n default   env dc/ipfailover AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=....
oc -n default   volume dc/ipfailover  --add --mount-path=/root/.aws --type=hostPath --path=/etc/origin/cloudprovider
```

For detailed info see blog-post: http://www.sterburg.nl/2017/05/07/saving-aws-elb-usage-cost-using-openshifts-built-in-keepalived-ipfailover/
