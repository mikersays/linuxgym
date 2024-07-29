# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Prevents prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Update and install basic tools
RUN apt-get update && \
    apt-get install -y \
    sudo \
    vim \
    nano \
    curl \
    wget \
    git \
    build-essential \
    man-db \
    less \
    net-tools \
    iputils-ping \
    iproute2 \
    openssh-client \
    passwd \
    tmux \
    screen \
    htop \
    tree \
    lsof \
    strace \
    tcpdump \
    traceroute \
    dnsutils \
    unzip \
    zip \
    gdb \
    nmap \
    iptables \
    jq \
    software-properties-common \
    python3 \
    python3-pip \
    perl \
    ruby \
    rsync \
    acl \
    whois \
    samba \
    cifs-utils \
    nfs-common \
    ftp \
    mailutils && \
    rm -rf /var/lib/apt/lists/*

# Add arguments for UID and GID
ARG USER_ID
ARG GROUP_ID

# Ensure non-root user for practice with specified UID and GID
RUN if ! getent group ${GROUP_ID} ; then groupadd -g ${GROUP_ID} user ; else groupmod -n user $(getent group ${GROUP_ID} | cut -d: -f1) ; fi && \
    if ! id -u ${USER_ID} > /dev/null 2>&1 ; then useradd -u ${USER_ID} -g ${GROUP_ID} -ms /bin/bash user ; else usermod -l user -d /home/user -m $(getent passwd ${USER_ID} | cut -d: -f1) ; fi && \
    echo 'user:password' | chpasswd && \
    adduser user sudo

# Set the default user
USER user
WORKDIR /home/user

# Set the default shell
SHELL ["/bin/bash", "-c"]

# Set the default command
CMD ["bash"]
