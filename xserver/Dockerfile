FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  netcat \
  xvfb \
  x11vnc \
  fluxbox \
  novnc \
  python3-websockify \
  python3-numpy

COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod 755 /etc/entrypoint.sh

ENTRYPOINT [ "/etc/entrypoint.sh" ]