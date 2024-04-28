To run this container:

```
$ docker build -t xserver .
$ docker run -it --rm -p 5900:5900 xserver
```

That is, run the docker container and expose port 5900 for vnc access.
Then you should be able to connect via mac screen sharing at `localhost:5900`.

Note that we could use `supervisord` to run multiple processes too. See
[here](https://docs.docker.com/config/containers/multi-service_container/)
for an example config.