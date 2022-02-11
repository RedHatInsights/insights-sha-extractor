---
layout: page
nav_order: 5
---
# Local setup

There is a `docker-compose` configuration that provisions a minimal stack of
Insight Platform and a postgres database. You can download it here
https://gitlab.cee.redhat.com/insights-qe/iqe-ccx-plugin/blob/master/docker-compose.yml

## Prerequisites

* minio requires `../minio/data/` and `../minio/config` directories to be created
* edit localhost line in your `/etc/hosts`:  `127.0.0.1       localhost kafka minio`
* `ingress` image should present on your machine. You can build it locally from
  this repo https://github.com/RedHatInsights/insights-ingress-go
  
## Usage

1. Start the stack `podman-compose up` or `docker-compose up`
2. Wait until kafka will be up.
3. Start `insights-sha-extractor`: `insights-sha-extractor config-devel.yaml`

Stop Minimal Insights Platform stack `podman-compose down` or `docker-compose down`

In order to upload an insights archive, you can use `curl`:

```
curl -k -vvvv -F "upload=@/path/to/your/archive.zip;type=application/vnd.redhat.testareno.archive+zip" http://localhost:3000/api/ingress/v1/upload -H "x-rh-identity: eyJpZGVudGl0eSI6IHsiYWNjb3VudF9udW1iZXIiOiAiMDAwMDAwMSIsICJpbnRlcm5hbCI6IHsib3JnX2lkIjogIjEifX19Cg=="
```

or you can use integration tests suite. More details are
[here](https://gitlab.cee.redhat.com/insights-qe/iqe-ccx-plugin).


## Logstash configuration

In order to provide a local **LogStash** service than can be used for local
testing, please follow the next steps:

1. Clone repository https://github.com/deviantony/docker-elk
2. Start the LogStash instance with `docker-compose up` in it's directory.

Don't forget to use the latest docker version(fedora repository doesn't have the latest version).
