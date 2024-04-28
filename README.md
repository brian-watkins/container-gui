# VNC from container

Suppose that you have a 'dev container' that you want to develop in and
sometimes (or maybe all the time) you want to export the display from that
container so you can see and interact with GUI apps.

This repo shows an example of exporting the display of a dev container
to an X server running in another "sidecar" container. This container
will use Xvfb as the X server and allow remote connections via VNC using
X11vnc. Clients connect via a web browser using novnc.

All that's needed in the dev container is to set the DISPLAY environment
variable to `:1`.

## Building

First build the images:

```
$ cd xeyes
$ docker build -t xeyes:fun .
```

```
$ cd xserver
$ docker build -t xserver:fun .
```

## Running

There are two ways to demo this: docker-compose and kubernetes, via kind.

### Docker Compose

```
$ docker-compose up
```

Then visit `http://localhost:8888/vnc.html` in your browser to connect.

### Kind

To create the cluster:

```
$ cd kind
$ ./start-cluster.sh
```

Then visit `http://localhost:8888/vnc/vnc.html` in your browser to connect.