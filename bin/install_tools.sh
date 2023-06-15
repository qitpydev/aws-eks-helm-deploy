#!/bin/sh

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $*"
}

log "Installing required packages..."
apk add --update --no-cache curl ca-certificates tar openssl
apk add aws-cli

log "Downloading kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && chmod +x kubectl \
  && mv kubectl /usr/local/bin/kubectl

log "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh

log "Installation completed successfully."
