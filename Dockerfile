FROM phusion/baseimage:0.9.10
MAINTAINER Brad Daily <brad@koken.me>

ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update
RUN apt-get -y upgrade

# Basic Requirements
RUN apt-get -y install haproxy inotify-tools
ADD ./haproxy/haproxy.cfg.tmpl /etc/haproxy/haproxy.cfg

RUN mkdir -p /etc/service/haproxy
ADD ./services/haproxy /etc/service/haproxy/run
RUN chmod +x /etc/service/haproxy/run

RUN mkdir -p /etc/service/watcher
ADD ./services/watcher /etc/service/watcher/run
RUN chmod +x /etc/service/watcher/run

VOLUME ["/etc/haproxy"]

# private expose
EXPOSE 8080