FROM sameersbn/bind
COPY k8.local.zone /etc/bind
COPY named.conf.local /etc/bind
RUN /usr/sbin/named -c /etc/bind/named.conf -u bind
EXPOSE 53 10000
