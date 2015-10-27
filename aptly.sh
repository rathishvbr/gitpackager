sudo apt-get install aptly

aptly repo create -comment="testing" -component="testing" -distribution="trusty" testing
aptly repo create -comment="nightly" -component="nightly" -distribution="trusty" nightly
aptly repo add testing megamcib_0.9_amd64.deb
aptly repo add nightly megamcibn_0.9_amd64.deb
aptly publish repo testing
aptly publish repo nightly
