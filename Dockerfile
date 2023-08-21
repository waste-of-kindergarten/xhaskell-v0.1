From ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
	vim \
	net-tools \
	openssh-server \
	build-essential \
	curl \
	libffi-dev \
	libffi7 \
	libgmp-dev \
	libgmp10 \
	libncurses-dev \
	libncurses5 \
	libtinfo5
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'PermitEmptyPasswords no' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'root:haskell' | chpasswd
ENV PATH="/root/.ghcup/bin:/root/.cabal/bin:$PATH"
CMD service ssh restart && /bin/bash

