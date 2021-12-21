FROM --platform=$BUILDPLATFORM amazonlinux:2 as builder

ARG NINJA_VERSION=1.10.2

# install build dependencies
RUN yum -y install gcc-c++ make tar gzip

# build Python from source
RUN pushd /home && \
    curl -o ninja.tar.gz -L https://github.com/ninja-build/ninja/archive/v${NINJA_VERSION}.tar.gz  && \
    tar xf ninja.tar.gz    && \
    mkdir build      && \
    pushd build && \
    ../ninja-${NINJA_VERSION}/configure.py --bootstrap

FROM --platform=$BUILDPLATFORM amazonlinux:2
COPY --from=builder /home/build/ninja /usr/local/bin/
