#!/bin/bash

# Create the Helm chart
if [ -z ${EKS_CHART_VERSION+x} ]; then EKS_CHART_VERSION=latest; fi
helm create $EKS_CHART_NAME

echo 'PrePare'
# Setting container_port (optionals)
if [ -z ${EKS_CONTAINER_PORT+x} ]; then EKS_CONTAINER_PORT=80; fi
sed -i "s/containerPort: 80/containerPort: $EKS_CONTAINER_PORT/g" ./$EKS_CHART_NAME/templates/deployment.yaml
sed -i "s/containerPort: 80/containerPort: $EKS_CONTAINER_PORT/g" ./$EKS_CHART_NAME/templates/deployment.yaml
cat ./$EKS_CHART_NAME/templates/deployment.yaml
echo 'PASSSSSSSS'

# Installing
helm upgrade --install $EKS_CHART_NAME $EKS_CHART_NAME \
    --set image.repository=$EKS_IMAGE_REPOSITORY \
    --set image.tag=$EKS_CHART_VERSION \
    --namespace $EKS_NAMESPACE