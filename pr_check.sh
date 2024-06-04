#!/bin/bash
# Copyright 2024 Red Hat, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -exv

# --------------------------------------------
# Options that must be configured by app owner
# --------------------------------------------
APP_NAME="ocp-vulnerability"  # name of app-sre "application" folder this component lives in
REF_ENV="insights-stage"
COMPONENT_NAME="sha-extractor"
IMAGE="quay.io/cloudservices/sha-extractor"
COMPONENTS="sha-extractor"  # space-separated list of components to laod
COMPONENTS_W_RESOURCES="sha-extractor"  # component to keep
CACHE_FROM_LATEST_IMAGE="true"
DEPLOY_FRONTENDS="false"

export IQE_PLUGINS="ocp_vulnerability"
export IQE_MARKER_EXPRESSION=""
export IQE_FILTER_EXPRESSION="test_plugin_accessible"
export IQE_REQUIREMENTS_PRIORITY=""
export IQE_TEST_IMPORTANCE=""
export IQE_CJI_TIMEOUT="30m"
export IQE_ENV="ephemeral"


function build_image() {
    source $CICD_ROOT/build.sh
}

function deploy_ephemeral() {
    source $CICD_ROOT/deploy_ephemeral_env.sh
}

function run_smoke_tests() {
    # component name needs to be re-export to match ClowdApp name (as bonfire requires for this)
    # export COMPONENT_NAME="sha-extractor"
    # source $CICD_ROOT/cji_smoke_test.sh
    echo "To be implemented"
}


# Install bonfire repo/initialize
CICD_URL=https://raw.githubusercontent.com/RedHatInsights/bonfire/master/cicd
curl -s $CICD_URL/bootstrap.sh > .cicd_bootstrap.sh && source .cicd_bootstrap.sh
echo "creating PR image"
build_image

echo "deploying to ephemeral"
deploy_ephemeral

echo "running PR smoke tests"
run_smoke_tests

# Temporary stub
#mkdir -p artifacts
#TIMESTAMP=`date +%Y-%m-%dT%H:%M:%S.%N`
#echo '<?xml version="1.0" encoding="utf-8"?><testsuites><testsuite name="pytest" errors="0" failures="0" skipped="0" tests="1" time="0.000" timestamp="'${TIMESTAMP}'" hostname="'${HOST}'"><testcase classname="test" name="test_stub" time="0.000" /></testsuite></testsuites>' > artifacts/junit-stub.xml
