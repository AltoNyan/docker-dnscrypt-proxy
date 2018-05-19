# Docker DNSCrypt-Proxy on Alpine-linux.

Simple, Light, Customizable dnscrypt-proxy docker container.


# Usage

Start the container without build image (Pull image from docker-hub):

	docker run -d -p 0.0.0.0:53:53/udp alotnyan/dnscrypt-proxy

or

Build the image:

	docker build -t dnscrypt-proxy .

Start the container with image:

	docker run -d -p 0.0.0.0:53:53/udp dnscrypt-proxy
