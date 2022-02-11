---
layout: page
nav_order: 1
---
# Architecture

This service is built on top of [insights-core-messaging
framework](https://github.com/RedHatInsights/insights-core-messaging) and will
be deployed and run inside [cloud.redhat.com](https://cloud.redhat.com).

## Component diagram

![component](./component-diagram-extractor.png)

## Sequence diagram

![sequence](./sequence-diagram-extractor.png)

## Integration into Vulnerability app

![diagram](./vulnerability-app-architecture.png)

## Whole data flow

![data_flow](./customer_facing_services_architecture.png)

1. Event about new data from insights operator is consumed from Kafka. That event contains (among other things) URL to S3 Bucket
2. If processing duration is configured, the service tries to process (see next steps) the event under the given amount of seconds
3. Insights operator data is read from S3 Bucket and insights rules are applied to that data
4. Extracted file `config/workload_info.json) + other metadata are stored back into Kafka, but into different topic
5. That results are consumed by Vulnerability app DB-writer service that caches them
6. The service provides such data via REST API to other tools, like OpenShift Cluster Manager web UI, OpenShift console, etc.

