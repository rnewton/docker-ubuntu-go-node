FROM ubuntu:latest

MAINTAINER Robert Newton <robert@newtonmeters.com>

# Add some necessary PPAs
RUN apt-get update && \
    apt-get install -y software-properties-common

RUN apt-get update && \
    add-apt-repository -y ppa:ubuntu-lxc/lxd-stable && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-key adv --keyserver pgp.mit.edu --recv D101F7899D41F3C3 && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install packages
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        git \
        vim \
        zsh \
        golang \
        nodejs \
        npm \
        yarn \
        supervisor

RUN yarn global add pm2

# Slim down the container
RUN apt-get clean

# Create site directory and set it as the default
RUN mkdir /site
WORKDIR /site

# Expose ports
EXPOSE 80

# Copy base supervisor config
ADD ./supervisord.conf /etc/supervisord.conf
RUN mkdir /var/log/supervisord

# Add startup script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# Execute start script
CMD ["/bin/bash", "/start.sh"]
