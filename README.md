# Docker DNSCrypt-Proxy on Alpine-linux.

Simple, Light, Customizable dnscrypt-proxy docker container.


# Quick start
>### Pull from docker-hub:
>     docker run -d -p 0.0.0.0:53:53/udp \
>                   -p 0.0.0.0:53:53/tcp \ 
>                   alotnyan/dnscrypt-proxy:latest

### or

>### Build your own image:
>>##### - Default
>>     docker build -t dnscrypt-proxy .
>>##### - Custom Version ([DNSCrypt-Proxy](https://github.com/jedisct1/dnscrypt-proxy))
>>     docker build --build-arg VERSION='2.x.xx' \
>>                  -t dnscrypt-proxy .
>### Next. Start the container:
>     docker run -d -p 0.0.0.0:53:53/udp \
>                   -p 0.0.0.0:53:53/tcp \ 
>                   dnscrypt-proxy
> 


# Next Step
>### Run with custom environment variables:
>     docker run -d -p 0.0.0.0:53:53/udp \
>                   -p 0.0.0.0:53:53/tcp \ 
>                   -e 'SERVER_NAMES=cloudflare, google' \
>                   -e 'FALLBACK_RESOLVER=1.1.1.1:53'
>
>                   ...
>
>                   alotnyan/dnscrypt-proxy:latest



## Environment Variables
| Variable Name | Default-Value | Descriptions |
|:--------------|:-------------:|:-------------|
| SERVER_NAMES      | cloudflare, google    | You can choose servers from [public-resolvers](https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v2/public-resolvers.md). |
| PROTO_DNSCRYPT    | true                  | Enable using DNSCRYPT servers. |
| PROTO_DOH         | true                  | Enable using DNS-over-HTTPS servers. |
| REQUIRE_DNSSEC    | false                 | Require DNSSEC support on servers. |
| REQUIRE_NOLOG     | true                  | Only using No-Logging server. |
| REQUIRE_NOFILTER  | true                  | Only using none-filtering server. |
| FALLBACK_RESOLVER | 1.1.1.1:53            | Setup fallback resolver. <br> ex) \<ip-address\>:\<port\> |
| LISTEN_ADDRESSES  | 0.0.0.0:53            | Setup listen-addresses. <br> You can choose multiple addresses or port. <br> ex) 0.0.0.0:53, 0.0.0.0:54, ... |
| ENABLE_AUTO_CONFIG| true                  | Create and overwrite config file on every startup. <br> You must set this 'false', before customize setting file. |
| VERSION           | (None)                | You can choose DNSCrypt-Proxy version for **build process**. <br> Value is tag or branch name of [DNSCrypt-Proxy](https://github.com/jedisct1/dnscrypt-proxy) repository. <br> By default using master branch on none-value. ex) 2.0.14 |

