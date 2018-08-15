FROM ubuntu:18.04

RUN mkdir /root/dev.to
WORKDIR /root/dev.to/

# Set up for installing ruby
ADD .ruby-version /root/dev.to/.ruby-version
RUN apt update && apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:${PATH}"
RUN apt install -y curl git && \
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash && \
    rbenv install

# Install gems
ADD Gemfile /root/dev.to/Gemfile
ADD Gemfile.lock /root/dev.to/Gemfile.lock
RUN apt install -y libpq-dev && \
    gem install bundler --conservative && \
    bundle install 

# Install yarn
RUN mkdir bin
ADD bin/yarn /root/dev.to/bin/yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update &&\
    apt install -y yarn && \
    bin/yarn

# Add source
ADD . /root/dev.to
