#!/bin/bash

# run the test
sh test.sh

# copy the kubeconfig file from S3
aws s3 cp ${KUBECONFIG_FILE_S3_URL} ~/.kube/config

helm create $EKS_CHART_NAME
# sh /bin/setting_container_port.sh
if [ -z ${EKS_CONTAINER_PORT+x} ]; then EKS_CONTAINER_PORT=80; fi
sed -i "s/containerPort: 80/containerPort: $EKS_CONTAINER_PORT/g" /$EKS_CHART_NAME/templates/deployment.yaml

sh /bin/install_chart.sh
