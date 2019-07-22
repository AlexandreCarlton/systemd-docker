FROM archlinux/base:latest

RUN pacman \
      --noconfirm \
      --refresh \
      --sync \
      --sysupgrade && \
    pacman \
      --noconfirm \
      --sync \
      systemd \
      systemd-sysvcompat

# USER does not appear to be set properly, yet aura uses this to determine if the user is 'root' (if it is not invoked with sudo).
# systemd likes to know whether it is running in a container, so we set 'container' accordingly.
ENV USER=root \
    container=docker

CMD ["/sbin/init"]

ARG build_date
ARG name
ARG vcs_url
ARG vcs_ref
ARG docker_cmd
ARG docker_cmd_debug
LABEL maintainer="Alexandre Carlton" \
      org.label-schema.build-date="${build_date}" \
      org.label-schema.name="${name}" \
      org.label-schema.description="systemd inside an Arch Linux container." \
      org.label-schema.vcs-url="${vcs_url}" \
      org.label-schema.vcs-ref="${vcs_ref}" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.docker.cmd="${docker_cmd}" \
      org.label-schema.docker.cmd.debug="${docker_cmd_debug}"
