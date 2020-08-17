FROM gnuradio_fedora_32_base

RUN dnf install -y \
    # General building
    ccache \
    cmake \
    make \
    gcc \
    gcc-c++ \
    shadow-utils \
    xz \
    # Build infrastructure
    cmake \
    boost-devel \
    python3-devel \
    cppunit-devel \
    # Documentation
    doxygen \
    # disabling doxygen-latex for build speed reasons.
    #        doxygen-latex \ 
    graphviz \
    # Math libraries
    fftw-devel \
    gsl-devel \
    python3-numpy \
    python3-scipy \
    gmp-devel \
    # IO libraries
    cppzmq-devel \
    python3-zmq \
    SDL-devel \
    alsa-lib-devel \
    portaudio-devel \
    jack-audio-connection-kit \
    uhd-devel \
    log4cpp-devel \
    ## Vocoder libraries
    codec2-devel \
    gsm-devel \
    # ctrlport - thrift
    thrift \
    thrift-devel \
    python3-thrift \
    # GUI libraries
    xdg-utils \
    qwt-qt5-devel \
    python3-PyQt5 \
    python3-qt5-devel \
    # XML Parsing / GRC
    desktop-file-utils \
    python3-mako \
    python3-click \
    python3-click-plugins \
    # GRC/next
    python3-pyyaml \
    python3-lxml \
    python3-gobject \
    gtk3 \
    python3-cairo \
    pango \
    swig \
    && \
    dnf clean all && \
    echo "max_size = 20G" > /etc/ccache.conf

# Install required python packages, and twisted
RUN dnf install -y \
    python3-pip \
    dumb-init && \
    dnf clean all 

RUN dnf install -y \
    git \
    pybind11-devel && \
    dnf clean all 

