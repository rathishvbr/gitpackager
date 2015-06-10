#!/bin/sh

wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz

gunzip -c ruby-2.2.2.tar.gz | tar -xvf -; rm ruby-2.2.2.tar.gz

cd ruby-2.2.2
./configure --prefix=$1  --disable-install-doc --disable-install-rdoc
make
make install

cd ..
rm -rf ruby-2.2.2
