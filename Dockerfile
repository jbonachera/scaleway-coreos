FROM scaleway/cli as scw
FROM alpine as transpiler
RUN apk -U add curl && rm -rf /var/cache/apk/*
ENV VERSION=v0.9.0
ENV URL=https://github.com/coreos/container-linux-config-transpiler/releases/download/${VERSION}/ct-${VERSION}-x86_64-unknown-linux-gnu
RUN curl -sLo /usr/bin/container-linux-config-transpiler $URL && \
    chmod +x /usr/bin/container-linux-config-transpiler

FROM golang:alpine as builder
# build packer until https://github.com/hashicorp/packer/issues/6232 is released
RUN apk -U add git && rm -rf /var/cache/apk/*
RUN go get github.com/hashicorp/packer
RUN cp $GOPATH/bin/packer /bin/packer


FROM hashicorp/packer
WORKDIR /usr/local/src/app
COPY --from=scw /bin/scw /usr/bin/scw
COPY --from=builder /bin/packer /bin/packer
COPY --from=transpiler /usr/bin/container-linux-config-transpiler /usr/bin/container-linux-config-transpiler
COPY packer.json .
COPY config.yaml .
COPY prepare-os.sh .
COPY entrypoint /bin/entrypoint
ENV CHECKPOINT_DISABLE=1
ENTRYPOINT ["/bin/entrypoint"]
