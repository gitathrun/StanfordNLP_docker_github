# StanfordNLP Docker Image #

## Author ##

Teng Fu

Email: teng.fu@teleware.com

## Base Image ##
This is the docker image for NLP task, its baseImage is:

__FROM tftwdockerhub/nlp_devel_docker_github:latest__

## Additional installed packages ##

Pytorch installed:

-  PyTorch: 1.0

For NLP packages:

-  StanfordNLP 0.1.1
-  Oracle Jave 8
-  CoreNLP 2018-10-05

CoreNLP installation is inspired by [konradstrack/corenlp](https://hub.docker.com/r/konradstrack/corenlp/dockerfile)
Java installation is based on [java's official dockerfile](https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile)

All the additional packages are also installed by using Python script in this directory __stanfordnlp_model_download.py__. Developer can customise the resources that is required in main() function.

There are two Jupyter Notebook in the Repo, provide the demo code for the usage of CoreNLP server with StanfordNLP:

- __coreNLP_server_start.ipynb__ for CoreNLP server startup. If developer wish to try the CoreNLP client feature, cmds in this notebook must be run priory to client code. 

- __stanfordNLP_demo.ipynb__ for StanfordNLP code demo.

## Docker Registry Repo ##

-  tftwdockerhub/stanfordNLP-gpu:latest

## Usage ##

on dsvm-gpu virtual machines


```
sudo docker pull tftwdockerhub/stanfordNLP-gpu:latest
```

remember the target port is __8889__
```
sudo nvidia-docker run -it -p 8889:8888 -v \<project-dir-path\>:/app tftwdockerhub/stanfordNLP-gpu:latest
```

In local browser, remember the target port is __8889__ and the token string on CLI screen
```
http://\<vm-ipaddress-or-dns\>:8889/?token=21c5e12xxxxxx
```