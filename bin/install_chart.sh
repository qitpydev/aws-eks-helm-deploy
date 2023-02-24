#!/bin/bash
# Parse command line arguments
OPTIONS=$(getopt -o r:c:n:v: --long repository:,chart-name:,namespace:,chart-version: -- "$@")
eval set -- "$OPTIONS"
while true; do
  case "$1" in
    -r|--repository)
      REPOSITORY="$2"; shift 2;;
    -c|--chart-name)
      CHART_NAME="$2"; shift 2;;
    -n|--namespace)
      NAMESPACE="$2"; shift 2;;
    -v|--chart-version)
      CHART_VERSION="$2"; shift 2;;
    --)
      shift; break;;
    *)
      echo "Invalid argument: $1" >&2; exit 1;;
  esac
done

# Check if required arguments are present
if [[ -z "$REPOSITORY" ]]; then
  echo "Repository argument is missing." >&2
  exit 1
fi
if [[ -z "$CHART_NAME" ]]; then
  echo "Chart name argument is missing." >&2
  exit 1
fi
if [[ -z "$NAMESPACE" ]]; then
  echo "Namespace argument is missing." >&2
  exit 1
fi
if [[ -z "$CHART_VERSION" ]]; then
  echo "Chart version argument is missing." >&2
  exit 1
fi

# Create the Helm chart
helm create $CHART_NAME

helm upgrade --install $CHART_NAME $CHART_NAME \
    --set image.repository=$REPOSITORY \
    --set image.tag=$CHART_VERSION \
    --namespace $NAMESPACE