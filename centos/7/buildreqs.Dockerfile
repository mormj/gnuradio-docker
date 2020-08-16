FROM gnuradio_centos_7_base

# enable EPEL for all the newer crazy stuff
# like CMake 3
RUN yum install epel-release -y -q && \
    # get the new packages from EPEL
    yum --enablerepo=epel check-update -y; \
    yum install -y \
    # General building
    ccache \
    cmake3 \
    make \
    gcc \
    gcc-c++ \
    python36-pip \
    shadow-utils \
    openssl-devel \
    # Build infrastructure
    boost-devel \
    python36-devel \
    python-devel \
    cppunit-devel \
    # Documentation
    doxygen \
    doxygen-latex \
    graphviz \
    # Math libraries
    fftw-devel \
    gsl-devel \
    numpy \
    # scipy \
    python36-scipy \
    gmp-devel \
    # IO libraries
    SDL-devel \
    alsa-lib-devel \
    portaudio-devel \
    cppzmq-devel \
    python36-zmq \
    uhd-devel \
    # ctrlport - thrift
    # thrift \
    # thrift-devel \
    # GUI libraries
    xdg-utils \
    python36-lxml \
    pygtk2-devel \
    desktop-file-utils \
    python-mako \
    log4cpp-devel \
    qt5-qtbase-devel \
    # qt \
    python36-qt5 \
    python36-pyqt5-sip \
    qwt-devel \
    # GRC/next
    PyYAML \
    python36-PyYAML \
    gtk3 \
    python36-gobject \
    pycairo \
    python36-cairo \
    pango \
    python-six \
    python36-six \
    swig3 \
    git \
    && \
    yum clean all && \
    rm /usr/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/bin/python3
# download all the source RPMs we'll build later
RUN     cd && \
    # symlink cmake3 and ctest3 to cmake / ctest
    cd /usr/bin && \
    ln -s ctest3 ctest && \
    ln -s cmake3 cmake && \
    yum clean all && \
    pip3 --no-cache-dir install 'mako' 

RUN    mkdir -p /src/pybind11 && \
    cd /src && \
    curl -Lo pybind11.tar.gz https://github.com/pybind/pybind11/archive/v2.4.3.tar.gz && \
    tar xzf pybind11.tar.gz -C pybind11 --strip-components=1 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DPYBIND11_TEST=OFF ../pybind11/ && \
    make && \
    make install && \
    cd / && \
    rm -rf /src/pybind11 && \
    rm -rf /src/build

# For Modtool
RUN pip3 install click click-plugins

# Hack due to mismatched QT/QWT versions
RUN sed -i 's/QT_STATIC_CONST/static const/g' /usr/include/qwt/qwt_transform.h