FROM ubuntu:22.04

# Set the timezone environment variable
ENV TZ=Asia/Shanghai

# Install the tzdata package and configure the timezone & ca-certificates
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata ca-certificates\
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

USER root
# SHELL ["/bin/bash", "-c"]
WORKDIR /tmp
COPY . .
RUN bash init.sh

EXPOSE 3000

# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
# CMD ruby -run -ehttpd . -p3000
# ENTRYPOINT ["/bin/bash"]

# Set the entrypoint to a command that does nothing
ENTRYPOINT ["tail", "-f", "/dev/null"]
