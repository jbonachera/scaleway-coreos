FROM alpine as plugin
RUN apk -U add curl && rm -rf /var/cache/apk/*
ENV VERSION=v0.0.3
ENV URL=https://github.com/jbonachera/packer-scaleway-plugin/releases/download/$VERSION/packer-builder-scaleway-volumesurrogate
RUN curl -sLo /usr/bin/packer-builder-scaleway-volumesurrogate $URL
RUN chmod +x /usr/bin/packer-builder-scaleway-volumesurrogate

FROM alpine as transpiler
RUN apk -U add curl && rm -rf /var/cache/apk/*
ENV VERSION=v0.9.0
ENV URL=https://github.com/coreos/container-linux-config-transpiler/releases/download/${VERSION}/ct-${VERSION}-x86_64-unknown-linux-gnu
RUN curl -sLo /usr/bin/container-linux-config-transpiler $URL && \
    chmod +x /usr/bin/container-linux-config-transpiler

FROM hashicorp/packer
COPY --from=plugin /usr/bin/packer-builder-scaleway-volumesurrogate packer-builder-scaleway-volumesurrogate
COPY --from=transpiler /usr/bin/container-linux-config-transpiler /usr/bin/container-linux-config-transpiler
COPY . .
ENV CHECKPOINT_DISABLE=1
ENTRYPOINT ["/entrypoint"]
