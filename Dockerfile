FROM ubuntu:16.04

MAINTAINER SHOP Team <ateam@zalora.com>

WORKDIR "/root/"

RUN apt-get update
# curl for rbenv downloading stuff
RUN apt-get install -y nodejs git vim curl bzip2 build-essential libssl-dev libreadline-dev zlib1g-dev npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
WORKDIR "/root/.rbenv/plugins/ruby-build"
RUN sh install.sh

RUN rbenv install 2.3.0
RUN rbenv global 2.3.0

RUN npm install -g npm
RUN npm install -g gulp
# Rehash the built-in command map so that it uses the latest npm we installed here.
RUN hash -r

WORKDIR "/root/"
