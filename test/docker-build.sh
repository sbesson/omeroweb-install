#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}


OS=${OS:-centos7}
OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-3.6}
WEBPORT=${WEBPORT:-80}

WEBSESSION=${WEBSESSION:-}

CACHE=${CACHE:---no-cache}

path=`dirname $0`

rm -rf $path/omeroweb-install-test
mkdir $path/omeroweb-install-test
cp -r $path/../install.sh $path/../common $path/../$OS  $path/omeroweb-install-test
(cd $path && zip -r omeroweb-install-test.zip omeroweb-install-test)
rm -rf $path/omeroweb-install-test

IMAGE=omeroweb_install_test_$OS
echo "Building image $IMAGE"

docker build -t ${IMAGE} ${CACHE} \
    --build-arg OMERO_USER=${OMERO_USER} \
    --build-arg OS=${OS} \
    --build-arg OMEROVER=${OMEROVER} \
    --build-arg WEBPORT=${WEBPORT} \
    --build-arg ICEVER=${ICEVER} \
    --build-arg WEBSESSION=${WEBSESSION} $path -f $path/Dockerfile_$OS
