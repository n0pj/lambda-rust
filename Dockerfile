# https://github.com/lambci/docker-lambda#documentation
# docker build -t n0pj/lambda-rust:latest .
FROM lambci/lambda:build-provided.al2

ARG RUST_VERSION=1.57.0
RUN yum install -y jq openssl-devel
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | CARGO_HOME=/cargo RUSTUP_HOME=/rustup sh -s -- -y --profile minimal --default-toolchain $RUST_VERSION
RUN yum install -y gcc mysql-devel mysql-libs libmysqlclient-dev
# RUN find / -name "libmysqlclient.so*"
# RUN ls -al /usr/lib64/mysql/libmysqlclient.so.18
ADD build.sh /usr/local/bin/
VOLUME ["/code"]
WORKDIR /code
ENTRYPOINT ["/usr/local/bin/build.sh"]
