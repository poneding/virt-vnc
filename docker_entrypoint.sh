#!/bin/sh

sed -i 's|ENV_VM_NAMESPACE|'${VM_NAMESPACE}'|g' /static/index.html
sed -i 's|ENV_VM_NAME|'${VM_NAME}'|g' /static/index.html

kubectl proxy --port=8080 --www=/static --accept-hosts=^.*$ --address=[::] --api-prefix=/k8s/ --www-prefix=