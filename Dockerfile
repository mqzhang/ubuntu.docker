FROM ubuntu:22.04

USER root
SHELL ["/bin/bash", "-c"]
WORKDIR /tmp
COPY . .
RUN sh init.sh

EXPOSE 3000
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
CMD ruby -run -ehttpd . -p3000