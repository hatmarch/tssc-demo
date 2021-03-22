#!/bin/bash

set -euo pipefail

declare REKOR_PROJECT=tssc-demo-rekor

oc scale deploy/trillian-db --replicas 0 -n ${REKOR_PROJECT}
oc scale deploy/trillian-log --replicas 0 -n ${REKOR_PROJECT}
oc scale deploy/rekor-server --replicas 0 -n ${REKOR_PROJECT}

oc scale deploy/trillian-db --replicas 1 -n ${REKOR_PROJECT}
oc rollout status deploy/trillian-db -n ${REKOR_PROJECT}
oc scale deploy/trillian-log --replicas 1 -n ${REKOR_PROJECT}
oc rollout status deploy/trillian-log -n ${REKOR_PROJECT}
oc scale deploy/rekor-server --replicas 1 -n ${REKOR_PROJECT}
oc rollout status deploy/rekor-server -n ${REKOR_PROJECT}