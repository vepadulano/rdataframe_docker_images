#!/bin/bash -ex

ROOT_BRANCH_NAME=${1:-AWS-dev}

if [[ ! -d ./root ]] ; then
    git clone -b ${ROOT_BRANCH_NAME} https://github.com/CloudPyRDF/root.git
else
    cd root
    git pull
    git checkout ${ROOT_BRANCH_NAME}
    cd ..
fi


sudo DOCKER_BUILDKIT=1 docker build . -t root_worker:latest
