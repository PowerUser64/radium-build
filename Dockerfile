FROM ubuntu as setup

RUN apt-get update
RUN apt-get install -y unzip wget
WORKDIR /root
ADD https://github.com/kmatheussen/radium/archive/refs/tags/7.0.00.tar.gz .
RUN tar xf 7.0.00.tar.gz
RUN mkdir SDKs
WORKDIR /root/SDKs
RUN wget -q https://web.archive.org/web/20190111193507/https://www.steinberg.net/sdk_downloads/vstsdk367_03_03_2017_build_352.zip
RUN unzip vstsdk367_03_03_2017_build_352.zip

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN apt-get install -y libc6-dev binutils-dev python2-dev libasound2-dev libjack-jackd2-dev libresample1-dev liblrdf0-dev libsndfile1-dev ladspa-sdk libglib2.0-dev calf-plugins binutils-dev libc6-dev tk8.6-dev libogg-dev libvorbis-dev libspeex-dev fftw-dev fftw3-dev guile-2.2-dev libxkbfile-dev x11-utils cmake libiberty-dev libfreetype6-dev libxinerama-dev libxcursor-dev libxrandr-dev libboost-all-dev libssl-dev libncurses-dev libxcb-keysyms1-dev libgmp-dev libgmp3-dev libmpfr-dev libmpc-dev libsamplerate0-dev build-essential libgl1-mesa-dev libpulse-dev libxcb-glx0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-render0 libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcb-util1 libxcb-xfixes0 libxcb-xinerama0 libxcb1 libxkbcommon-x11-0 qt5-qmake qtbase5-dev cmake libatomic-ops-dev libqt5webkit5-dev qttools5-dev libqt5svg5-dev liblo-dev libqt5x11extras5-dev unzip

ENV QT_QPA_PLATFORM_PLUGIN_PATH /usr/lib/x86_64-linux-gnu/qt5/plugins
ENV RADIUM_QT_VERSION 5
ENV QT_SELECT qt5
ENV LD_LIBRARY_PATH /usr/local/lib
ENV CFLAGS -I/root/SDKs/VST_SDK/VST2_SDK
ENV PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig
ENV BUILDTYPE RELEASE 
ENV INCLUDE_FAUSTDEV_BUT_NOT_LLVM jadda
WORKDIR /root/radium-7.0.00/bin/packages/
RUN sed -i "112 a     make -j`nproc` || echo \"retrying\"" build.sh
WORKDIR /root/radium-7.0.00
from setup as build
RUN make -j`nproc` packages
RUN ./build_linux.sh  -j `nproc`
from build as install
RUN ./install.sh /root
RUN cp -R ladspa_info /root/radium/ladspa
