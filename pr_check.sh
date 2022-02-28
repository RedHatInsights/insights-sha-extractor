#!/bin/bash

# --------------------------------------------
# Options that must be configured by app owner
# --------------------------------------------
export APP_NAME="ccx-data-pipeline"  # name of app-sre "application" folder this component lives in
export COMPONENT_NAME="ccx-sha-extractor"
export IMAGE="quay.io/cloudservices/ccx-sha-extractor"

export IQE_PLUGINS="ccx"
export IQE_MARKER_EXPRESSION="smoke" # ccx_data_pipeline_smoke does not exits (at least yet) as marker in the plugin
export IQE_FILTER_EXPRESSION=""
export IQE_CJI_TIMEOUT="30m"

# Install bonfire repo/initialize
CICD_URL=https://raw.githubusercontent.com/RedHatInsights/bonfire/master/cicd
curl -s $CICD_URL/bootstrap.sh > .cicd_bootstrap.sh && source .cicd_bootstrap.sh

# Build the image and push to quay
source $CICD_ROOT/build.sh

# Run the unit tests with an ephemeral db
# source $APP_ROOT/unit_test.sh

# Deploy rbac to an ephemeral namespace for testing
source $CICD_ROOT/deploy_ephemeral_env.sh

# Run smoke tests with ClowdJobInvocation
source $CICD_ROOT/cji_smoke_test.sh
