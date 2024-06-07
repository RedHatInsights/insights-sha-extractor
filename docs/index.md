# Description

Insights SHA Extractor service intends to retrieve Insights gathered archives
and export SHAs of images found in the archive. SHAs of images are published
back in order to be consumed by other services. Insights SHA Extractor is based
on Insights Core Messaging framework.

## Dataflow

1.  A customer cluster with *Insights Operator* installed sends new data containing info about the
    cluster into *Ingress service*
2.  The *Ingress service* consumes the data, writes them into an S3 Bucket, and produces a new
    message into a Kafka topic named <span class="title-ref">platform.upload.buckit</span>.
3.  The *SHA Image extractor* service consumes the message from the <span
    class="title-ref">platform.upload.buckit</span> Kafka topic.
4.  That message represents an event that contains (among other things) an URL to S3 Bucket.
5.  Insights operator data is read from S3 Bucket and extracted by <span
    class="title-ref">sha-image-extractor</span> service.
6.  If the file <span class="title-ref">config/workload_info.json</span> is found, it is read and
    deserialized
7.  Results (basically <span class="title-ref">organization ID</span> + <span
    class="title-ref">cluster name</span> + deserialized <span
    class="title-ref">workload_info.json</span>) are stored back into Kafka, but into different
    topic named <span class="title-ref">archive.results</span>.
8.  That results are consumed later by Vulnerability service.

### Remarks

1.  Steps 1 to 4 are shared with the CCX Data pipeline
2.  Step 8 is performed by service owned by the OCP Vulnerability team

## Integration with other services

Please look at [CCX Docs/Customer
Services](https://ccx.pages.redhat.com/ccx-docs/) for
an explanation how the CCX Data Pipeline is connected with other services.
