#!/bin/bash

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $*"
}

log "Creating the Helm chart..."
if [ -z "${EKS_CHART_VERSION}" ]; then
  EKS_CHART_VERSION=latest
else
  log "EKS_CHART_VERSION: $EKS_CHART_VERSION"
fi

helm create "$EKS_CHART_NAME"

log "Setting container_port (optional)..."
if [ -z "${EKS_CONTAINER_PORT}" ]; then
  EKS_CONTAINER_PORT=80
else
  log "EKS_CONTAINER_PORT: $EKS_CONTAINER_PORT"
fi

sed -i "s/containerPort: 80/containerPort: $EKS_CONTAINER_PORT/g" "./$EKS_CHART_NAME/templates/deployment.yaml"

log "Setting livenessProbe vs readinessProbe (optional)..."
if [ -n "${EKS_CONTAINER_HEALTH_CHECK_PATH}" ]; then
  log "EKS_CONTAINER_HEALTH_CHECK_PATH: $EKS_CONTAINER_HEALTH_CHECK_PATH"
  sed -i "s|path: /|path: $EKS_CONTAINER_HEALTH_CHECK_PATH|g" "./$EKS_CHART_NAME/templates/deployment.yaml"
fi

log "Installing..."
helm_args="--set image.repository=${EKS_IMAGE_REPOSITORY:?"EKS_IMAGE_REPOSITORY environment variable is not set"}"
helm_args="$helm_args --set image.tag=$EKS_CHART_VERSION"
helm_args="$helm_args --set service.port=$EKS_CONTAINER_PORT"
helm_args="$helm_args --namespace $EKS_NAMESPACE"

if [ -n "${RESOURCE_LIMITS_CPU}" ]; then
  log "RESOURCE_LIMITS_CPU: $RESOURCE_LIMITS_CPU"
  helm_args="$helm_args --set resources.limits.cpu=${RESOURCE_LIMITS_CPU}"
else
  log "RESOURCE_LIMITS_CPU: use default"
fi

if [ -n "${RESOURCE_LIMITS_MEMORY}" ]; then
  log "RESOURCE_LIMITS_MEMORY: $RESOURCE_LIMITS_MEMORY"
  helm_args="$helm_args --set resources.limits.memory=${RESOURCE_LIMITS_MEMORY}"
else
  log "RESOURCE_LIMITS_MEMORY: use default"
fi

if [ -n "${RESOURCE_REQUEST_CPU}" ]; then
  log "RESOURCE_REQUEST_CPU: $RESOURCE_REQUEST_CPU"
  helm_args="$helm_args --set resources.requests.cpu=${RESOURCE_REQUEST_CPU}"
else
  log "RESOURCE_REQUEST_CPU: use default"
fi

if [ -n "${RESOURCE_REQUEST_MEMORY}" ]; then
  log "RESOURCE_REQUEST_MEMORY: $RESOURCE_REQUEST_MEMORY"
  helm_args="$helm_args --set resources.requests.memory=${RESOURCE_REQUEST_MEMORY}"
else
  log "RESOURCE_REQUEST_MEMORY: use default"
fi

log "helm_args: $helm_args"

helm upgrade --install "$EKS_CHART_NAME" "$EKS_CHART_NAME" "$helm_args"
