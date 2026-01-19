FROM registry.access.redhat.com/ubi9/ubi-minimal:9.7-1768783948

ENV CONFIG_PATH=/sha-extractor/config.yaml \
    VENV=/sha-extractor-venv \
    HOME=/sha-extractor \
    LC_ALL=C.utf8 \
    LANG=C.utf8

WORKDIR $HOME

ENV PATH="$VENV/bin:$PATH"

COPY . $HOME

RUN microdnf install --nodocs -y python312 python3.12-pip python3.12-devel unzip tar git-core && \
    python3.12 -m venv $VENV && \
    pip install --no-cache-dir -U pip setuptools && \
    pip install --no-cache-dir --upgrade poetry~=2.0 poetry-plugin-export && \
    poetry config virtualenvs.create false && \
    poetry export --only main -f requirements.txt --output requirements.txt && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -f requirements.txt && \
    microdnf remove -y git-core && \
    microdnf clean all && \
    rpm -e --nodeps sqlite-libs krb5-libs libxml2 readline pam openssh openssh-clients && \
    chmod -R g=u $HOME $VENV /etc/passwd && \
    chgrp -R 0 $HOME $VENV


USER 1001

CMD ["sh", "-c", "ccx-messaging $CONFIG_PATH"]
