#!/bin/bash

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $*"
}

log "Running the test..."
sh ./bin/validate_input.sh

log "Copying the kubeconfig file from S3..."
aws s3 cp "${KUBECONFIG_FILE_S3_URL}" ~/.kube/config

log "Installing the chart..."
sh ./bin/install_chart.sh
