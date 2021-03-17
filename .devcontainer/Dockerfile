FROM quay.io/mhildenb/tssc-demo-base:latest

USER root

RUN pip3 install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple ploigos-step-runner

ENV PATH="$PATH:/usr/local/kubebuilder/bin:/usr/local/kubebuilder/bin:/usr/local/go/bin"
ENV GOPATH=/home/jboss/che

USER jboss

RUN go get -v golang.org/x/tools/gopls honnef.co/go/tools/cmd/staticcheck github.com/uudashr/gopkgs/v2/cmd/gopkgs \
    github.com/ramya-rao-a/go-outline github.com/go-delve/delve/cmd/dlv golang.org/x/lint/golint

