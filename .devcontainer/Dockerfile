# override this in devcontainer.json as necessary
ARG PLOIGOS_STEPRUNNER_IMAGE=quay.io/ploigos/ploigos-tool-containers:v0.16.0
FROM $PLOIGOS_STEPRUNNER_IMAGE as ploigos

FROM quay.io/mhildenb/tssc-demo-base:latest

USER root

COPY --from=ploigos /usr/local/lib/python3.6/site-packages /usr/local/lib/python3.6/site-packages
RUN rm -rf /usr/local/lib/python3.6/site-packages/ploigos_step_runner \
    && pip3 install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple pylint

ENV GOPATH=/home/jboss/che
ENV PATH="$PATH:/usr/local/kubebuilder/bin:/usr/local/kubebuilder/bin:/usr/local/go/bin:$GOPATH/bin"

USER jboss

RUN go get -v golang.org/x/tools/gopls honnef.co/go/tools/cmd/staticcheck github.com/uudashr/gopkgs/v2/cmd/gopkgs \
    github.com/ramya-rao-a/go-outline github.com/go-delve/delve/cmd/dlv golang.org/x/lint/golint

