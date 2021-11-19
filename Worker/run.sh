#!/bin/bash -ex

usage() { echo "usage: $0 ANALYSIS_DIR KRB_TOKEN_PATH" 1>&2; exit 1; }

if [[ $# -lt 2 ]]; then usage; fi

ANALYSIS_DIR=$(pwd)/"$1"
KRB_TOKEN_PATH="$2"

# kinit -f jkusnier@CERN.CH

sudo docker run -it --rm \
    -v $ANALYSIS_DIR:/usr/local/analysis \
    -e KRB5CCNAME=/tmp/certs \
    -v /tmp/krb5cc_1000:/tmp/certs \
    -w=/usr/local/analysis \
    --net host root_worker
    # -v /eos:/eos \

    