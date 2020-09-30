FROM amazonlinux:2
ENV roothome=/cern_root/root
RUN curl -L https://root.cern/download/root_v6.22.02.Linux-centos7-x86_64-gcc4.8.tar.gz -o rootbin.tar.gz \
    && yum install -y tar \
    && mkdir /cern_root \
    && tar xvf rootbin.tar.gz -C /cern_root
# RUN yum install -y git cmake gcc-c++ gcc binutils \
#     libX11-devel libXpm-devel \
#     gcc-gfortran gsl-static

RUN for dir in tutorials README cmake js icons LICENSE man geom fonts emacs; do \
        rm -rf ${roothome}/${dir}; \
    done \
    && ls -la $roothome

CMD . ${roothome}/bin/thisroot.sh && root