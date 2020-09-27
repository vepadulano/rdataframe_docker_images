FROM amazonlinux:2
ENV roothome=/cern_root/root
RUN yum install -y git && git clone --branch v6-22-00-patches https://github.com/root-project/root.git /root_src 
RUN yum install -y python libXft gcc-c++ gcc binutils \
    libX11-devel libXpm-devel libXft-devel libXext-devel \
    gcc-gfortran openssl-devel pcre-devel \
    mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel \
    fftw-devel cfitsio-devel graphviz-devel \
    avahi-compat-libdns_sd-devel libldap-dev python-devel \
    libxml2-devel gsl-static 
RUN RUN curl -SL https://github.com/Kitware/CMake/releases/download/v3.13.4/cmake-3.13.4-Linux-x86_64.tar.gz \
        | tar -xzC . \
        && mv cmake-3.13.4-Linux-x86_64 cmake-3.13.4 \
        && rsync -rv --links /cmake-3.13.4/ /usr/local/ && rm -rf /cmake-3.13.4 \

    && RUN curl -SL http://releases.llvm.org/7.0.1/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
        | tar -xJC . \
        && mv clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04 clang_7.0.1 \
        && rsync -rv --links /clang_7.0.1/ /usr/local/ && rm -rf /clang_7.0.1 \

    && mkdir /cern_root && cd /cern_root \
    && cmake \
    -Dasimage=OFF \
    -Dbuiltin_clang=OFF \
    -Dbuiltin_llvm=OFF \
    -Dclad=OFF \
    -Dcudnn=OFF \
    -Ddataframe=OFF \
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
    -Dpyroot=OFF \
    -Dpythia6=OFF \
    -Dpythia8=OFF \
    -Droofit=OFF \
    -Droot7=OFF \
    -Druntime_cxxmodules=OFF \
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
    -Dxml=OFF \
    -Dxrootd=OFF \
    -DCMAKE_INSTALL_PREFIX=/cern_root /root_src \
    && cmake --build . -- install -j4 \
    && for dir in tutorials README cmake js icons LICENSE man geom fonts emacs interpreter; do \
        rm -rf ${roothome}/${dir}; \
    done 

CMD . ${roothome}/bin/thisroot.sh && root -b