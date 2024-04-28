# Browser Window Manager

There is a docker container with the `xeyes` app installed.

The goal is to be able to export the display in that container to
an X server running in another container that will somehow forward the
display of the `xeyes` app to an application running in a web browser.
And we'd want `xeyes` to actually work there ... ie respond to mouse
events in the browser.

Note that the selkies project has an example of installing and starting
Xorg in a docker container here:

https://github.com/selkies-project/docker-nvidia-glx-desktop

See the Dockerfile for install stuff and `entrypoint.sh` for how to start Xorg.

We did it using VNC!

The `xserver` docker container starts `Xvfb` and `X11vnc` as well as a window
manager `fluxbox`. We then run this container as a 'sidecar' to the `xeyes` container
via docker compose. Once everything starts in the `xserver` container, we
can just set the DISPLAY environment variable in the xeyes container and
start up `xeyes` as expected.

So the analogy here is that the `xeyes` container is our 'dev container' and
the `xserver` container is the service that has all the tools needed to run some
kind of X server and send the display out to remote clients. We can run these
together in the same network and then all the dev container needs to do is
set the DISPLAY environment variable -- everything else is handled by a
separate container.

So now we should just be able to iterate on that separate container ...
changing how the streaming is done and how remote clients connect to it. Eventually
we want to use a web browser to connect, so there's nothing special to install on
the client machine. And we have a hypothesis that we should use QUIC and do some
custom streaming to provide even lower latency.

## Running

There are two ways to demo this: docker-compose and kubernetes, via kind.

### Docker Compose

```
$ docker-compose up
```

### Kind

To create the cluster:

```
$ ./kinds/start-cluster.sh
```