#!/usr/bin/env bash
set -euxo pipefail

# needed for wine and bitwig
dpkg --add-architecture i386

apt-get install wget gnupg -y

# add wine key and repo
mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/oracular/winehq-oracular.sources

# update
apt-get update -y && apt-get upgrade -y

# wine staging
apt-get install -y -f --install-recommends \
    "winehq-staging=${WINE_VERSION}" "wine-staging=${WINE_VERSION}" "wine-staging-amd64=${WINE_VERSION}" "wine-staging-i386=${WINE_VERSION}"

# Bitwig Studio deps
apt-get install -y \
    libx11-xcb1 \
    libx11-6 \
    libxau6 \
    libxdmcp6 \
    libxrender1 \
    libxcursor1 \
    libfontconfig1 \
    libxcb-icccm4 \
    libxcb-imdkit1 \
    libxcb-util1 \
    libxcb-shm0 \
    libxcb-xinput0 \
    libxcb-xkb1 \
    libxcb-render0 \
    libxcb-randr0 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    libxcb-ewmh2 \
    libxcb-xfixes0 \
    libxcb-present0 \
    libpixman-1-0 \
    libcairo2 \
    libfreetype6 \
    libxfixes3 \
    libexpat1 \
    libjack-jackd2-0 \
    libasound2-dev \
    xdg-utils \
    zlib1g:i386 \
    libx11-xcb1:i386 \
    libx11-6:i386 \
    libxau6:i386 \
    libxdmcp6:i386 \
    libxrender1:i386 \
    libfontconfig1:i386 \
    libxcb-icccm4:i386 \
    libxcb-util1:i386 \
    libxcb-shm0:i386 \
    libxcb-xinput0:i386 \
    libxkbcommon0:i386 \
    libxkbcommon-x11-0:i386 \
    libpixman-1-0:i386 \
    libcairo2:i386 \
    gtk+3.0 \
    pipewire 

# clean up
apt-get clean