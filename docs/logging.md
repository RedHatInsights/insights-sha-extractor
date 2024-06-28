---
layout: page
nav_order: 5
---
# Logging

The log format is highly configurable through the configuration file. By
default, using the [provided
configuration](https://github.com/RedHatInsights/insights-sha-extractor/blob/master/config.yaml),
each log message will produce a JSON dictionary with the following structure:

```json
{
  "levelname": "LOG_LEVEL",
  "asctime": "timestamp",
  "name": "Python module",
  "filename": "filename",
  "message": "Message content"
}
```

By default, this log messages will be printed in the standard output. To change
this behaviour, refer to the `logging` section in the [configuration
file](https://github.com/RedHatInsights/insights-sha-extractor/blob/master/config.yaml),
the [Python Logging
HOWTO](https://docs.python.org/3.6/howto/logging.html#configuring-logging) and
the [Python logging
reference](https://docs.python.org/3.6/library/logging.config.html#module-logging.config).

## Logging to Cloud Watch

Cloud Watch is a service to enable log message publication. In
`insights-sha-extractor` it is done using `boto3` and `watchtower` Python packages.

In addition to the whole Python logging facilities, this service includes some
additional tooling in order to help configuring the logging system to send its
messages to a **Cloud Watch** instance.

Please, refer to [Cloud Watch
configuration](./configuration.html#cloud-watch-configuration) section to get
further info.
