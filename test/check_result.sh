#!/bin/bash

while true; do
    POD_STATUS=$(kubectl get pod -o jsonpath='{.items[0].status.phase}')
    case "$POD_STATUS" in
        Pending)
            echo "Waiting for pod to be running. Current status: $POD_STATUS"
            sleep 5
            ;;
        Running)
            echo "Pod is now running. Status: $POD_STATUS"
            exit 0
            ;;
        *)
            echo "Error: Pod status is $POD_STATUS"
            exit 1
            ;;
    esac
done