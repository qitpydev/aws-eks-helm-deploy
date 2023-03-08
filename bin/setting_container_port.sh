#!/bin/bash
if [ -z ${EKS_CONTAINER_PORT+x} ]; then EKS_CONTAINER_PORT=80; fi
# Replace the containerPort value with the new value
sed -i "s/containerPort: 80/containerPort: $EKS_CONTAINER_PORT/g" ./$EKS_CHART_NAME/templates/deployment.yaml