# Prometheus API

The project allows to expose some metrics to **Prometheus** if desired. To
enable it, you should add the
`ccx_messaging.watchers.stats_watcher.StatsWatcher` to the configuration
file, as shown in the [provided
one](https://gitlab.cee.redhat.com/ccx/ccx-sha-extractor/-/blob/master/config.yaml).

The exposed metrics are 6 counters and 3 histograms:

- `ccx_consumer_received_total`: a counter of the total amount of received
  messages from Kafka that can be handled by the pipeline.
- `ccx_downloaded_total`: total amount of handled messages that contains a valid
  and downloadable archive.
- `ccx_engine_processed_total`: total amount of archives processed by the engine.
- `ccx_published_total`: total amount of processed results that has been
  published to the outgoing Kafka topic.
- `ccx_failures_total`: total amount of individual events received but not
  properly processed by the pipeline. It can include failures due to an invalid
  URL for the archive, incorrect format of the downloaded archive, failure
  during the processing...
- `ccx_not_handled_total`: total amount of received records that cannot be
  handled by the pipeline, normally due to incompatible format or incorrect JSON
  schema.
- `ccx_download_duration_seconds`: histogram of the time that takes to download
  each archive.
- `ccx_process_duration_seconds`: histogram of the time that takes to process
  the archive after it has been downloaded.
- `ccx_publish_duration_seconds`: histogram of the time that takes to send the
  new record to the outgoing Kafka topic after the archive has been processed.
