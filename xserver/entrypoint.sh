#!/bin/bash

echo "Welcome!"

export DISPLAY=:1

# Note that this is what selkies gstreamer uses to start xvfb ...
# RESOLUTION="8192x4096x24"
RESOLUTION="1024x768x16"

Xvfb ${DISPLAY} -screen 0 ${RESOLUTION} \
  +extension "COMPOSITE" \
  +extension "DAMAGE" \
  +extension "GLX" \
  +extension "RANDR" \
  +extension "RENDER" \
  +extension "MIT-SHM" \
  +extension "XFIXES" \
  +extension "XTEST" \
  +iglx \
  +render \
  -nolisten "tcp" \
  -noreset \
  -shmem >/tmp/Xvfb.log 2>&1 &

# Ensure the X server is ready
until [ -S "/tmp/.X11-unix/X${DISPLAY/:/}" ]; do sleep 1; done && echo 'X Server is ready'

x11vnc -display $DISPLAY \
  -passwd "1234" \
  -shared \
  -forever \
  -repeat \
  -xkb \
  -threads \
  -xrandr "resize" \
  -rfbport 5900 &

fluxbox &

# Start the websocket to serve vnc via novnc
websockify -D --web=/usr/share/novnc/ 6080 localhost:5900

wait -n