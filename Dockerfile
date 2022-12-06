# Ubuntuの公式コンテナを軸に環境構築
# 22.04ではaptからpython3.8が入っていなかったので20.04で固定する
FROM ubuntu:20.04

# インタラクティブモードにならないようにする
ARG DEBIAN_FRONTEND=noninteractive
# タイムゾーンを日本に設定
ENV TZ=Asia/Tokyo

# （注）iterm2でしか動かない設定
ENV TERM=xterm-256color

# RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

# インフラを整備
RUN apt-get update && \
    apt-get install -y time tzdata tree git curl vim

# C++, Python3, PyPy3をインストール
RUN apt-get update && \
    apt-get install -y gcc-9 g++-9 python3.8 python3-pip pypy3 npm

# 一般的なコマンドで使えるように設定
# e.g. python3.8 main.py => python main.py
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 30 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 30 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.8 30 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 30 && \
    update-alternatives --install /usr/bin/pypy pypy /usr/bin/pypy3 30 && \ 
    update-alternatives --install /usr/bin/node node /usr/bin/nodejs 30

# AtCoderでも使えるPythonライブラリをインストール
RUN pip install -U pip && \
    pip install numpy==1.18.2 scipy==1.4.1 scikit-learn==0.22.2.post1 \
                numba==0.48.0 networkx==2.4

# TypeScriptをインストール
RUN npm install -g typescript@3.8 ts-node 

# nvmをインストール
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# nodeをインストール
RUN . $HOME/.nvm/nvm.sh && \
    nvm install 12.16.1

# AtCoderでも使用できるTypeScriptのライブラリをインストール
RUN npm init -y && \
    tsc --init && \
    npm install -D @types/node@12 tstl

# コンテスト補助アプリケーションをインストール
RUN pip install online-judge-tools==11.5.1
RUN npm install -g atcoder-cli@2.2.0


RUN apt-get update && \
    apt-get install -y wget

COPY ./submit /usr/local/bin/submit
COPY ./check /usr/local/bin/check

RUN chmod 777 /usr/local/bin/submit && \
    chmod 777 /usr/local/bin/check

WORKDIR /root

