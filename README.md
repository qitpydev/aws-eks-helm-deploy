# aws-eks-helm-deploy  

This tool using for CI/CD, you can make deploying an Pod to Kubernetes quickly  

__Quick run:__
``` bash
docker run \                        
  -e AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY_ID> \
  -e AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY> \
  -e AWS_DEFAULT_REGION=<YOUR_AWS_DEFAULT_REGION> \
  -e KUBECONFIG_FILE_S3_URL=s3://<YOUR_BUCKET>/<folder>/<kubeconfig-file> \
  -e EKS_CHART_NAME=<YOUR_CHART_NAME> \
  -e EKS_CHART_VERSION=<YOUR_CHART_VERSION> \
  -e EKS_IMAGE_REPOSITORY=<YOUR_IMAGE_REPOSITORY> \
  -e EKS_CONTAINER_PORT=<YOUR_CONTAINER_PORT> \
  -e EKS_CONTAINER_HEALTH_CHECK_PATH=<YOUR_READINESS_LIVENESS_PORT> \
  -e EKS_NAMESPACE=<YOUR_CHART_NAMESPACE> \
  qitpy/aws-eks-helm-deploy
```

__Example:__
``` bash
docker run \                        
  -e AWS_ACCESS_KEY_ID=2pf8F1tZMhbIuFfclVGz \
  -e AWS_SECRET_ACCESS_KEY=bUbFefyoaf4Fq8V8AIIV/gVrbL8i0uxl9hRd2Xqrp \
  -e AWS_DEFAULT_REGION=ap-southeast-1 \
  -e KUBECONFIG_FILE_S3_URL=s3://my-public-bucket/files/kubeconfig-file \
  -e EKS_CHART_NAME=my-chart-name \
  -e EKS_IMAGE_REPOSITORY=helloword \
  -e EKS_CHART_VERSION=1 \
  -e EKS_CONTAINER_PORT=80 \
  -e EKS_CONTAINER_HEALTH_CHECK_PATH="/" \
  -e EKS_NAMESPACE=default \
  qitpy/aws-eks-helm-deploy
```

---  

__Variables REQUIRED (8):__  

| Field                        | Required/Optional | Default Value                  | Example Values                                |
| ---------------------------- | ----------------- | ------------------------------ | --------------------------------------------- |
| AWS_ACCESS_KEY_ID            | Required          | _                              | FAKE_ACCESS_KEY_ID                            |
| AWS_SECRET_ACCESS_KEY        | Required          | _                              | FAKE_SECRET_ACCESS_KEY                        |
| AWS_DEFAULT_REGION           | Required          | _                              | us-west-2                                    |
| KUBECONFIG_FILE_S3_URL       | Required          | _                              | s3://fake-bucket/fake-path/kubeconfig.yaml    |
| EKS_IMAGE_REPOSITORY         | Required          | _                              | fake-repo                                    |
| EKS_CHART_NAME               | Required          | _                              | fake-chart                                   |
| EKS_NAMESPACE                | Required          | _                              | fake-namespace                               |
| EKS_CHART_VERSION            | Optional          | latest                         | 1.0.0                                        |
| EKS_CONTAINER_PORT           | Optional          | 80                             | 8080                                         |
| EKS_CONTAINER_HEALTH_CHECK_PATH | Optional        | _                              | /health                                      |
| RESOURCE_LIMITS_CPU          | Optional          | Use Default                    | 2                                            |
| RESOURCE_LIMITS_MEMORY       | Optional          | Use Default                    | 4Gi                                          |
| RESOURCE_REQUEST_CPU         | Optional          | Use Default                    | 1                                            |
| RESOURCE_REQUEST_MEMORY      | Optional          | Use Default                    | 2Gi                                          |


---  

__Please, note:__

1. this tool require **S3 Bucket** to hold kubeconfig file, that mean you need to add your kubeconfig file to your S3 Bucket before using.
2. your AWS credential need at least **AmazonS3ReadOnlyAccess**.
3. ensure that your cluster-namespace has already existed.
