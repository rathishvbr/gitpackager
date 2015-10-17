packaging
=========

This project helps in packaging megam cloud platform.

This has rake files that auto-generates builds for Megam.


---
In the first phase we plan to provide _`debs`_.

The list of debian packages built and their dependency are shown below.

* Ubuntu Trusty (14.04)
![Trusty](https://github.com/megamsys/packager/blob/master/images/trusty.png)

`We are working on the following. You can give us a hand too.`

* Debian Jessie

* _`rpm`_

* [Dockerfiles](https://github.com/megamsys/dockerfiles)

How can you build it
-----------------------

Every flavor (ubuntu) has a config.rb and a the version is set in the global version.rb.

Prerequisites
-----------------------

- Ruby 2.2.x via [rvm](http://devcenter.megam.io/2015/03/03/megam_install_ruby/)
- OpenJDK8
- Golang [1.5](https://golang.org/dl/)
- set GOPATH like the following example

```

export GOPATH=~/.go
export GOROOT=~/software/go
PATH=$GOROOT/bin:$GOPATH/bin

sudo apt-get install mercurial
sudo apt-get install bzr
```
- sbt [0.13.9](http://devcenter.megam.io/2015/03/16/setting-up-scala-sbt-play-akka/)


Builds
-----------------------

Go into the directories of,

*megamcommon*

```

cd packager/megamcommon
rake trusty

```


*megamnilavu*

```
cd megamnilavu

#builds a package for trusty
rake

```

*megamgateway*

```

cd packager/megamgateway
rake trusty

```

*megamsnowflake*

```

cd packager/megamsnowflake
rake trusty

```

*megamd*

```

cd packager/megamd
rake trusty

```

*megamgulpd*

```

cd packager/megamgulpd
rake trusty

```

After building packages, sftp it into get.megam.io server. contact our admin for credential and further instructions

```

sftp root@get.megam.io
     Password :

cd trusty

put <PACKAGE_NAME>

Push your packages in ~/trusty folder

./aptly.sh

```


# License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Yeshwanth (<getyesh@megam.io>)
|		       	           | Thomas Alrin (<thomasalrin@megam.io>)
|                      | Rajthilak (<rajthilak@megam.io>)
|                      | MVijaykanth (<mvijaykanth@megam.io>)
|                      | Kishorekumar Neelamegam (<nkishore@megam.io>)
| **Copyright:**       | Copyright (c) 2013-2015 Megam Systems.
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
