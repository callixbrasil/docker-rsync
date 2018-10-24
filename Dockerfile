FROM debian:jessie
MAINTAINER orianbsilva <yohanobs@gmail.com>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends rsync tzdata && \
  apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 873
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
