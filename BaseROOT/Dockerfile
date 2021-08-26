FROM ubuntu:20.04

# ROOT deps
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Singapore apt-get -y -q install \
    dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev libssl-dev gfortran libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev libxml2-dev libkrb5-dev \
    libgsl0-dev git python3 python3-pip

# Python deps
RUN pip install numpy dask distributed

# ROOT
RUN git clone --branch v6-24-00-patches https://github.com/root-project/root.git root_src
RUN mkdir root_build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local -Dgnuinstall=ON \
    -Dxrootd=ON \
    -Dbuiltin_xrootd=ON \
    -B root_build -S root_src
RUN cmake --build root_build -- install -j1

ENV PYTHONPATH /usr/local/lib/root/
