FROM         gocd/gocd-server:17.1.0
MAINTAINER   Ahmad <ahmad@aurorasolutions.io>


RUN          apt-get -y update \
             && apt-get -y install wget \
             && apt-get clean

# Install Go CD YAML config plugin
RUN          wget -q https://github.com/tomzo/gocd-yaml-config-plugin/releases/download/0.4.0/yaml-config-plugin-0.4.0.jar\
                  -P /gocd-data/server/plugins/

