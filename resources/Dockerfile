FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    build-essential \
    ruby-dev \
    ruby-bundler \
    ghostscript \
    pdftk \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-latex-extra \
    texlive-xetex \
 && gem install strscan && rm -rf rm -rf /var/lib/apt/lists/*
COPY resources/Gemfile /opt/
RUN cd /opt/ && bundle install
WORKDIR /data
CMD ["bash", "/data/resources/build.sh"]
