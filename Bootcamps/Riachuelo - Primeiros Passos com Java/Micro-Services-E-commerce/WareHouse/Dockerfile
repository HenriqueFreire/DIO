FROM eclipse-temurin:21-jdk
##FROM eclipse-temurin:21-jdk-alpine
##RUN apt-get update && apt-get install -qq -y --no-install-recommends

ENV INSTALL_PATH /warehouse

RUN mkdir -p ${INSTALL_PATH}

WORKDIR ${INSTALL_PATH}

COPY . .