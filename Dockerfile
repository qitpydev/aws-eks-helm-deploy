FROM alpine:3.17.2

# Installing AWS-CLI/Kubectl/Helm
COPY . /aws-eks-helm-deploy
WORKDIR /aws-eks-helm-deploy
RUN chmod +x ./bin/*
RUN chmod +x *.sh
RUN sh /bin/install_tools.sh

# Config AWS
ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV AWS_DEFAULT_REGION=""
ENV KUBECONFIG_FILE_S3_URL=""

# EKS ENV
ENV EKS_CHART_NAME=""
ENV EKS_IMAGE_REPOSITORY=""
ENV EKS_CHART_VERSION=""
ENV EKS_NAMESPACE=""
ENV EKS_CONTAINER_PORT=""


# Config kubectl
ENTRYPOINT ["sh", "run.sh"]
