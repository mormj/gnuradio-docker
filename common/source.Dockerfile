ARG DISTRO
ARG VERSION
FROM gnuradio-maint-3.8_${DISTRO}_${VERSION}_buildreqs

ENV GR /gr
ENV GR_SRC /gr/src/gnuradio

RUN mkdir -p $GR && mkdir -p $GR_SRC

RUN cd $GR/src && git clone https://github.com/gnuradio/gnuradio.git
RUN cd $GR_SRC && git checkout maint-3.8 && git submodule init && git submodule update
RUN cd $GR_SRC && mkdir build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=$GR \
    -DENABLE_GR_CTRLPORT=OFF \ 
    -DENABLE_DOXYGEN=OFF

RUN cd $GR_SRC/build && make -j4
RUN cd $GR_SRC/build && make install

# COPY ./setup_env.sh /