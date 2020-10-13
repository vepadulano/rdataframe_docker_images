FROM amazonlinux:2
ENV roothome=/cern_root/root
ENV PATH=/cern_root/chroot/usr/local/sbin:/cern_root/chroot/usr/local/bin:/cern_root/chroot/usr/sbin:/cern_root/chroot/usr/bin:/cern_root/chroot/sbin:/cern_root/chroot/bin:$PATH
ENV LD_LIBRARY_PATH=/cern_root/chroot/usr/lib64:/cern_root/chroot/usr/lib:/usr/lib64:/usr/lib:$LD_LIBRARY_PATH
# RUN python -c 'import yum, json; yb = yum.YumBase(); print json.dumps(yb.conf.yumvar, indent=2)'
# RUN find /etc/yum/vars -type f -print -exec cat {} \;
RUN mkdir -p /cern_root/chroot/etc/ && cp -r /etc/yum /cern_root/chroot/etc/yum \
    && yum install -y tar gzip make gcc-c++ gcc \
    binutils \
    # libXft libXft-devel libXpm-devel libXext-devel ncurses-libs  tbb tbb-devel  \
    python3 python3-devel libzstd \
    openssl11 git-core --installroot=/cern_root/chroot --releasever=/

RUN ln -s /cern_root/chroot/usr/lib64/libtinfo.so.6  /cern_root/chroot/usr/lib64/libtinfo.so.5 

RUN  mkdir /opt/cmake && cd /tmp && \
    curl -L https://github.com/Kitware/CMake/releases/download/v3.18.3/cmake-3.18.3-Linux-x86_64.tar.gz -o /opt/cmake/cmake.tar.gz && \
    cd /opt/cmake && \
    tar xf cmake.tar.gz && export PATH="/opt/cmake/cmake-3.18.3-Linux-x86_64/bin:$PATH" && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
    cmake --version
RUN  yum install -y git && yum -y groupinstall 'Development Tools' && mkdir /root_src

RUN git clone --branch v6-22-00-patches https://github.com/root-project/root.git /root_src 
RUN export PATH="/opt/cmake/cmake-3.18.3-Linux-x86_64/bin:$PATH" \
    && mkdir -p /cern_root/root_install && mkdir -p /cern_root/root && cd /cern_root/root \
    && cmake \
    -Dbuiltin_tbb=ON \
    -Dminimal=ON \
    -Dasimage=OFF \
    -Dclad=OFF \
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
    -Dxft=OFF \
    -Dbuiltin_freetype=OFF \
    -Dxml=OFF \
    -Dxrootd=OFF \
    # -DCMAKE_C_COMPILER=/usr/bin/gcc \
    # -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
    # -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran \
    -DCMAKE_MAKE_PROGRAM=make \
    -DCMAKE_INSTALL_PREFIX=/cern_root/root_install \
    -DCMAKE_BUILD_TYPE=Release /root_src \
    && cmake --build . -- install -j1 \
    && for dir in tutorials README cmake js icons LICENSE man geom fonts emacs interpreter; do \
        rm -rf ${roothome}/${dir}; \
    done 

CMD . ${roothome}/bin/thisroot.sh && root -b