#!/bin/bash

export DEMO_HOME=$( cd "$(dirname "$0")/.." ; pwd -P )
export PATH="${PATH}:${DEMO_HOME}/bin"

# attempt to set the server to use for rekor (rekor cli uses viper and automaticenv which means all command line flags such as
# --rekor_server can be read as REKOR_REKOR_SERVER.  See here: https://github.com/spf13/viper)
REKOR_HOST="$(oc get route rekor-server -n tssc-demo-rekor -o jsonpath='{.spec.host}')"
if [[ -n "${REKOR_HOST}" ]]; then
    echo "Exporting REKOR_SERVER for use with rekor cli commands (rekor host is: ${REKOR_HOST}"
    export REKOR_REKOR_SERVER="http://${REKOR_HOST}"
else
    echo "Could not find REKOR host"
fi
