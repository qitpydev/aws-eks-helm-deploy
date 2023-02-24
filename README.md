# aws-eks-helm-deploy
this tool using for CI/CD, you can make deploying an Pod to Kubernetes quickly
__Quick run:__
``` bash
docker run -it \                        
  -e AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY_ID> \
  -e AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY> \
  -e AWS_DEFAULT_REGION=<YOUR_AWS_DEFAULT_REGION> \
  -e KUBECONFIG_FILE_S3_URL=s3://<YOUR_BUCKET>/<folder>/<kubeconfig-file> \
  -e EKS_CHART_NAME=<YOUR_CHART_NAME> \
  -e EKS_IMAGE_REPOSITORY=<YOUR_IMAGE_REPOSITORY> \
  -e EKS_CHART_VERSION=<YOUR_CHART_VERSION> \
  -e EKS_NAMESPACE=<YOUR_CHART_NAMESPACE> \
  qitpy/aws-eks-helm-deploy
```

__Example:__
``` bash
docker run -it \                        
  -e AWS_ACCESS_KEY_ID=2pf8F1tZMhbIuFfclVGz \
  -e AWS_SECRET_ACCESS_KEY=bUbFefyoaf4Fq8V8AIIV/gVrbL8i0uxl9hRd2Xqrp \
  -e AWS_DEFAULT_REGION=ap-southeast-1 \
  -e KUBECONFIG_FILE_S3_URL=s3://my-public-bucket/files/kubeconfig-file \
  -e EKS_CHART_NAME=my-chart-name \
  -e EKS_IMAGE_REPOSITORY=helloword \
  -e EKS_CHART_VERSION=1 \
  -e EKS_NAMESPACE=default \
  qitpy/aws-eks-helm-deploy
```

---  

__variables required:__
AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY_ID>
AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY>
AWS_DEFAULT_REGION=<YOUR_AWS_DEFAULT_REGION>

KUBECONFIG_FILE_S3_URL=s3://<YOUR_BUCKET>/<folder>/<kubeconfig-file>
EKS_CHART_NAME=<YOUR_CHART_NAME>
EKS_IMAGE_REPOSITORY=<YOUR_IMAGE_REPOSITORY>
EKS_CHART_VERSION=<YOUR_CHART_VERSION>
EKS_NAMESPACE=<YOUR_CHART_NAMESPACE>

---  

__importance note:__

- this tool require S3 Bucket to hold kubeconfig file, that mean you need to add your kubeconfig file to your S3 Bucket before using this tool
- your AWS credential need at least AmazonS3ReadOnlyAccess
- ensure that your cluster-namespace has ready existed