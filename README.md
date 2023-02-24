# aws-eks-helm-deploy

``` bash
docker build \
  --build-arg AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY \
  --build-arg AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY \
  --build-arg AWS_DEFAULT_REGION=YOUR_DEFAULT_REGION \
  --build-arg KUBECONFIG_FILE_S3_URL=YOUR_S3_URL \
  -t my-image-name \
  .
```