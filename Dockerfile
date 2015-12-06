FROM nginx
RUN  apt-get update \
  && apt-get install -y wget git \
  && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_amd64.deb
RUN dpkg -i hugo_0.15_amd64.deb && rm hugo_0.15_amd64.deb
RUN git clone https://github.com/debonairio/website.git \
    && cd website \
    && mkdir static \
    && git submodule init \
    && git submodule update \
    && hugo -t casper
COPY public /usr/share/nginx/html
