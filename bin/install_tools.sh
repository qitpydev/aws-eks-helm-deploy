apk add --update --no-cache curl ca-certificates tar
apk add --update openssl && \
    rm -rf /var/cache/apk/*
apk add aws-cli
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh