FROM --platform=$TARGETPLATFORM ghcr.io/linuxserver/baseimage-rdesktop-web:focal
ARG TARGETPLATFORM

ENV \
  CUSTOM_PORT="8080" \
  GUIAUTOSTART="true" \
  HOME="/config"

RUN \
  echo "**** install runtime packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    gnucash \
    # Thank you docs: https://www.gnucash.org/docs/v4/C/gnucash-guide/basics-files1.html#ftn.idm1300
    libdbd-sqlite3 \
    libdbd-pgsql \
    libdbd-mysql \
    && \
  dbus-uuidgen > /etc/machine-id && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /
