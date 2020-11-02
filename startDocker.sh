#!/bin/bash


if [ "$3" = "base" ]; then
    NAME="gnuradio"
    echo "${NAME}_${1}_${2}_${3}"
else
    NAME=gnuradio-master
    echo "${NAME}_${1}_${2}_${3}"
fi


xhost +
docker run --cpus 4 -it \
               -v ~/.Xauthority:/root/.Xauthority \
               -v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
               -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
               "${NAME}_${1}_${2}_${3}" "bash"
            #    -v /share/tmp:/data \
            #    -p 5678:5679 \