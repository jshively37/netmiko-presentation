FROM ubuntu:latest

MAINTAINER Jeff Shively <jeffrey.shively@wwt.com>

ARG PROJECT_DIR=/development

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH="/init:${PATH}"


# Set environment variables
ENV ANSIBLE_VERSION  2.9.6
ENV PYTHONWARNINGS "ignore:Unverified HTTPS request"
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_SSH_PIPELINING True
ENV ANSIBLE_CONFIG /etc/ansible/ansible.cfg
ENV ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python
ENV NET_TEXTFSM=/ntc-templates/templates

# Packages to be installed on Image
ENV BUILD_PACKAGES \
    curl \
    git \
    python3-pip

# Python dependencies for containers
ENV PYTHON_PKGS \
    ansible==${ANSIBLE_VERSION} \
    cryptography>=2.5 \
    jupyterlab \
    genie \
    netmiko \
    pyats

RUN echo "===> Upgrade and upgrade apt..."  && \
    apt-get update -y && apt-get upgrade -y && \
    \
    echo "===> Adding BUILD PACKAGES..."  && \
    apt  install ${BUILD_PACKAGES} -y

RUN echo "===> Installing Python packages..."  && \
    pip3 install $PYTHON_PKGS

RUN echo "===> Link PIP and Python" && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [ ! -e /usr/bin/python ]; then ln -s python3 /usr/bin/python; fi

# Create Working directory
RUN echo "===> creating working directory..."  && \
    mkdir /etc/ansible/ /ansible  && \
    mkdir -p $PROJECT_DIR  && \
    echo "chmod -R a+rx /init"

RUN echo "==> Cloning down repositories.." && \
    git clone https://github.com/networktocode/ntc-templates.git

# Set working directory
WORKDIR $PROJECT_DIR
CMD ["/bin/sh"]

EXPOSE 8888