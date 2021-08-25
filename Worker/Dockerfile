FROM root_base:latest

RUN rm -rf /root_build 
RUN rm -rf /root_src

ENV FUNCTION_DIR=/usr/local
ENV EXPERIMENTAL_PATH=bindings/experimental/distrdf/python/DistRDF/Backends/AWS
ENV DISTRDF_PATH=lib/root/DistRDF

ENV TARGET_PATH=${FUNCTION_DIR}/${DISTRDF_PATH}/Backends
RUN echo ${TARGET_PATH}
RUN mkdir -p ${TARGET_PATH}/AWS

RUN apt install curl
RUN ls /usr/local/lib/root/DistRDF/Backends
RUN curl https://raw.githubusercontent.com/CloudPyRDF/root/AWS/${EXPERIMENTAL_PATH}/Backend.py \
> ${TARGET_PATH}/AWS/Backend.py 
RUN curl https://raw.githubusercontent.com/CloudPyRDF/root/AWS/${EXPERIMENTAL_PATH}/__init__.py \
> ${TARGET_PATH}/AWS/__init__.py 

RUN pip install awslambdaric boto3 cloudpickle numpy --target ${FUNCTION_DIR}
RUN curl https://raw.githubusercontent.com/CloudPyRDF/rdataframe_awslambda_worker/master/lambda.py > ${FUNCTION_DIR}/lambda.py && chmod 765 ${FUNCTION_DIR}/lambda.py

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
