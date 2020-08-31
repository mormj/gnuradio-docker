FROM gnuradio_ubuntu_18.04_base

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common 

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy \
    libthrift-dev \
    thrift-compiler \
    libcodec2-dev \
    thrift-compiler

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy \
    cmake \
    doxygen \
    graphviz \
    libasound2-dev \
    libboost-date-time-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libcppunit-dev \
    libfftw3-dev \
    libfontconfig1-dev \
    libgmp-dev \
    libgsl-dev \
    libgsm1-dev \
    libjack-jackd2-dev \
    liblog4cpp5-dev \
    liborc-0.4-dev \
    libportaudio2 \
    libpulse-dev \
    libqwt-qt5-dev \
    libsdl1.2-dev \
    libsndfile1-dev \
    libusb-1.0-0-dev \
    libxi-dev \
    libxrender-dev \
    libzmq3-dev \
    portaudio19-dev \
    pybind11-dev \
    python3-click \
    python3-click-plugins \
    python3-dev \
    python3-lxml \
    python3-mako \
    python3-numpy \
    python3-opengl \
    python3-pyqt5 \
    python3-zmq \
    python3-pip \
    qt5-qmake \
    qtbase5-dev \
    qttools5-dev \
    thrift-compiler \
    xmlto \
    git \
    ubuntu-dev-tools \
    bash-completion \
    python3-gi-cairo \
    python3-yaml \
    libgtk-3-dev \
    vim


## Optional dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy \
    python3-scipy \
    python3-matplotlib

RUN pip3 install pygccxml castxml


#TODO - pybind11 from source