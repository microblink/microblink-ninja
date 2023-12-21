FROM phusion/baseimage:jammy-1.0.1 AS builder

ARG BUILDPLATFORM
ARG NINJA_VERSION=1.11.1

# install build dependencies
RUN apt update && \
    apt install -y g++ make

# build Python from source
RUN pushd /home && \
    curl -o ninja.tar.gz -L https://github.com/ninja-build/ninja/archive/v${NINJA_VERSION}.tar.gz  && \
    tar xf ninja.tar.gz    && \
    mkdir build      && \
    pushd build && \
    ../ninja-${NINJA_VERSION}/configure.py --bootstrap

FROM --platform=$BUILDPLATFORM phusion/baseimage:jammy-1.0.1
COPY --from=builder /home/build/ninja /usr/local/bin/
