FROM amazonlinux:2
ENV roothome=/mnt/cern_root/root_install
ENV CHROOT=/mnt/cern_root/chroot
ENV PATH=/opt/cmake/cmake-3.18.3-Linux-x86_64/bin:${CHROOT}/usr/local/sbin:${CHROOT}/usr/local/bin:${CHROOT}/usr/sbin:${CHROOT}/usr/bin:${CHROOT}/sbin:${CHROOT}/bin:$PATH
ENV LD_LIBRARY_PATH=${CHROOT}/usr/lib64:${CHROOT}/usr/lib:/usr/lib64:/usr/lib:$LD_LIBRARY_PATH

RUN mkdir -p ${CHROOT}/etc/ && cp -r /etc/yum ${CHROOT}/etc/yum && \
    yum install -y make gcc-c++ gcc binutils python3 python3-devel openssl11 openssl11-devel --installroot=${CHROOT} --releasever=/ && \
    ln -s ${CHROOT}/usr/lib64/libtinfo.so.6 ${CHROOT}/usr/lib64/libtinfo.so.5

RUN yum install -y git tar gzip && yum groupinstall -y 'Development Tools' && mkdir /root_src    
RUN mkdir /opt/cmake && cd /tmp && \
    curl -L https://github.com/Kitware/CMake/releases/download/v3.18.3/cmake-3.18.3-Linux-x86_64.tar.gz -o /opt/cmake/cmake.tar.gz && \
    cd /opt/cmake && \
    tar xf cmake.tar.gz && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
    cmake --version

RUN git clone --branch v6-22-00-patches https://github.com/root-project/root.git  /root_src 
RUN yum install -y openssl11 openssl11-devel
# RUN yum install -y clang --installroot=${CHROOT} --releasever=/
# RUN cat /mnt/cern_root/chroot/usr/include/sys/stat.h
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm --installroot=${CHROOT} --releasever=/ && \
    yum install -y --nogpgcheck xrootd xrootd-client xrootd-client-devel xrootd-python xrootd-client-libs xrootd-libs xrootd-compat-client-libs --installroot=${CHROOT} --releasever=/
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm  && \
    yum install -y --nogpgcheck xrootd xrootd-client xrootd-client-devel xrootd-python xrootd-client-libs xrootd-libs xrootd-compat-client-libs
ENV CPATH=${CHROOT}/usr/include:/usr/include/xrootd:$CPATH
    
# RUN curl https://github.com/xrootd/xrootd/archive/v5.0.3.tar.gz
# ENV STD_PATH=$PATH
# ENV PATH=/opt/cmake/cmake-3.18.3-Linux-x86_64/bin:${CHROOT}/usr/local/sbin:${CHROOT}/usr/local/bin:${CHROOT}/usr/sbin:${CHROOT}/usr/bin:${CHROOT}/sbin:${CHROOT}/bin
RUN mkdir -p ${roothome} && mkdir -p /mnt/cern_root/root && cd /mnt/cern_root/root \
    && cmake \
    -Dbuiltin_tbb=ON \
    -Dminimal=ON \
    -Dasimage=OFF \
    -Dclad=OFF \
    -Dcocoa=OFF \
    -Dcudnn=OFF \
    -Ddataframe=ON \
    -Ddavix=OFF \
    -Dexceptions=ON \
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
    -DXROOTD_ROOT_DIR=${CHROOT}/opt/xrootd \
    # -DCMAKE_CC_COMPILER=${CHROOT}/usr/bin/clang \
    # -DCMAKE_CXX_COMPILER=${CHROOT}/usr/bin/clang++ \
    -DCMAKE_MAKE_PROGRAM=make \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${roothome} /root_src

RUN cd /mnt/cern_root/root && cmake --build . --target install -- -j1 || \
echo "EHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH" && cat  /mnt/cern_root/root/XROOTD-prefix/src/XROOTD-stamp/XROOTD-configure-* && \
echo "EHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH" && cat  /mnt/cern_root/root/XROOTD-prefix/src/XROOTD-stamp/XROOTD-build-* && exit -1
    
RUN for dir in tutorials README js icons LICENSE man geom fonts emacs; do \
        rm -rf ${roothome}/${dir}; \
    done 

CMD . ${roothome}/bin/thisroot.sh && root -b