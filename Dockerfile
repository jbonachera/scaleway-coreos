FROM alpine as plugin
RUN apk -U add curl && rm -rf /var/cache/apk/*
ENV VERSION=v0.0.3
ENV URL=https://github.com/jbonachera/packer-scaleway-plugin/releases/download/$VERSION/packer-builder-scaleway-volumesurrogate
RUN curl -sLo /usr/bin/packer-builder-scaleway-volumesurrogate $URL
RUN chmod +x /usr/bin/packer-builder-scaleway-volumesurrogate

FROM hashicorp/packer
COPY --from=plugin /usr/bin/packer-builder-scaleway-volumesurrogate packer-builder-scaleway-volumesurrogate
COPY . .
ENV CHECKPOINT_DISABLE=1
ENTRYPOINT ["packer"]
