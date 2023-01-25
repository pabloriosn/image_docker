FROM nvidia/cudagl:10.1-devel-ubuntu16.04

# Setup basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    vim \
    ca-certificates \
    libjpeg-dev \
    libpng-dev \
    libglfw3-dev \
    libglm-dev \
    libx11-dev \
    libomp-dev \
    libegl1-mesa-dev \
    pkg-config \
    wget \
    zip \
    net-tools \
    unzip &&\
    rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV PATH="/root/miniconda3/bin:$PATH"

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

# Clone repository
RUN git clone -b habitat --single-branch https://github.com/allenai/embodied-clip.git embclip-habitat

# Copy
COPY docs/ embclip-habitat/

# create conda environment
RUN conda init bash \
    && conda update conda \
    && . ~/.bashrc \
    && cd embclip-habitat \
    && conda env create --name embclip \
    && conda activate embclip \
    && pip install -r requirements.txt

