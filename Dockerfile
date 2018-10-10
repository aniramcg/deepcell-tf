# Use the nvidia tensorflow:18.08-py3 image as the parent image
FROM nvcr.io/nvidia/tensorflow:18.08-py3

# System maintenance
RUN apt-get update && apt-get install -y \
        python3-tk \
        libsm6 && \
    rm -rf /var/lib/apt/lists/* && \
    /usr/local/bin/pip install --upgrade pip

# Set working directory
WORKDIR /deepcell-tf

# Copy the setup.py and requirements.txt and install the deepcell-tf dependencies
COPY setup.py requirements.txt /opt/deepcell-tf/
RUN pip install -r /opt/deepcell-tf/requirements.txt

# Copy the rest of the package code and its scripts
COPY deepcell /opt/deepcell-tf/deepcell
COPY scripts /deepcell-tf/scripts

# Install deepcell via setup.py
RUN pip install /opt/deepcell-tf

# Change matplotlibrc file to use the Agg backend
RUN echo "backend : Agg" > /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc
