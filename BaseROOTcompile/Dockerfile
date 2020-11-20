FROM amazonlinux:2
ENV roothome=/mnt/cern_root/root
ENV CHROOT=/mnt/cern_root/chroot
ENV PATH=${CHROOT}/usr/local/sbin:${CHROOT}/usr/local/bin:${CHROOT}/usr/sbin:${CHROOT}/usr/bin:${CHROOT}/sbin:${CHROOT}/bin:$PATH
ENV LD_LIBRARY_PATH=${CHROOT}/usr/lib64:${CHROOT}/usr/lib:/usr/lib64:/usr/lib:$LD_LIBRARY_PATH
# RUN python -c 'import yum, json; yb = yum.YumBase(); print json.dumps(yb.conf.yumvar, indent=2)'
# RUN find /etc/yum/vars -type f -print -exec cat {} \;
RUN mkdir -p ${CHROOT}/etc/ && cp -r /etc/yum ${CHROOT}/etc/yum && \
    yum install -y make gcc-c++ gcc binutils \
    python3 python3-devel openssl11 --installroot=${CHROOT} --releasever=/ && \
    # yum groupinstall -y 'Development Tools' --installroot=${CHROOT} --releasever=/ && \
    ln -s ${CHROOT}/usr/lib64/libtinfo.so.6 ${CHROOT}/usr/lib64/libtinfo.so.5 
    # libXft libXft-devel libXpm-devel libXext-devel ncurses-libs  tbb tbb-devel  python3-devel  \

RUN yum install -y git tar gzip && yum groupinstall -y 'Development Tools' && mkdir /root_src    
ENV PATH=/opt/cmake/cmake-3.18.3-Linux-x86_64/bin:$PATH
RUN mkdir /opt/cmake && cd /tmp && \
    curl -L https://github.com/Kitware/CMake/releases/download/v3.18.3/cmake-3.18.3-Linux-x86_64.tar.gz -o /opt/cmake/cmake.tar.gz && \
    cd /opt/cmake && \
    tar xf cmake.tar.gz && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
    cmake --version

RUN git clone --branch v6-22-00-patches https://github.com/root-project/root.git  /root_src 

RUN mkdir -p /mnt/cern_root/root_install && mkdir -p /mnt/cern_root/root && cd /mnt/cern_root/root \
    && cmake \
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
    -Dxrootd=OFF \
    # -DCMAKE_C_COMPILER=${CHROOT}/usr/bin/gcc \
    # -DCMAKE_CXX_COMPILER=${CHROOT}/usr/bin/g++ \
    # -DCMAKE_Fortran_COMPILER=${CHROOT}/usr/bin/gfortran \
    -DCMAKE_MAKE_PROGRAM=make \
    -DCMAKE_INSTALL_PREFIX=/mnt/cern_root/root_install \
    -DCMAKE_BUILD_TYPE=Release /root_src

RUN cmake --build . -- install -j1
    
RUN for dir in tutorials README js icons LICENSE man geom fonts emacs; do \
        rm -rf /mnt/cern_root/root_install/${dir}; \
    done 

CMD . ${roothome}/bin/thisroot.sh && root -b