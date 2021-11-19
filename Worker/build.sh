#!/bin/bash -ex

sudo DOCKER_BUILDKIT=1 docker build . -t root_worker:latest