#!/bin/bash

set -e

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

if [ -z "$1" ]; then
    VERSION="0.15.0"
else
    VERSION=$1
fi

rm -f *.deb

wget -N "https://releases.hashicorp.com/consul-template/${VERSION}/consul-template_${VERSION}_linux_amd64.zip"
unzip -o "consul-template_${VERSION}_linux_amd64.zip" -d usr/bin

fpm -s dir -t deb -n consul-template -v $VERSION usr/bin/consul-template
