package k8srekorverify

test_container_violation_no_tag {
    count(violation) != 0 with input as { "review": { "object" : {"spec": { "containers": [{ "image":"busybox" }] } } }, "parameters": {"rekorServerURL": "http://rekor-server-tssc-demo-rekor.apps.cluster-97a2.97a2.sandbox20.opentlc.com/" } }
}

test_container_violation_wrong_tag {
    count(violation) != 0 with input as { "review": { "object" : {"spec": { "containers": [{ "image":"busybox:latest" }] } } }, "parameters": {"rekorServerURL": "http://rekor-server-tssc-demo-rekor.apps.cluster-97a2.97a2.sandbox20.opentlc.com/" } }
}

test_container_allowed {
    count(violation) == 0 with input as { "review": { "object" : {"spec": { "containers": [{ "image":"busybox:e635f03f4e74caba5429770331e11bf3b7a832f822b88be18b8787053d36493d"}] } } }, "parameters": {"rekorServerURL": "http://rekor-server-tssc-demo-rekor.apps.cluster-97a2.97a2.sandbox20.opentlc.com/" } }
}
