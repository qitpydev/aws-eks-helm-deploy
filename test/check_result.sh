POD_STATUS=""

while true; do
  POD_STATUS=$(kubectl get pod -l app=$POD_NAME -o jsonpath='{.items[0].status.phase}')
  if [[ $POD_STATUS == "Pending" || $POD_STATUS == "Running" ]]; then
    break
  fi
  echo "Waiting for pod to be running. Current status: $POD_STATUS"
  sleep 5
done

if [[ $POD_STATUS != "Pending" && $POD_STATUS != "Running" ]]; then
  echo "Error: Pod status is $POD_STATUS"
  exit 1
fi

echo "Pod is now running. Status: $POD_STATUS"