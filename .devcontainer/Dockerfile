FROM quay.io/mhildenb/tssc-demo-base:latest

USER root


ENV GOPATH=/home/jboss/che
ENV PATH="$PATH:/usr/local/kubebuilder/bin:/usr/local/kubebuilder/bin:/usr/local/go/bin:$GOPATH/bin"

USER jboss

RUN go get -v golang.org/x/tools/gopls honnef.co/go/tools/cmd/staticcheck github.com/uudashr/gopkgs/v2/cmd/gopkgs \
    github.com/ramya-rao-a/go-outline github.com/go-delve/delve/cmd/dlv golang.org/x/lint/golint

