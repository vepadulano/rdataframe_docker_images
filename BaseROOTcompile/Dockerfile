FROM amazonlinux:2
ENV roothome=/cern_root/root
RUN yum install -y git-core tar python3 gcc-c++ gcc binutils \
    gcc-gfortran openssl-devel pcre-devel \
    glew-devel ftgl-devel \
    fftw-devel cfitsio-devel python-devel

RUN  mkdir /opt/cmake && cd /tmp && \
    curl -L https://github.com/Kitware/CMake/releases/download/v3.18.3/cmake-3.18.3-Linux-x86_64.tar.gz -o /opt/cmake/cmake.tar.gz && \
    cd /opt/cmake && \
    tar xf cmake.tar.gz && export PATH="/opt/cmake/cmake-3.18.3-Linux-x86_64/bin:$PATH" && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
    cmake --version

RUN git clone --branch v6-22-00-patches https://github.com/root-project/root.git /root_src \
    && export PATH="/opt/cmake/cmake-3.18.3-Linux-x86_64/bin:$PATH" \
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
    -Dlibcxx=ON \
    -DCMAKE_C_COMPILER=gcc\
    -DCMAKE_CXX_COMPILER=g++\
    -DCMAKE_INSTALL_PREFIX=/cern_root /root_src \
    && cmake --build . -- install -j4 \
    && for dir in tutorials README cmake js icons LICENSE man geom fonts emacs interpreter; do \
        rm -rf ${roothome}/${dir}; \
    done 

CMD . ${roothome}/bin/thisroot.sh && root -b