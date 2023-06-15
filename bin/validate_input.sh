#!/bin/bash

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $*"
}

if [[ -z "${AWS_ACCESS_KEY_ID}" ]]; then
  log "Error: AWS_ACCESS_KEY_ID argument is missing"
  exit 1
fi

if [[ -z "${AWS_SECRET_ACCESS_KEY}" ]]; then
  log "Error: AWS_SECRET_ACCESS_KEY argument is missing"
  exit 1
fi

if [[ -z "${AWS_DEFAULT_REGION}" ]]; then
  log "Error: AWS_DEFAULT_REGION argument is missing"
  exit 1
fi

if [[ -z "${KUBECONFIG_FILE_S3_URL}" ]]; then
  log "Error: KUBECONFIG_FILE_S3_URL argument is missing"
  exit 1
fi

if [[ -z "$EKS_IMAGE_REPOSITORY" ]]; then
  log "Error: Repository argument is missing."
  exit 1
fi
if [[ -z "$EKS_CHART_NAME" ]]; then
  log "Error: Chart name argument is missing."
  exit 1
fi
if [[ -z "$EKS_NAMESPACE" ]]; then
  log "Error: Namespace argument is missing."
  exit 1
fi
