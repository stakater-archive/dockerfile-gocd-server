#!/bin/bash
_gocdserver_version="17.1.0"
_gocdserver_tag="${_gocdserver_version}"
_release_build=$1

echo "GOCD-SERVER_VERSION: ${_gocdserver_version}"
echo "DOCKER TAG: ${_gocdserver_tag}"
echo "RELEASE BUILD: ${_release_build}"

docker build --tag "stakater/gocd-server:${_gocdserver_tag}"  --no-cache=true .

if [ $_release_build == true ]; then
	docker build --tag "stakater/gocd-server:latest"  --no-cache=true .
        docker push "stakater/gocd-server:${_gocdserver_tag}"
        docker push "stakater/gocd-server:latest"
fi
