# syntax = docker/dockerfile:1.3-labs
FROM root_base:latest

# RUN rm -rf /root_build 
# RUN rm -rf /root_src

WORKDIR /usr/local
ENV EXPERIMENTAL_PATH=bindings/experimental/distrdf/python/DistRDF/Backends/AWS
ENV TARGET_PATH=lib/root/DistRDF/Backends
ENV BRANCH=AWS-dev

# Install Dependencies
RUN apt install curl && pip install --upgrade pip && pip install awslambdaric boto3 cloudpickle numpy

# BEGIN only for client
RUN pip install jupyter
# END

# configure AWS patch for client side
RUN mkdir -p ${TARGET_PATH}/AWS

# Get Lambda into correct position
RUN curl https://raw.githubusercontent.com/wlloyduw/SAAF/master/python_template/src/Inspector.py > Inspector.py && chmod 767 Inspector.py \
&& curl https://raw.githubusercontent.com/CloudPyRDF/rdataframe_awslambda_worker/root-6-24-lambda/lambda.py > lambda.py && chmod 777 lambda.py

### END OF LAMBDA SIDE ###

COPY root/bindings/experimental/distrdf/python/DistRDF/Backends/AWS ${TARGET_PATH}/AWS

# Get the analysis for client
# TODO mount this instead of downloading 
RUN git clone https://gitlab.cern.ch/mpitt/ppstools.git
CMD  /bin/bash -c "source /usr/local/bin/thisroot.sh && jupyter notebook --allow-root"

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
