FROM registry.access.redhat.com/ubi9/ubi-minimal:9.7-1764794109

ENV CONFIG_PATH=/sha-extractor/config.yaml \
    VENV=/sha-extractor-venv \
    HOME=/sha-extractor

WORKDIR $HOME

COPY . $HOME

ENV PATH="$VENV/bin:$PATH" \
    PIP_CONSTRAINT=$HOME/constraints.txt

RUN microdnf install --nodocs -y python3.11 unzip tar git-core && \
    python3.11 -m venv $VENV && \
    pip install --no-cache-dir -U pip setuptools && \
    pip install --no-cache-dir . && \
    microdnf remove -y git-core && \
    microdnf clean all && \
    rpm -e --nodeps sqlite-libs krb5-libs libxml2 readline pam openssh openssh-clients && \
    chmod -R g=u $HOME $VENV /etc/passwd && \
    chgrp -R 0 $HOME $VENV


USER 1001

CMD ["sh", "-c", "ccx-messaging $CONFIG_PATH"]
