# syntax = docker/dockerfile:1.3-labs
FROM root-master-ubuntu2004:latest

WORKDIR /usr/local
ENV EXPERIMENTAL_PATH=bindings/experimental/distrdf/python/DistRDF/Backends/AWS
ENV TARGET_PATH=lib/root/DistRDF

# Install Dependencies
RUN apt install curl && pip install --upgrade pip && pip install awslambdaric boto3 cloudpickle numpy

# BEGIN only for client
RUN pip install jupyter

# Get Lambda into correct position
RUN curl https://raw.githubusercontent.com/wlloyduw/SAAF/master/python_template/src/Inspector.py > Inspector.py && chmod 767 Inspector.py \
&& curl https://raw.githubusercontent.com/vepadulano/rdataframe_awslambda_worker/root-6-24-lambda/lambda.py > lambda.py && chmod 777 lambda.py

# Copy patched DistRDF into ROOT libraries directory
RUN git clone https://github.com/vepadulano/root.git --single-branch --branch distrdf-aws-vpadulan root_src
RUN cp -r root_src/bindings/experimental/distrdf/python/DistRDF ${TARGET_PATH}
RUN rm -rf root_src

# Get the analysis for client
# TODO mount this instead of downloading 
RUN git clone https://gitlab.cern.ch/mpitt/ppstools.git
CMD jupyter notebook --ip 0.0.0.0 --no-browser --allow-root

