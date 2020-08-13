#!/bin/bash

xhost +
docker run --cpus 4 -it \
               -v ~/.Xauthority:/root/.Xauthority \
               -v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
               -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
                gnuradio_$1_$2_$3 "bash"
            #    -v /share/tmp:/data \
            #    -p 5678:5679 \