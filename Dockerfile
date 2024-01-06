FROM tensorflow/tensorflow:latest-gpu-jupyter 

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

#install miniconda
RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm /tmp/miniconda.sh

# Set the environment variable to include conda in the PATH
ENV PATH /opt/miniconda/bin:$PATH

# Update conda and install any additional packages as needed
RUN conda update -n base -c defaults conda && \
    conda clean -ya

#install cuda capability for tensorflow
RUN conda install -y cudatoolkit tensorflow && \
    conda clean -ya
RUN pip install -y tensorflow[and-cuda] tensorrt tensorflow-addons 

RUN touch /.dockerenv

CMD ["jupyter", "notebook", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]

