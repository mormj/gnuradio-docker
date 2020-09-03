ARG DISTRO
ARG VERSION

# Install GNU Radio from package manager (Launchpad PPA)
FROM ${DISTRO}:${VERSION}

# ENV security_updates_as_of 2019-08-08

RUN DEBIAN_FRONTEND=noninteractive apt-get -yq update && \
     apt-get install -qy software-properties-common 

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:gnuradio/gnuradio-releases && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install gnuradio-dev

RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install libgtk-3-dev

# # OOT modules
# RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install gr-fcdproplus
