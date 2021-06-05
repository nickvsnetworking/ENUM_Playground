FROM ubuntu:bionic

RUN apt-get update \
  && apt-get install -y \
  bind9 bind9utils bind9-doc dnsutils \
  tcpdump

# Enable IPv4
RUN sed -i 's/OPTIONS=.*/OPTIONS="-4 -u bind"/' /etc/default/bind9

# Copy configuration files
COPY * /etc/bind/

#Set permissions
RUN chown bind:bind /etc/bind/*

#Expose port 53
EXPOSE 53/udp 53/tcp

#Run Service
CMD ["/usr/sbin/named", "-g", "-4", "-c", "/etc/bind/named.conf", "-u", "bind"]