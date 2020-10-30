FROM gnuradio_centos_7_base

# RUN yum install epel-release -y -q && \
#     # get the new packages from EPEL
#     yum --enablerepo=epel check-update -y; \ 
#     yum install -y \ 
#     boost169-devel

# # RUN yum -y install wget
# # RUN wget http://repo.enetres.net/enetres.repo -O /etc/yum.repos.d/enetres.repo
# RUN yum -y install boost169-devel

# enable EPEL for all the newer crazy stuff
# like CMake 3
RUN yum install epel-release -y -q && \
    # get the new packages from EPEL
    yum --enablerepo=epel check-update -y; \
    yum install -y \
    ccache \
    cmake3 \
    make \
    gcc \
    gcc-c++ \
    python36-pip \
    shadow-utils \
    openssl-devel \
    python36-devel \
    python-devel \
    cppunit-devel \
    doxygen \
    doxygen-latex \
    graphviz \
    fftw-devel \
    gsl-devel \
    gmp-devel \
    SDL-devel \
    alsa-lib-devel \
    portaudio-devel \
    cppzmq-devel \
    python36-zmq \
    uhd-devel \
    xdg-utils \
    python36-lxml \
    pygtk2-devel \
    desktop-file-utils \
    python-mako \
    log4cpp-devel \
    qt5-qtbase-devel \
    python36-six \
    python36-qt5 \
    python36-pyqt5-sip \
    qwt-devel \
    PyYAML \
    python36-PyYAML \
    gtk3 \
    python36-gobject \
    pycairo \
    python36-cairo \
    pango \
    libsndfile-devel \
    && \
    yum clean all && \
    rm /usr/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/bin/python3

# download all the source RPMs we'll build later
RUN     cd && \
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


# RUN yum install epel-release -y -q && \
#     # get the new packages from EPEL
#     yum --enablerepo=epel check-update -y; \
#     yum install -y -q \ 
#     git \ 
#     wget \
#     ccache \
#     cmake3 \
#     make \
#     gcc \
#     gcc-c++ \
#     python36-pip \
#     shadow-utils \
#     openssl-devel

# Hack due to mismatched QT/QWT versions
# RUN sed -i 's/QT_STATIC_CONST/static const/g' /usr/include/qwt/qwt_transform.h


RUN yum install -y -q \
    git  \
    wget 

RUN pip3 install numpy scipy click click-plugins

## Build boost from source because Centos7 comes with 1.53
RUN wget http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz && \
    tar -zxvf boost_1_58_0.tar.gz && \
    cd boost_1_58_0 && \
    ./bootstrap.sh 
    # && \
    # ./b2 install


RUN cd /boost_1_58_0 && \
    ./b2 install --with-system --with-filesystem --with-program_options --with-date_time --with-regex --with-thread --with-chrono --with-atomic --with-test