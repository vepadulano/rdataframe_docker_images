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
    -Dbuiltin_tbb=ON \
    -Dminimal=ON \
    -Dasimage=OFF \
    -Dclad=OFF \
    -Dcocoa=OFF \
    -Dcudnn=OFF \
    -Ddataframe=ON \
    -Ddavix=OFF \
    -Dexceptions=OFF \
    -Dfftw3=OFF \
    -Dfitsio=OFF \
    -Dgdml=OFF \
    -Dgfal=OFF \
    -Dhttp=OFF \
    -Dimt=OFF \
    -Dmathmore=OFF \
    -Dmlp=OFF \
    -Dmysql=OFF \
    -Dopengl=OFF \
    -Doracle=OFF \
    -Dpgsql=OFF \
    -Dpyroot=ON \
    -Dpythia6=OFF \
    -Dpythia8=OFF \
    -Droofit=OFF \
    -Droot7=OFF \
    -Druntime_cxxmodules=ON \
    -Dshared=OFF \
    -Dspectrum=OFF \
    -Dsqlite=OFF \
    -Dssl=OFF \
    -Dtmva=OFF \
    -Dtmva-cpu=OFF \
    -Dtmva-pymva=OFF \
    -Dvdt=OFF \
    -Dwebgui=OFF \
    -Dx11=OFF \
    -Dxft=OFF \
    -Dbuiltin_freetype=OFF \
    -Dxml=OFF \
    -Dxrootd=ON \
    -Dbuiltin_xrootd=ON \
    -B root_build -S root_src
RUN cmake --build root_build -- install -j$(nproc)

ENV PYTHONPATH /usr/local/lib/root/
