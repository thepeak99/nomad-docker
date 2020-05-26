FROM alpine:3.11

ENV NOMAD_VERSION=0.11.2

RUN apk update \
 && apk add -t build go make musl-dev bash linux-headers git tzdata \
 && apk add ca-certificates \
 && export GOPATH=/go \
 && PATH=$PATH:/go/bin \
 && go get -u github.com/kardianos/govendor \
 && mkdir -p /go/src/github.com/hashicorp/ \
 && cd /go/src/github.com/hashicorp/ \
 && echo "Cloning into 'nomad'..." \
 && git clone -b v$NOMAD_VERSION --depth 1 https://github.com/hashicorp/nomad.git 2> /dev/null \
 && cd nomad \
 # See https://github.com/hashicorp/nomad/issues/6433 \
 && govendor fetch golang.org/x/net/http2 \
 && make GO_TAGS="ui nonvidia" pkg/linux_amd64/nomad \
 && mv /go/src/github.com/hashicorp/nomad/pkg/linux_amd64/nomad /usr/bin/ \
 && rm -rf /go /root/.cache \
 && apk del build 

ENTRYPOINT ["nomad"]
