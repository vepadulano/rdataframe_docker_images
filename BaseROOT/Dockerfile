FROM amazonlinux:2
ENV roothome=/cern_root/root
ENV PATH=/cern_root/chroot/usr/local/sbin:/cern_root/chroot/usr/local/bin:/cern_root/chroot/usr/sbin:/cern_root/chroot/usr/bin:/cern_root/chroot/sbin:/cern_root/chroot/bin:$PATH
ENV LD_LIBRARY_PATH=/cern_root/chroot/usr/lib64:/cern_root/chroot/usr/lib:$LD_LIBRARY_PATH
RUN python -c 'import yum, json; yb = yum.YumBase(); print json.dumps(yb.conf.yumvar, indent=2)'
RUN find /etc/yum/vars -type f -print -exec cat {} \;
RUN curl -L https://root.cern/download/root_v6.22.02.Linux-centos7-x86_64-gcc4.8.tar.gz -o rootbin.tar.gz \
    && mkdir -p /cern_root/chroot/etc/ && cp -r /etc/yum /cern_root/chroot/etc/yum \
    && yum install -y tar gzip libXft-devel make cmake gcc-c++ gcc \
    binutils libXft libXft-devel libXpm-devel libXext-devel python3 python3-devel --installroot=/cern_root/chroot --releasever=/ \
    && export PATH=/cern_root/chroot/usr/local/sbin:/cern_root/chroot/usr/local/bin:/cern_root/chroot/usr/sbin:/cern_root/chroot/usr/bin:/cern_root/chroot/sbin:/cern_root/chroot/bin:$PATH \
    && tar xvf rootbin.tar.gz -C /cern_root > /dev/null

RUN for dir in tutorials README cmake js icons LICENSE man geom fonts emacs; do \
        rm -rf ${roothome}/${dir}; \
    done \
    && ls -la $roothome

CMD . ${roothome}/bin/thisroot.sh && root