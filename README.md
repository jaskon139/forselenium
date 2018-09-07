# forselenium


FROM ubuntu:14.04
MAINTAINER CenturyLink

# Install node & npm
RUN apt-get -qqy update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install vim git nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Install Wetty
WORKDIR /opt/wetty
RUN git clone https://github.com/krishnasrinivas/wetty.git . && \
  git reset --hard 223b1b1
RUN npm install

# Set-up term user
RUN useradd -d /home/term -m -s /bin/bash term
RUN echo 'term:term' | chpasswd
RUN sudo adduser term sudo

EXPOSE 3000

# 一键部署 v2ray 到 heroku  [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
