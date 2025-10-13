FROM eclipse-temurin:21-jdk
##FROM eclipse-temurin:21-jdk-alpine
##RUN apt-get update && apt-get install -qq -y --no-install-recommends
##RUN apk add --no-cache bash

ENV INSTALL_PATH /storefront

RUN mkdir -p ${INSTALL_PATH}

WORKDIR ${INSTALL_PATH}

COPY . .