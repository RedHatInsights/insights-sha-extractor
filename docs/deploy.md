---
layout: page
nav_order: 8
---
# Deploy

`insights-sha-extractor` runs in [console.redhat.com](https://console.redhat.com) and
it's a part of the same testing and promoting routines. There are two
environments: STAGE and PROD. The code should pass tests in STAGE env before it
goes to PROD. Console.redhat.com team uses jenkins, OCP and
[ocdeployer](https://github.com/bsquizz/ocdeployer) for code deploying. All
deployment configs are stored in
