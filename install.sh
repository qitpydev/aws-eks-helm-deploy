#!/bin/bash

# Parse command line arguments
OPTIONS=$(getopt -o r:c: --long repository:,chart-name: -- "$@")
eval set -- "$OPTIONS"
while true; do
  case "$1" in
    -r|--repository)
      REPOSITORY="$2"; shift 2;;
    -c|--chart-name)
      CHART_NAME="$2"; shift 2;;
    --)
      shift; break;;
    *)
      echo "Invalid argument: $1" >&2; exit 1;;
  esac
done

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Create the Helm chart
helm create $CHART_NAME

# Set the image.repository value
sed -i "s|repository: nginx|repository: $REPOSITORY|g" $CHART_NAME/values.yaml