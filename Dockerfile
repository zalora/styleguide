FROM ubuntu:16.04

MAINTAINER SHOP Team <ateam@zalora.com>

WORKDIR "/root/"

# curl for rbenv downloading stuff
RUN apt-get update && apt-get install -y nodejs git vim curl bzip2 build-essential libssl-dev libreadline-dev zlib1g-dev npm

RUN ln -s /usr/bin/nodejs /usr/bin/node

ENV RBENV /root/.rbenv
RUN git clone https://github.com/rbenv/rbenv.git $RBENV
ENV PATH $RBENV/bin:$PATH

RUN echo 'eval "$(rbenv init -)"' >> .bashrc

RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
WORKDIR "$RBENV/plugins/ruby-build"
RUN sh install.sh

RUN rbenv install 2.3.0 && rbenv global 2.3.0

RUN npm install -g npm gulp

# Rehash the built-in command map so that it uses the latest npm we installed here.
RUN hash -r

WORKDIR "/root/"
