ARG DISTRO
ARG VERSION
FROM gnuradio_${DISTRO}_${VERSION}_buildreqs

ENV GR /gr
ENV GR_SRC /gr/src/gnuradio

RUN mkdir -p $GR && mkdir -p $GR_SRC

## Build Volk
RUN cd $GR/src/ && git clone https://github.com/gnuradio/volk.git && cd volk && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=$GR && \
    make install -j4

## Build GNU Radio


RUN cd $GR/src && git clone https://github.com/gnuradio/gnuradio.git

RUN cd $GR_SRC && mkdir build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=$GR \
    -DENABLE_GR_CTRLPORT=OFF \
    -DENABLE_DOXYGEN=OFF

RUN cd $GR_SRC/build && make -j4
RUN cd $GR_SRC/build && make install

COPY ./setup_env.sh /