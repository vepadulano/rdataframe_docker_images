FROM root_utils:latest

#DOWNLOAD PYRDF AND DEPENDENCIES
ENV roothome=/cern_root/root_install
RUN  cp -r /etc/yum /cern_root/chroot/etc/yum \
    && curl -L https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -o epel.rpm \
    && rpm -ivh ./epel.rpm \
    # && yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm --installroot=/cern_root/chroot --releasever=/ \
    && yum install -y python-pip pandoc git-core --installroot=/cern_root/chroot --releasever=/
RUN git clone https://github.com/JavierCVilla/PyRDF ${roothome}/PyRDF
RUN pip install --upgrade pip && \
    pip install wheel && \
    pip install -r ${roothome}/PyRDF/requirements.txt && \
    pip install pyspark --no-cache-dir
    
RUN rm -rf /root_src && rm -rf /cern_root/root
RUN curl https://raw.githubusercontent.com/JavierCVilla/PyRDF/master/tutorials/local/sequential/df001_introduction.py > ${roothome}/PyRDF/introduction.py
RUN . ${roothome}/bin/thisroot.sh && python3 ${roothome}/PyRDF/introduction.py

#INSTALL TERRAFORM
RUN curl -L https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip > terraform.zip
RUN yum install -y unzip && unzip terraform.zip -d /usr/bin/
RUN chmod +x /usr/bin/terraform
RUN mkdir /terraform
ADD main.tf /terraform/main.tf
RUN chmod 777 /terraform -R

CMD cd /terraform && terraform init &&  terraform apply -auto-approve
