FROM ubuntu:16.04
# Install build dependencies (and vim + picocom for editing/debugging)
RUN apt-get -qq update \
    && apt-get install -y git wget make libncurses-dev flex bison gperf python python-serial vim picocom \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# make dir
RUN mkdir -p /esp
# toolchain
RUN wget -O /esp/esp-32-toolchain.tar.gz https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz \
    && tar -xzf /esp/esp-32-toolchain.tar.gz -C /esp \
    && rm /esp/esp-32-toolchain.tar.gz
# clone idf and adf
RUN git clone --recursive https://github.com/espressif/esp-idf.git /esp/esp-idf
RUN git clone --recursive https://github.com/whyengineer/esp-adf.git /esp/esp-adf
# Add the toolchain binaries to PATH
ENV PATH /esp/xtensa-esp32-elf/bin:$PATH
ENV IDF_PATH /esp/esp-idf
ENV ADF_PATH /esp/esp-adf


WORKDIR /esp