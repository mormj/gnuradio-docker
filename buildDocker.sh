#!/bin/bash

## build the docker image based on command argument
## Acceptable arguments are: base, buildreqs, source, pkg

if [ "$3" = "base" ]; then
    docker build -t gnuradio_$1_$2_base -f ./$1/$2/base.Dockerfile .
elif [ "$3" = "buildreqs" ]; then
    ./buildDocker.sh base
    docker build -t gnuradio_$1_$2_buildreqs -f ./$1/$2/buildreqs.Dockerfile .
elif [ "$3" = "source" ]; then
    ./buildDocker.sh buildreqs
    docker build --build-arg DISTRO=$1 --build-arg VERSION=$2 -t gnuradio_$1_$2_source -f ./common/source.Dockerfile .
elif [ "$3" = "pkg" ]; then
    docker build -t gnuradio_$1_$2_pkg -f ./$1/$2/pkg.Dockerfile .
fi
