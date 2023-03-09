#!/bin/bash

# Create the Helm chart
if [ -z ${EKS_CHART_VERSION+x} ]; then EKS_CHART_VERSION=latest; fi
helm create $EKS_CHART_NAME

# Setting container_port (optional)
if [ -z ${EKS_CONTAINER_PORT+x} ]; then EKS_CONTAINER_PORT=80; fi
sed -i "s/containerPort: 80/containerPort: $EKS_CONTAINER_PORT/g" ./$EKS_CHART_NAME/templates/deployment.yaml

# Setting livenessProbe vs readinessProbe (optional)
if [ -n "$EKS_CONTAINER_HEALTH_CHECK_PATH" ]; then
    sed -i "s|path: /|path: $EKS_CONTAINER_HEALTH_CHECK_PATH|g" ./$EKS_CHART_NAME/templates/deployment.yaml
fi

# Installing
helm upgrade --install $EKS_CHART_NAME $EKS_CHART_NAME \
    --set image.repository=$EKS_IMAGE_REPOSITORY \
    --set image.tag=$EKS_CHART_VERSION \
    --set service.port=$EKS_CONTAINER_PORT \
    --namespace $EKS_NAMESPACE