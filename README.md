# Nomad for Docker

This is a minimal image (based on Alpine Linux) that runs Nomad.

## Usage

It is recommended to run it with `--net host` and `--privileged` params, as Nomad is expecting to run that way. In principle, you can make it work without `--privileged` but that will require some work. It is also convenient to mount `/tmp` inside the container, as it expects a `tmpfs` filesystem mounted in `/tmp`.

For example to run it with Docker support:

    docker run -v /var/run/docker.sock:/var/run/docker.sock --rm --privileged --net host -v /tmp:/tmp thepeak/nomad
