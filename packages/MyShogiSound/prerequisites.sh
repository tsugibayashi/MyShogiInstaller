#!/bin/bash

# git
if ! (git --version >& /dev/null); then
    echo "NG" 1>&2
    exit 1
fi

