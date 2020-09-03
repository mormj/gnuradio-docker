# gnuradio-docker

The goal of this project is to be able to build and run GNU Radio under many different versions of
different distributions

1. For folks who want to easily run GNU Radio in a containerized environment
2. For testing GNU Radio builds on a host of distributions
3. For debugging things that happen on other distros than my own

Dockerfiles copy heavily from gnuradio-buildbot workers (https://github.com/gnuradio/gnuradio-buildbot)

## Setup and Build/Run

1. Install docker in your host environment https://docs.docker.com/get-docker/
2. Set up permissions https://docs.docker.com/engine/install/linux-postinstall/
3. Clone this repo
4. Checkout the branch that correspond to the dependencies of the desired gnuradio branch {master, maint-3.8, maint-3.7}
5. ./buildDocker.sh [distro] [version] {source,pkg}
6. ./startDocker.sh [distro] [version] {source,pkg}

where source indicates the docker image was built with gnuradio from source
and pkg indicates the docker image was built with gnuradio from the appropriate package manager


For example I may want to build and launch a docker with Ubuntu 20.04
```
./buildDocker ubuntu 20.04 source
... (wait for a while to build)
./startDocker ubuntu 20.04 source
./setup_env.sh
./gnuradio-companion &
```

## Structure of Dockerfiles

Each OS distribution has a directory, and each distro has a directory for the major versions

There is a base.Dockerfile to define the base image
There is a buildreqs.Dockerfile to define the minimum build requirements to build GR from source


