FROM runatlantis/atlantis:latest

LABEL maintainer="Alonso <alonso.parasxidis@gmail.com>"

ENV LOCAL_DIR=/usr/local

ARG TERRAGRUNT_VERSION="v0.23.40"
RUN set -ex \
    && curl -fSL "https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64" \
        -o ${LOCAL_DIR}/bin/terragrunt \
    && chmod +x ${LOCAL_DIR}/bin/terragrunt

COPY --chown=atlantis:atlantis repos.yaml /home/atlantis/repos.yaml

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["server","--repo-config=home/atlantis/repos.yaml"]