FROM ubuntu:14.04
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y wget && \
    apt-get install -y php5-cli libc6-i386 libc6:i386


RUN wget http://archive.debian.org/debian/pool/main/g/gcc-2.95/libstdc++2.10-glibc2.2_2.95.4-27_i386.deb  && \
          dpkg -i libstdc++2.10-glibc2.2_2.95.4-27_i386.deb && \
          rm -rf libstdc++2.10-glibc2.2_2.95.4-27_i386.deb

RUN wget http://archive.debian.org/debian/pool/main/g/gcc-2.95/libstdc++2.10-glibc2.2_2.95.4-27_i386.deb  && \
          dpkg -i libstdc++2.10-glibc2.2_2.95.4-27_i386.deb && \
          rm -rf libstdc++2.10-glibc2.2_2.95.4-27_i386.deb
RUN mkdir -p ~/rtcw
RUN cd ~/rtcw
COPY entrypoint.php .
RUN chmod 777 entrypoint.php

RUN wget -q http://entirely.pro/permanent/rtcw.tar.gz && \
    tar -xvf rtcw.tar.gz && \
    rm -rf rtcw.tar.gz

COPY server_config.cfg main/

CMD ["php", "./entrypoint.php", "0.0.0.0", "27960"]

EXPOSE 28960/tcp
EXPOSE 27960/udp
