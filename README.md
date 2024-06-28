# Insights SHA Extractor

[![Python 3.7](https://img.shields.io/badge/python-3.7-blue.svg)](https://www.python.org/downloads/release/python-370/)
[![GitHub Pages](https://img.shields.io/badge/%20-GitHub%20Pages-informational)](https://supreme-garbanzo-c43cccab.pages.github.io/)
[![License](https://img.shields.io/badge/license-Apache-blue)](https://github.com/RedHatInsights/insights-sha-extractor/-/blob/master/LICENSE)

<!-- vim-markdown-toc GFM -->

* [Description](#description)
* [Documentation](#documentation)
* [Makefile targets](#makefile-targets)
* [BDD tests](#bdd-tests)
* [Package manifest](#package-manifest)

<!-- vim-markdown-toc -->

## Description

Insights SHA Extractor service intends to retrieve Insights gathered archives
and export SHAs of images found in the archive. SHAs of images are published
back in order to be consumed by other services. Insights SHA Extractor is based
on Insights Core Messaging framework.

## Documentation

Documentation is hosted on Github Pages <https://supreme-garbanzo-c43cccab.pages.github.io/>.

## Makefile targets

```
Usage: make <OPTIONS> ... <TARGETS>

Available targets are:

unit_tests           Run unit tests
coverage             Run unit tests, display code coverage on terminal
coverage-report      Run unit tests, generate code coverage as a HTML report
documentation        Generate documentation for all sources
shellcheck           Run shellcheck
pycodestyle          Check code style of all Python sources
pydocstyle           Check docstrings style of all Python sources
pyformat-check       Check formatting of all Python sources
pyformat             Reformat all Python sources
help                 Show this help screen
```

## BDD tests

Behaviour tests for this service are included in [Insights Behavioral
Spec](https://github.com/RedHatInsights/insights-behavioral-spec) repository.
In order to run these tests, the following steps need to be made:

1. clone the [Insights Behavioral Spec](https://github.com/RedHatInsights/insights-behavioral-spec) repository
1. go into the cloned subdirectory `insights-behavioral-spec`
1. run the `aggregator_tests.sh` from this subdirectory

List of all test scenarios prepared for this service is available at
<https://redhatinsights.github.io/insights-behavioral-spec/feature_list.html#sha-extractor>


## Package manifest

Package manifest is available at [docs/manifest.txt](docs/manifest.txt).
