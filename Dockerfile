# syntax = docker/dockerfile:1.0-experimental

# This is the base dockerfile to be used with the BUILDKIT to build the 
# image that the .devcontainer docker image is based on
FROM quay.io/mhildenb/jboss-webserver31-tomcat8-openshift:latest

USER root

RUN --mount=type=secret,id=myuser --mount=type=secret,id=mypass \
    subscription-manager register --username=$(cat /run/secrets/myuser) \
    --password=$(cat /run/secrets/mypass) --auto-attach

RUN yum install -y git zsh && \
    curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.3.0/openshift-client-linux-4.3.0.tar.gz | tar zxvf - -C /usr/local/bin

RUN subscription-manager unregister

USER jboss

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"