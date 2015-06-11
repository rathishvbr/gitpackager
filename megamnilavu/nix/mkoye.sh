#!/bin/sh
# this is amd64 compiled ruby grabbed from source with so enabled.
#refer this gist for details https://gist.github.com/indykish/bedb24f58bbd10da4ee8
wget https://s3-ap-southeast-1.amazonaws.com/megampub/langs/ruby2.2.2.tar.gz

gunzip -c ruby2.2.2.tar.gz | tar -xvf -; rm ruby2.2.2.tar.gz

rm mkoye.sh

mv ruby2.2.2 ruby-2.2.2
