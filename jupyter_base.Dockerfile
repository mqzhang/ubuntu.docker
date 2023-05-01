# base image from Jupyter Docker Stacks: https://jupyter-docker-stacks.readthedocs.io/en/latest/
# https://github.com/jupyter/docker-stacks/blob/main/base-notebook/Dockerfile
FROM jupyter/base-notebook:ubuntu-22.04

USER root
SHELL ["/bin/bash", "-c"]
WORKDIR /tmp
COPY . .
RUN sh init.sh

# EXPOSE 3000
# EXPOSE 8000
EXPOSE 8888
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
# CMD ruby -run -ehttpd . -p8000

# HEALTHCHECK documentation: https://docs.docker.com/engine/reference/builder/#healthcheck
# This healtcheck works well for `lab`, `notebook`, `nbclassic`, `server` and `retro` jupyter commands
# https://github.com/jupyter/docker-stacks/issues/915#issuecomment-1068528799
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \
    CMD /etc/jupyter/docker_healthcheck.py || exit 1