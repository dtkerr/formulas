#!/bin/sh
apt install -y build-essential pkg-config libcurl4-gnutls-dev libghc-gnutls-dev asciidoc

if [ -d "uacme" ]; then rm -rf uacme; fi
mkdir uacme
wget -O - https://github.com/ndilieto/uacme/archive/upstream/latest.tar.gz | tar zx -C uacme --strip-components=1
cd uacme
./configure --disable-maintainer-mode
make install
cd ..
rm -rf uacme

apt remove -y build-essential pkg-config libcurl4-gnutls-dev libghc-gnutls-dev asciidoc
apt -y autoremove
