FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y git \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    llvm-dev \
    libclang-dev \
    clang \
    curl \
    bash-completion \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/sourcegraph/lsif-clang.git \
    && cd /lsif-clang \
    && PATH_TO_LLVM=/usr ./config.sh build \
    && cd build \
    && make \
    && make install \
    && cd / \
    && rm -r lsif-clang \
    && pip3 install compiledb \
    && curl -L https://sourcegraph.com/.api/src-cli/src_linux_amd64 -o /usr/local/bin/src \
    && chmod +x /usr/local/bin/src

WORKDIR /workdir
