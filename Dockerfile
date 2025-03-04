FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1 \
        CUDA_HOME=/usr/local/cuda-11.8 TORCH_CUDA_ARCH_LIST="8.6"
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y --no-install-recommends \
        make \
        wget \
        tar \
        build-essential \
        libgl1-mesa-dev \
        curl \
        unzip \
        git \
        python3-dev \
        python3-pip \
        libglib2.0-0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/bin/python

RUN echo "export PATH=/usr/local/cuda/bin:$PATH" >> /etc/bash.bashrc \
    && echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH" >> /etc/bash.bashrc \
    && echo "export CUDA_HOME=/usr/local/cuda-11.8" >> /etc/bash.bashrc

RUN pip3 install \
        torch \
        torchvision \
        xformers \
        triton \
        --index-url https://download.pytorch.org/whl/cu118

RUN pip3 install \
        diffusers \
        transformers \
        accelerate


WORKDIR /app
