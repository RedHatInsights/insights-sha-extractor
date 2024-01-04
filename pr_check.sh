#!/bin/bash

# --------------------------------------------
# Options that must be configured by app owner
# --------------------------------------------
APP_NAME="ccx-data-pipeline"  # name of app-sre "application" folder this component lives in
COMPONENT_NAME="ccx-sha-extractor"
IMAGE="quay.io/cloudservices/ccx-sha-extractor"
COMPONENTS="ccx-data-pipeline ccx-insights-results insights-content-service insights-results-smart-proxy ccx-sha-extractor"  # space-separated list of components to laod
COMPONENTS_W_RESOURCES="ccx-sha-extractor"  # component to keep
CACHE_FROM_LATEST_IMAGE="false"

export IQE_PLUGINS="ccx"
export IQE_MARKER_EXPRESSION="smoke" # ccx_data_pipeline_smoke does not exits (at least yet) as marker in the plugin
export IQE_FILTER_EXPRESSION=""
export IQE_REQUIREMENTS_PRIORITY=""
export IQE_TEST_IMPORTANCE=""
export IQE_CJI_TIMEOUT="30m"

# Temporary stub
mkdir -p artifacts
echo '<?xml version="1.0" encoding="utf-8"?><testsuites><testsuite name="pytest" errors="0" failures="0" skipped="0" tests="1" time="0.014" timestamp="2021-05-13T07:54:11.934144" hostname="thinkpad-t480s"><testcase classname="test" name="test_stub" time="0.000" /></testsuite></testsuites>' > artifacts/junit-stub.xml

# TODO: Uncomment when smoke tests are created

function build_image() {
    source $CICD_ROOT/build.sh
}

function deploy_ephemeral() {
    source $CICD_ROOT/deploy_ephemeral_env.sh
}

# function run_smoke_tests() {
#     # component name needs to be re-export to match ClowdApp name (as bonfire requires for this)
#     export COMPONENT_NAME="ccx-sha-extractor"
#     source $CICD_ROOT/cji_smoke_test.sh
# }


# Install bonfire repo/initialize
CICD_URL=https://raw.githubusercontent.com/RedHatInsights/bonfire/master/cicd
curl -s $CICD_URL/bootstrap.sh > .cicd_bootstrap.sh && source .cicd_bootstrap.sh
echo "creating PR image"
build_image

echo "deploying to ephemeral"
deploy_ephemeral

# echo "running PR smoke tests"
# run_smoke_tests
