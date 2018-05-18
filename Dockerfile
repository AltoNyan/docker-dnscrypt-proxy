MAINTAINER Alto <alto@pendragon.kr>

# Smallest base image
FROM alpine:latest

# Select servers
ENV SERVER_NAMES="cloudflare, google"

# Enable & Disable protocols
ENV PROTO_DNSCRYPT="true"
ENV PROTO_DOH="true"

# Check ( DNSSEC & No-logging & No-filter ) option of dns-resolver
ENV REQUIRE_DNSSEC="false"
ENV REQUIRE_NOLOG="true"
ENV REQUIRE_NOFILTER="true"

# Fallback DNS server
ENV FALLBACK_RESOLVER=1.1.1.1:53

# Default nothing to build latest version.
ENV VERSION=''

COPY /rootfs /

RUN set -ex \
    && apk --no-cache --no-progress --update upgrade \
    && apk --no-cache --no-progress add tini ca-certificates\
    && apk --no-cache --no-progress --virtual .build-deps add git go musl-dev \

    # Create working dir from home.
    && mkdir $HOME/dnscrypt-proxy \
    && cd $HOME/dnscrypt-proxy \

    # Clone dnscrypt-proxy repo
    && git clone -b ${VERSION:-master} https://github.com/jedisct1/dnscrypt-proxy src \

    # Set environment variables
    && export GOPATH=$PWD \
    && export GOOS=linux \
    && export GOARCH=amd64 \

    # Build
    && cd src/dnscrypt-proxy \
    && go clean \
    && go build -ldflags="-s -w" -o $GOPATH/dnscrypt-proxy \

    # Set permission & Copy example-config
    && cd $GOPATH \
    && chmod +x dnscrypt-proxy \
    && cp $GOPATH/src/dnscrypt-proxy/example-* $GOPATH \

    # Clean src & build-dependencies
    && rm -rf $GOPATH/src \
    && apk del .build-deps \

    # Move dnscrypt-proxy to /app
    && mv $GOPATH /app \

    # Set permission to entrypoint
    && chmod +x /entrypoint.sh

WORKDIR /app

EXPOSE 53

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]