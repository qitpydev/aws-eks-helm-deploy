FROM alpine:3.17.2

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION
ARG KUBECONFIG_FILE_S3_URL

# Installing AWS-CLI/Kubectl/Helm
COPY . .
RUN chmod +x /bin/*
RUN sh /bin/run_test.sh \
    --aws-access-key-id ${AWS_ACCESS_KEY_ID} \
    --aws-secret-access-key ${AWS_SECRET_ACCESS_KEY} \
    --aws-default-region ${AWS_DEFAULT_REGION}
RUN sh /bin/install_tools.sh

# Config AWS
RUN export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
RUN export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
RUN export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

# Config kubectl
RUN aws s3 cp ${KUBECONFIG_FILE_S3_URL} ~/.kube/config
