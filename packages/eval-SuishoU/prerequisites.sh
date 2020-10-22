#!/bin/bash

# curl
if ! (curl --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

# unzip
if ! (unzip -v >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

