# Docker DNSCrypt-Proxy on Alpine-linux.

Simple, Light, Customizable dnscrypt-proxy docker container.


# Quick start
>### Pull from docker-hub:
>     docker run -d -p 0.0.0.0:53:53/udp \
>                   -p 0.0.0.0:53:53/tcp \ 
>                   alotnyan/dnscrypt-proxy:latest

###or

>### Build your own image:
>     docker build -t dnscrypt-proxy .
>##### Start the container:
>     docker run -d -p 0.0.0.0:53:53/udp \
>                   -p 0.0.0.0:53:53/tcp \ 
>                   dnscrypt-proxy
> 


# Next Step


## Environment Variables
>####SERVER_NAMES =' cloudflare, google, ... '
>You can choose servers from [public-resolvers](https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v2/public-resolvers.md).

>####PROTO_DNSCRYPT ='TRUE/false'
>Enable DNSCRYPT protocol on true. 

>####PROTO_DOH='TRUE/false'
>Enable DNS-over-HTTPS protocol on true.

>####REQUIRE_DNSSEC='true/FALSE'
>Require DNSSEC support from servers.

>####REQUIRE_NOLOG='TRUE/false'
>Require No-Logging option from servers.

>####REQUIRE_NOFILTER='TRUE/false'
>Require No-Filtering option from servers.

>####FALLBACK_RESOLVER=address:port(53)
>Set fallback dns-resolver address.
>ex) ~=1.1.1.1:53

>####VERSION=''
>You can set version of DNSCrypt-proxy on build process by this variable.
>Version parameter is tag or branch name of [dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy) repository.