#create core DRAGON analyzer/root docker image for Cern CentOS7
#Sriteja Upadhyayula, TRIUMF, 2021

FROM ubuntu:14.04
SHELL ["/bin/bash", "-c"]

USER root
ENV USER root

#get some packages
RUN apt-get update -y
RUN apt-get install -y tar openssh-server hostname vim git build-essential curl 

##Dependencies for ROOT
RUN apt-get install -y dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
libxft-dev libxext-dev python libssl-dev

##install ROOT
RUN curl -Ls https://root.cern/download/root_v6.18.04.Linux-ubuntu14-x86_64-gcc4.8.tar.gz | tar zx -C /usr/local
#RUN curl -Ls https://root.cern/download/root_v5.34.38.Linux-ubuntu14-x86_64-gcc4.8.tar.gz | tar zx -C /usr/local       #Root5
ENV ROOTSYS /usr/local/root
#ENV PYTHONPATH $PYTHONPATH:/usr/local/root/lib/root
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/root/lib/root
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/root/bin/root-config
ENV PATH $PATH:/usr/local/root/bin
ENV LIBPATH /usr/local/root

RUN apt-get install -y clang
RUN mkdir -p ~/packages/dragon
RUN printenv
RUN cd ~/packages/dragon && git clone https://github.com/DRAGON-Collaboration/analyzer && cd analyzer && source $ROOTSYS/bin/thisroot.sh && ./configure && make

#Set more ENV
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/packages/dragon/analyzer/lib/
ENV C_INCLUDE_PATH=$C_INCLUDE_PATH:/root/packages/dragon/analyzer/src/midas/libMidasInterface:/root/packages/dragon/analyzer/src/:/root/packages/dragon/analyzer/src/midas
ENV ANALYZER=/root/packages/dragon/analyzer
#Add Root env files
#ADD .rootrc /root/.rootrc
#ADD rootlogon.C /root/rootlogon.C
#ADD start.sh /start.sh
#CMD ["/bin/bash","-c", "/start.sh"]

RUN apt-get install -y firefox xauth

EXPOSE 22
