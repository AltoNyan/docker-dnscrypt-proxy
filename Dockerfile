# Using builder.
FROM golang:alpine as builder

ARG GOOS
ARG GOARCH
ARG VERSION

RUN set -ex \
    && apk --update add git \

    # Clone dnscrypt-proxy repo
    && git clone -b ${VERSION:-master} https://github.com/jedisct1/dnscrypt-proxy src ; \

    # Set go env-variables.
    && export GOOS=${GOOS:-linux} \
    && export GOARCH=${GOARCH:-amd64} \

    # Build
    && cd src/dnscrypt-proxy \
    && go clean ; \
    && go build -ldflags="-s -w" -o /go/app/dnscrypt-proxy
    && cp /go/src/dnscrypt-proxy/example-* /go/app

# Smallest base image
FROM alpine:latest

MAINTAINER Alto <alto@pendragon.kr>

    # Select servers
ENV SERVER_NAMES='cloudflare, google' \

    # Enable & Disable protocols
    PROTO_DNSCRYPT='true' \
    PROTO_DOH='true' \

    # Check ( DNSSEC & No-logging & No-filter ) option of dns-resolver
    REQUIRE_DNSSEC='false' \
    REQUIRE_NOLOG='true' \
    REQUIRE_NOFILTER='true' \

    # Fallback DNS server
    FALLBACK_RESOLVER=1.1.1.1:53 \

    # Listen addresses
    LISTEN_ADDRESSES=0.0.0.0:53 \

    # Disable auto-regenerate config file on boot.
    ENABLE_AUTO_CONFIG='true'

COPY /rootfs /
COPY --from=builder /go/app /app

VOLUME /data

RUN set -ex \
    && apk --no-cache --update add \
            tini \
            ca-certificates \
    && chmod +x /app/dnscrypt-proxy
    && chmod +x /entrypoint.sh

WORKDIR /app

EXPOSE 53/tcp 53/udp

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]