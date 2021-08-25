FROM pyrdf_client:latest

RUN curl https://raw.githubusercontent.com/CloudPyRDF/root/AWS/bindings/experimental/distrdf/python/DistRDF/Backends/AWS/Backend.py
RUN curl https://raw.githubusercontent.com/CloudPyRDF/root/AWS/bindings/experimental/distrdf/python/DistRDF/Backends/AWS/__init__.py

# DOWNLOAD PYRDF AND DEPENDENCIES
RUN git clone https://github.com/CloudPyRDF/PyRDF ${roothome}/PyRDF && \
    python3 -m pip install -r ${roothome}/PyRDF/requirements.txt  && \
    python3 -m pip install numpy cloudpickle --target=${roothome}

ENV FUNCTION_DIR /mnt/cern_root/root_install/PyRDF
RUN python3 -m pip install awslambdaric boto3 cloudpickle numpy --target ${FUNCTION_DIR}
RUN chmod -R 777 /mnt/cern_root/root_install
RUN curl https://raw.githubusercontent.com/CloudPyRDF/ROOTLambda/Docker/lambda.py > ${FUNCTION_DIR}/lambda.py && chmod 765 ${FUNCTION_DIR}/lambda.py

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
