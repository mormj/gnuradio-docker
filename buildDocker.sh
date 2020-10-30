#!/bin/bash

## build the docker image based on command argument
## Acceptable arguments are: base, buildreqs, source, pkg
rm -rf build
mkdir build


if [ "$3" = "base" ]; then
    cp ./$1/$2/base.Dockerfile build/
    docker build -t gnuradio_$1_$2_base -f build/base.Dockerfile .
elif [ "$3" = "buildreqs" ]; then
    ./buildDocker.sh base
    cp ./$1/$2/buildreqs.Dockerfile build/
    docker build -t gnuradio-master_$1_$2_buildreqs -f build/buildreqs.Dockerfile .
elif [ "$3" = "source" ]; then
    ./buildDocker.sh buildreqs
    cp ./common/source.Dockerfile build/
    cp ./$1/$2/setup_env.sh build/
    cd build/
    docker build --build-arg DISTRO=$1 --build-arg VERSION=$2 -t gnuradio-master_$1_$2_source -f source.Dockerfile .
elif [ "$3" = "pkg" ]; then
    cp ./$1/$2/base.Dockerfile build/
    cp ./$1/common/pkg.Dockerfile build/
    cd build/
    docker build --build-arg DISTRO=$1 --build-arg VERSION=$2 -t gnuradio-master_$1_$2_pkg -f pkg.Dockerfile .
fi
