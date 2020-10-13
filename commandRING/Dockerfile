FROM root_utils:latest

#DOWNLOAD PYRDF AND DEPENDENCIES
ENV roothome=/cern_root/root_install
RUN git clone https://github.com/JavierCVilla/PyRDF ${roothome}/PyRDF
RUN python3 -m pip install -r ${roothome}/PyRDF/requirements.txt  
RUN rm -rf /etc/yum/protected.d/systemd.conf && yum remove  -y tar gzip libXft-devel \
    libXft libXft-devel libXpm-devel libXext-devel libzstd ncurses-libs tbb tbb-devel \
    git --installroot=/cern_root/chroot --releasever=/

RUN rm -rf /root_src && rm -rf /cern_root/root && rm -rf /cern_root/chroot/var/cache && rm -rf /cern_root/chroot/var/lib/yum
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
