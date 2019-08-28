FROM adoptopenjdk/openjdk8:latest

MAINTAINER Shisei Hanai<shanai@jp.ibm.com>

RUN apt-get update
RUN apt-get install jq locales imagemagick curl poppler-utils g++ automake libtool git wget pkg-config unzip libjpeg-dev libpng-dev libtiff5-dev -y

RUN cd /tmp && \
  wget http://www.leptonica.org/source/leptonica-1.74.4.tar.gz && \
  tar xf leptonica-1.74.4.tar.gz && \
  cd leptonica-1.74.4 && \
  ./configure && \
  make && \
  make install && \
  ldconfig && \
  cd .. && \
  rm -rf leptonica-1.74.4.tar.gz leptonica-1.74.4

RUN cd /tmp && \
  wget https://github.com/tesseract-ocr/tesseract/archive/3.05.02.zip && \
  unzip -q 3.05.02.zip && \
  cd tesseract-3.05.02 && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install && \
  ldconfig && \
  cd .. && \
  rm -rf 3.05.02.zip tesseract-3.05.02

RUN mkdir -p /usr/local/share/tessdata && \
  cd /tmp && \
  wget https://github.com/tesseract-ocr/tessdata/archive/3.04.00.zip && \
  unzip -q 3.04.00.zip && \
  cd tessdata-3.04.00 && \
  mv * /usr/local/share/tessdata/ && \
  rm -rf /tmp/3.04.00.zip /tmp/tessdata-3.04.00

RUN apt-get purge g++ automake libtool -y && \
  cd /usr/local/share/tessdata && \
  ls *.traineddata | grep -v jpn.train | grep -v eng.train | xargs rm
