FROM nvidia/cudagl:10.1-devel-ubuntu16.04

# Setup basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV PATH="/root/miniconda3/bin:$PATH"

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

COPY . .

# create conda environment
RUN conda init bash \
    && conda update conda \
    && . ~/.bashrc \
    && conda env create --name embclip \
    && conda activate embclip \
    && pip install -r requirements.txt

RUN echo "conda activate embclip" >> ~/.bashr

RUN git clone -b habitat --single-branch https://github.com/allenai/embodied-clip.git embclip-habitat
