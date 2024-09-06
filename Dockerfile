FROM ruby:3.3.4
WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y build-essential sqlite3  \
    sudo vim less tree curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY app/Gemfile* ./
RUN gem install bundler && \
    bundle config set path 'vendor/bundle' && \
    bundle install 
COPY app/ .

ARG UID=1000
ARG GID=1000
ARG USER=devel
RUN groupadd -g $GID $USER && \
    useradd -m -u $UID -g $GID -G sudo $USER && \
    echo $USER:$USER | chpasswd && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN chown -R $USER:$USER /app && \
    chown -R $USER:$USER /usr/local

USER $USER
EXPOSE 4567
#CMD [ "bundle", "exec", "puma", "-c", "conifg/puma.rb" ]
