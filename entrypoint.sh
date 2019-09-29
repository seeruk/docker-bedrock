#!/usr/bin/env bash

set -exo pipefail

cd /opt/mcbuild

find /opt/mcserver -maxdepth 0 -empty -exec cp -r ./* /opt/mcserver/ \;

cd /opt/mcserver

LD_LIBRARY_PATH=. ./bedrock_server
