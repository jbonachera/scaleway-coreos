FROM alpine as transpiler
RUN apk -U add curl && rm -rf /var/cache/apk/*
ENV VERSION=v0.9.0
ENV URL=https://github.com/coreos/container-linux-config-transpiler/releases/download/${VERSION}/ct-${VERSION}-x86_64-unknown-linux-gnu
RUN curl -sLo /usr/bin/container-linux-config-transpiler $URL && \
    chmod +x /usr/bin/container-linux-config-transpiler

FROM hashicorp/packer:light as builder

FROM alpine
WORKDIR /usr/local/src/app
RUN apk -U add ca-certificates && rm -rf /var/cache/apk/*
COPY --from=builder /bin/packer /bin/packer
COPY --from=transpiler /usr/bin/container-linux-config-transpiler /usr/bin/container-linux-config-transpiler
COPY packer.json .
COPY config.yaml .
COPY prepare-os.sh .
COPY entrypoint /bin/entrypoint
ENV CHECKPOINT_DISABLE=1
ENTRYPOINT ["/bin/entrypoint"]
