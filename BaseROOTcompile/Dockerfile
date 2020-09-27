FROM amazonlinux:2
RUN git clone --branch v6-22-00-patches https://github.com/root-project/root.git root_src
ENV roothome=/cern_root/root
RUN mkdir /cern_root && cd cern_root
RUN yum install -y git python2 libXft cmake gcc-c++ gcc binutils \
    libX11-devel libXpm-devel libXft-devel libXext-devel \
    gcc-gfortran openssl-devel pcre-devel \
    mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel \
    fftw-devel cfitsio-devel graphviz-devel \
    avahi-compat-libdns_sd-devel libldap-dev python-devel \
    libxml2-devel gsl-static \
    && cmake -DCMAKE_INSTALL_PREFIX=../root_install ../root_src \
    && cmake --build . -- install -j4 \
    && for dir in tutorials README cmake js icons LICENSE man geom fonts emacs interpreter; do \
        rm -rf ${roothome}/${dir}; \
    done 

CMD . ${roothome}/bin/thisroot.sh && root -b