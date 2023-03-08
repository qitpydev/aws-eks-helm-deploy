#!/bin/bash
# # Parse command line arguments
# OPTIONS=$(getopt -o r:c:n:v: --long repository:,chart-name:,namespace:,chart-version: -- "$@")
# eval set -- "$OPTIONS"
# while true; do
#   case "$1" in
#     -r|--repository)
#       REPOSITORY="$2"; shift 2;;
#     -c|--chart-name)
#       CHART_NAME="$2"; shift 2;;
#     -n|--namespace)
#       NAMESPACE="$2"; shift 2;;
#     -v|--chart-version)
#       CHART_VERSION="$2"; shift 2;;
#     --)
#       shift; break;;
#     *)
#       echo "Invalid argument: $1" >&2; exit 1;;
#   esac
# done

# Create the Helm chart
helm create $EKS_CHART_NAME

helm upgrade --install $EKS_CHART_NAME $EKS_CHART_NAME \
    --set image.repository=$EKS_IMAGE_REPOSITORY \
    --set image.tag=$EKS_CHART_VERSION \
    --set service.port=80 \
    --set containerPort=$EKS_CONTAINER_PORT \
    --namespace $EKS_NAMESPACE