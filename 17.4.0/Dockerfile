FROM stakater/base-alpine:3.5
LABEL authors="Hazim <hazim_malik@hotmail.com>"

ARG GOCD_VERSION="17.4.0"
ARG DOWNLOAD_URL="https://download.gocd.io/binaries/17.4.0-4892/generic/go-server-17.4.0-4892.zip"
ARG GID=1001
ARG UID=1001

LABEL gocd.version=${GOCD_VERSION} \
  description="GoCD server for stakater based on alpine"

ADD ${DOWNLOAD_URL} /tmp/go-server.zip

# allow mounting ssh keys, dotfiles, and the go server config and data
VOLUME /home/go /godata

# the ports that go server runs on
EXPOSE 8153 8154

# force encoding
ENV LANG=en_US.utf8

RUN \
# add our user and group first to make sure their IDs get assigned consistently,
# regardless of whatever dependencies get added
  addgroup -g ${GID} go && \
  adduser -D -u ${UID} -G go go && \
# install dependencies and other helpful CLI tools
  apk --update-cache upgrade && \
  apk add --update-cache openjdk8-jre-base git mercurial subversion tini openssh-client su-exec && \
# unzip the zip file into /go-server, after stripping the first path prefix
  unzip /tmp/go-server.zip -d / && \
  rm /tmp/go-server.zip && \
  mv go-server-${GOCD_VERSION} /go-server
  # Install Go CD YAML config plugin

ENV YAML_PLUGIN_VERSION 0.4.0
ADD https://github.com/tomzo/gocd-yaml-config-plugin/releases/download/${YAML_PLUGIN_VERSION}/yaml-config-plugin-${YAML_PLUGIN_VERSION}.jar /gocd-plugins-download/yaml-config-plugin-${YAML_PLUGIN_VERSION}.jar

# Simulate cmd behavior via environment variable
# So that users are able to provice command line arguments to gocd-server
ENV 	COMMAND ""

# Make daemon service dir for gocd-server and place file
# It will be started and maintained by the base image
RUN 	mkdir -p /etc/service/gocd-server
ADD 	start.sh /etc/service/gocd-server/run