# for a docker image with:
# CUDA 9.0 + cuDNN 7.x
# Anaconda 5.2 (python 3.6)
# pytorch:latest
# CoreNLP
# StanfordNLP

FROM tftwdockerhub/nlp_devel_docker_github:latest

# the maintainer information
LABEL maintainer "TeleWare Data Scientist <teng.fu@teleware.com>"

# apt-get update

# pytorch installation
# pip installation
RUN conda install pytorch torchvision -c pytorch && conda clean -ya

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# CoreNLP installation
# 2018-10-05 
# is the latest until Jan 2019

ENV CORENLP_ARCHIVE_VERSION=2018-10-05 
ENV CORENLP_ARCHIVE=stanford-corenlp-full-${CORENLP_ARCHIVE_VERSION}.zip \
	CORENLP_HOME=/corenlp

WORKDIR $CORENLP_HOME

RUN wget http://nlp.stanford.edu/software/$CORENLP_ARCHIVE && \
	unzip $CORENLP_ARCHIVE && \
	rm $CORENLP_ARCHIVE

RUN export CORENLP_HOME=$(basename ../$CORENLP_ARCHIVE .zip) && \
	export CLASSPATH="`find . -name '*.jar'`"

# StanfordNLP installation
RUN pip install stanfordnlp

# download model
COPY stanfordnlp_model_download.py /

RUN chmod -R 777 /stanfordnlp_model_download.py && \
	python /stanfordnlp_model_download.py

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# setup the work dir
WORKDIR /app
