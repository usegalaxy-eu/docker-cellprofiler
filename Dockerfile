FROM jlesage/baseimage-gui:ubuntu-22.04-v4.7.1 AS build

ENV DEBIAN_FRONTEND=noninteractive

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV CONDA_BIN_PATH="/opt/conda/bin"
ENV PATH=$CONDA_BIN_PATH:"/opt/conda/envs/cellprofiler/bin":$PATH
ENV LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libstdc++.so.6"
ENV MPLCONFIGDIR="/tmp"

RUN apt-get update \
 && apt-get install -y --no-install-recommends locales \
 && sed -i 's/^# *\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen \
 && locale-gen \
 && update-locale LANG=en_US.UTF-8 \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get upgrade -y && apt-get install -y make gcc build-essential libgtk-3-dev gnome-icon-theme hicolor-icon-theme gnome-themes-standard

RUN apt-get install -y --no-install-recommends tzdata apt-utils wget unzip python-is-python3 python3-pip openjdk-11-jdk-headless default-libmysqlclient-dev git libnotify-dev libsdl2-dev && \
    apt-get install -y \
          freeglut3 \
          freeglut3-dev \
          libgl1-mesa-dev \
          libglu1-mesa-dev \
          libgstreamer-plugins-base1.0-dev \
          libgtk-3-dev \
          libjpeg-dev \
          libnotify-dev \
          libsdl2-dev \
          libsm-dev \
          libtiff-dev \
          libwebkit2gtk-4.0-dev \
          libxtst-dev && \
    apt-get clean && \ 
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

WORKDIR /tmp
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh \
    && bash Miniforge3-Linux-x86_64.sh -b -p /opt/conda \
    && rm -f Miniforge3-Linux-x86_64.sh 

RUN conda create -y --name cellprofiler python=3.8 numpy==1.24.4 matplotlib pandas mysqlclient=1.4.6 sentry-sdk=0.18.0 openjdk scikit-learn mahotas gtk2 Jinja2=3.0.1 wxpython=4.1.0 -c conda-forge -c bioconda && \
    conda run --name cellprofiler python -m pip install cellprofiler

EXPOSE 5800

COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

ENV APP_NAME="CellProfiler"


ENV TAKE_CONFIG_OWNERSHIP=1

COPY rc.xml.template /opt/base/etc/openbox/rc.xml.template

WORKDIR /config
