FROM runatlantis/atlantis:latest

LABEL maintainer="Alonso <alonso.parasxidis@gmail.com>"

ENV \
    LOCAL_DIR=/usr/local

ARG TERRAFORM_VERSION="0.14.2"
RUN set -ex \
    && apk add --no-cache --virtual .build-dependencies unzip \
    && curl -fSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /tmp \
    && rm -f ${LOCAL_DIR}/bin/terraform \
    && mv /tmp/terraform ${LOCAL_DIR}/bin/terraform \
    && rm -f /tmp/terraform* \
    && apk del .build-dependencies

ARG TERRAGRUNT_VERSION="v0.23.40"
RUN set -ex \
    && curl -fSL "https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64" \
        -o ${LOCAL_DIR}/bin/terragrunt \
    && chmod +x ${LOCAL_DIR}/bin/terragrunt