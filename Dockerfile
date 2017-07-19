#
# Haproxy Dockerfile
#
# https://github.com/dockerfile/haproxy
#

# Pull base image.
FROM ubuntu:14.04

# Install Haproxy.
RUN sed -i 's/^# \(.*-backports\s\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y haproxy=1.4.24-2ubuntu0.4
RUN sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy && rm -rf /var/lib/apt/lists/*

# Add files.
ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD start.bash /haproxy-start

# Define mountable directories.
VOLUME ["/haproxy-override"]

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["bash", "/haproxy-start"]

# Expose ports.
EXPOSE 80
EXPOSE 443
