FROM root_utils:latest

#DOWNLOAD PYRDF AND DEPENDENCIES
ENV roothome=/mnt/cern_root/root_install
RUN git clone https://github.com/JavierCVilla/PyRDF ${roothome}/PyRDF
RUN python3 -m pip install -r ${roothome}/PyRDF/requirements.txt  
# RUN rm -rf /etc/yum/protected.d/systemd.conf && yum remove  -y libXft-devel \
#     libXft libXft-devel libXpm-devel libXext-devel ncurses-libs tbb tbb-devel \
#     git --installroot=/mnt/cern_root/chroot --releasever=/

# ENV PATH=${CHROOT}/usr/local/sbin:${CHROOT}/usr/local/bin:${CHROOT}/usr/sbin:${CHROOT}/usr/bin:${CHROOT}/sbin:${CHROOT}/bin:/bin:/usr/bin/usr/sbin
# RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum -y update && yum -y install patchelf
# RUN find /mnt/cern_root/ -executable -type f -exec patchelf --set-interpreter /mnt/cern_root/chroot/usr/lib64/ld-linux-x86-64.so.2 {} \;

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm --installroot=${CHROOT} --releasever=/ && sudo rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 && \
 && yum update -y --installroot=${CHROOT} --releasever=/ && yum install -y libcxx libcxx-devel --installroot=${CHROOT} --releasever=/

RUN rm -rf /root_src && \
rm -rf /mnt/cern_root/root && \
rm -rf /mnt/cern_root/chroot/var/cache && \
rm -rf /mnt/cern_root/chroot/var/lib/yum && \
rm -rf /mnt/cern_root/chroot/usr/lib64/python2.7 && \
rm -rf /mnt/cern_root/chroot/usr/libexec/git-core && \
rm -rf /mnt/cern_root/chroot/usr/src && \
find /mnt/cern_root/ | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
# rm -rf /mnt/cern_root/chroot/usr/share && \

RUN curl https://raw.githubusercontent.com/JavierCVilla/PyRDF/master/tutorials/local/sequential/df001_introduction.py > ${roothome}/PyRDF/introduction.py
RUN . ${roothome}/bin/thisroot.sh && python3 ${roothome}/PyRDF/introduction.py

# #INSTALL TERRAFORM
# RUN curl -L https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip > terraform.zip
# RUN yum install -y unzip && unzip terraform.zip -d /usr/bin/
# RUN chmod +x /usr/bin/terraform
# RUN mkdir /terraform
# ADD main.tf /terraform/main.tf
# RUN chmod 777 /terraform -R

# CMD cd /terraform && terraform init &&  terraform apply -auto-approve
