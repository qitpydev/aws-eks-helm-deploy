#!/bin/bash

# Create the Helm chart
if [ -z ${EKS_CHART_VERSION} ]; then EKS_CHART_VERSION=latest; fi
helm create $EKS_CHART_NAME

# Setting container_port (optional)
if [ -z ${EKS_CONTAINER_PORT} ]; then EKS_CONTAINER_PORT=80; fi
sed -i "s/containerPort: 80/containerPort: $EKS_CONTAINER_PORT/g" ./$EKS_CHART_NAME/templates/deployment.yaml

# Setting livenessProbe vs readinessProbe (optional)
if [ -n "${EKS_CONTAINER_HEALTH_CHECK_PATH}" ]; then
    sed -i "s|path: /|path: $EKS_CONTAINER_HEALTH_CHECK_PATH|g" ./$EKS_CHART_NAME/templates/deployment.yaml
fi

# Installing
helm_args="--set image.repository=${EKS_IMAGE_REPOSITORY:?"EKS_IMAGE_REPOSITORY environment variable is not set"}"
helm_args="$helm_args --set image.tag=$EKS_CHART_VERSION"
helm_args="$helm_args --set service.port=$EKS_CONTAINER_PORT"
helm_args="$helm_args --namespace $EKS_NAMESPACE"

if [ -n "${RESOURCE_LIMITS_CPU}" ]; then
    helm_args="$helm_args --set resources.limits.cpu=${RESOURCE_LIMITS_CPU}"
fi

if [ -n "${RESOURCE_LIMITS_MEMORY}" ]; then
    helm_args="$helm_args --set resources.limits.memory=${RESOURCE_LIMITS_MEMORY}"
fi

if [ -n "${RESOURCE_REQUEST_CPU}" ]; then
    helm_args="$helm_args --set resources.requests.cpu=${RESOURCE_REQUEST_CPU}"
fi

if [ -n "${RESOURCE_REQUEST_MEMORY}" ]; then
    helm_args="$helm_args --set resources.requests.memory=${RESOURCE_REQUEST_MEMORY}"
fi

helm upgrade --install $EKS_CHART_NAME $EKS_CHART_NAME $helm_args
