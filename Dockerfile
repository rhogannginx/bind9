FROM debian:stretch-slim

  RUN apt update 
  
  RUN apt install -y bind9 bind9utils

COPY local.zone /etc/bind
COPY reverse-192-168-1-0.zone /etc/bind
COPY reverse-10-10-60-0.zone /etc/bind
COPY named.conf.local /etc/bind
COPY named.conf.options /etc/bind

EXPOSE 53/udp 53/tcp

CMD ["/usr/sbin/named"]
