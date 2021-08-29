# syntax = docker/dockerfile:1.3-labs
FROM root_base:latest

# RUN rm -rf /root_build 
# RUN rm -rf /root_src

ENV FUNCTION_DIR=/usr/local
ENV EXPERIMENTAL_PATH=bindings/experimental/distrdf/python/DistRDF/Backends/AWS
ENV DISTRDF_PATH=lib/root/DistRDF

ENV TARGET_PATH=${FUNCTION_DIR}/${DISTRDF_PATH}/Backends
RUN echo ${TARGET_PATH}
RUN mkdir -p ${TARGET_PATH}/AWS

RUN apt install curl
RUN ls /usr/local/lib/root/DistRDF/Backends

RUN pip install awslambdaric boto3 cloudpickle numpy --target ${FUNCTION_DIR}
RUN pip install jupyter

RUN curl https://raw.githubusercontent.com/CloudPyRDF/root/AWS/${EXPERIMENTAL_PATH}/__init__.py \
> ${TARGET_PATH}/AWS/__init__.py 
RUN curl https://raw.githubusercontent.com/CloudPyRDF/root/AWS/${EXPERIMENTAL_PATH}/Backend.py \
> ${TARGET_PATH}/AWS/Backend.py 

# RUN curl https://raw.githubusercontent.com/CloudPyRDF/rdataframe_awslambda_worker/Docker/lambda.py > ${FUNCTION_DIR}/lambda.py && chmod 765 ${FUNCTION_DIR}/lambda.py

RUN <<EOF cat >> ${FUNCTION_DIR}/lambda.py && chmod 765 ${FUNCTION_DIR}/lambda.py
import base64
import json
import os
import time
import cloudpickle as pickle
from ast import literal_eval

import boto3
import ROOT

bucket = os.environ.get('bucket')

def lambda_handler(event, context):
    print('event', event)
    s3 = boto3.client('s3')

    start = int(event['start'])
    end = int(event['end'])
    filelist= literal_eval(event['filelist'])
    friend_info= None
    
    if event.get('friend_info'):
        friend_info = pickle.loads(
            base64.b64decode(event['friend_info'][2:-1])
        )

    range = base64.b64decode(event['range'][2:-1])
    mapper = base64.b64decode(event['script'][2:-1])

    mapper=pickle.loads(mapper)
    range=pickle.loads(range)

    # range.start=start
    # range.end=end
    # range.filelist=filelist
    # print("before friend")
    # if friend_info is not None:
    #     print(friend_info)
    #     print(friend_info.friend_names)
    #     print(friend_info.friend_file_names)

    # range.friend_info=friend_info
    # print("after friend")

    try:
        hist=mapper(range)
    except Exception as e:
        return {
            'statusCode': 500,
            'errorType': json.dumps(type(e).__name__),
            'errorMessage': json.dumps(str(e)),
        }

    print("after map")

    # f = ROOT.TFile('/tmp/out.root', 'RECREATE')
    # for h in hist:
    #     h.GetValue().Write()
    # f.Close()
    with open('/tmp/out.pickle', 'wb') as handle:
        pickle.dump(hist, handle)

    filename=f'partial_{str(start)}_{str(end)}_{str(int(time.time()*1000.0))}.pickle'

    s3.upload_file(f'/tmp/out.pickle', bucket, filename)

    return {
        'statusCode': 200,
        'body': json.dumps(f'Done analyzing, result saved as {filename}')
    }
EOF

WORKDIR /usr/local
RUN curl https://raw.githubusercontent.com/Kamilbur/PyRDFMaster/root-lambda-client/commandRING/client/files/df102_NanoAODDimuonAnalysis.ipynb > analysis.ipynb
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
