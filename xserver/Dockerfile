FROM ubuntu:jammy

RUN apt-get update && apt-get install -y \
  netcat \
  xvfb \
  x11vnc \
  fluxbox

RUN apt-get install -y x11-apps

COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod 755 /etc/entrypoint.sh

ENTRYPOINT [ "/etc/entrypoint.sh" ]