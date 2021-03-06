FROM root_utils:latest

# DOWNLOAD PYRDF AND DEPENDENCIES
RUN git clone https://github.com/CloudPyRDF/PyRDF ${roothome}/PyRDF && \
    python3 -m pip install -r ${roothome}/PyRDF/requirements.txt  && \
    python3 -m pip install numpy cloudpickle --target=${roothome}

# Install libc++
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm --installroot=${CHROOT} --releasever=/ && \
    yum update -y --installroot=${CHROOT} --releasever=/ && \
    yum install -y --nogpgcheck glibc glibc-devel libcxx libcxx-devel --installroot=${CHROOT} --releasever=/

# Cleanup not needed
RUN rm -rf /root_src && \
    rm -rf /mnt/cern_root/root && \
    rm -rf /mnt/cern_root/chroot/var/cache && \
    rm -rf /mnt/cern_root/chroot/var/lib/yum && \
    rm -rf /mnt/cern_root/chroot/usr/share && \
    rm -rf /mnt/cern_root/chroot/usr/lib64/python2.7 && \
    rm -rf /mnt/cern_root/chroot/usr/libexec/git-core && \
    rm -rf /mnt/cern_root/chroot/usr/src && \
    find /mnt/cern_root/ | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf


ENV FUNCTION_DIR /mnt/cern_root/root_install/PyRDF
RUN curl https://raw.githubusercontent.com/CloudPyRDF/ROOTLambda/Docker/lambda.py > ${FUNCTION_DIR}/lambda.py
RUN python3 -m pip install awslambdaric boto3 --target ${FUNCTION_DIR}
RUN . ${roothome}/bin/thisroot.sh

# TEST
# RUN  . ${roothome}/bin/thisroot.sh && \
#     # curl https://raw.githubusercontent.com/JavierCVilla/PyRDF/master/tutorials/local/sequential/df001_introduction.py > ${roothome}/PyRDF/introduction.py && \
#     # python3 ${roothome}/PyRDF/introduction.py && \
#     curl https://raw.githubusercontent.com/CloudPyRDF/test_repo/main/test.py > ${roothome}/PyRDF/xrootd.py && cd / &&  python3 ${roothome}/PyRDF/xrootd.py

# #INSTALL TERRAFORM
# RUN curl -L https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip > terraform.zip
# RUN yum install -y unzip && unzip terraform.zip -d /usr/bin/
# RUN chmod +x /usr/bin/terraform
# RUN mkdir /terraform
# ADD main.tf /terraform/main.tf
# RUN chmod 777 /terraform -R

# CMD cd /terraform && terraform init &&  terraform apply -auto-approve
