FROM gnuradio_centos_8_base

RUN dnf -y -q install dnf-plugins-core && \
    dnf -y -q install epel-release && \
   dnf -y -q config-manager --set-enabled PowerTools

RUN dnf install -y \
    # General building
    ccache \
    cmake3 \
    make \
    gcc \
    gcc-c++ \
    python3-pip \
    shadow-utils \
    openssl-devel \
    # Build infrastructure
    boost-devel \
    python3-devel \
    cppunit-devel \
    # Documentation
    doxygen \
    doxygen-latex \
    graphviz \
    # Math libraries
    fftw-devel \
    gsl-devel \
    python3-numpy \
    # scipy \
    python3-scipy \
    gmp-devel \
    # IO libraries
    SDL-devel \
    alsa-lib-devel \
    portaudio-devel \
    cppzmq-devel \
    python3-zmq \
    uhd-devel \
    # ctrlport - thrift
    # thrift \
    # thrift-devel \
    # GUI libraries
    xdg-utils \
    python3-lxml \
    pygtk2-devel \
    desktop-file-utils \
    python3-mako \
    log4cpp-devel \
    qt5-qtbase-devel \
    python3-qt5 \
    python3-pyqt5-sip \
    qwt-qt5-devel \
    # GRC/next
    python3-pyyaml \
    gtk3 \
    python3-gobject \
    python3-cairo \
    pango \
    && \
    dnf clean all 

RUN dnf install -y -q castxml

# download all the source RPMs we'll build later
# RUN     cd && \
#     # symlink cmake3 and ctest3 to cmake / ctest
#     cd /usr/bin && \
#     ln -s ctest3 ctest && \
#     ln -s cmake3 cmake && \
#     dnf clean all && \
#     pip3 --no-cache-dir install 'mako' 

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


RUN pip3 --no-cache-dir install pygccxml

RUN dnf install -y -q git

# RUN dnf install -y -q \
#     git \ 
#     wget 

# ## Build boost from source because Centos7 comes with 1.53
# RUN wget http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz && \
#     tar -zxvf boost_1_58_0.tar.gz && \
#     cd boost_1_58_0 && \
#     ./bootstrap.sh && \
#     ./b2 install
