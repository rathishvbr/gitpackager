sudo apt-get install aptly 

aptly repo create -comment="testing" -component="testing" -distribution="trustly" testing
aptly repo create -comment="dev" -component="developing" -distribution="trust" developing
aptly repo add testing megamcib_0.9_amd64.deb
aptly repo add developing megamcibn_0.9_amd64.deb
aptly publish repo testing
aptly publish repo developing

