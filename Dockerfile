FROM registry.access.redhat.com/ubi9-minimal:latest

ENV CONFIG_PATH=/insights-sha-extractor/config.yaml \
    VENV=/insights-sha-extractor-venv \
    HOME=/insights-sha-extractor \
    REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt

WORKDIR $HOME

COPY . $HOME

ENV PATH="$VENV/bin:$PATH" \
    PIP_CONSTRAINT=$HOME/constraints.txt

RUN microdnf install --nodocs -y python3.11 unzip tar git-core && \
    python3.11 -m venv $VENV && \
    curl -ksL https://certs.corp.redhat.com/certs/2015-IT-Root-CA.pem -o /etc/pki/ca-trust/source/anchors/RH-IT-Root-CA.crt && \
    curl -ksL https://certs.corp.redhat.com/certs/2022-IT-Root-CA.pem -o /etc/pki/ca-trust/source/anchors/2022-IT-Root-CA.pem && \
    update-ca-trust && \
    pip install --no-cache-dir -U pip setuptools && \
    pip install --no-cache-dir . && \
    microdnf remove -y git-core && \
    microdnf clean all && \
    rpm -e --nodeps sqlite-libs krb5-libs libxml2 readline pam openssh openssh-clients && \
    chmod -R g=u $HOME $VENV /etc/passwd && \
    chgrp -R 0 $HOME $VENV


USER 1001

CMD ["sh", "-c", "ccx-messaging $CONFIG_PATH"]
