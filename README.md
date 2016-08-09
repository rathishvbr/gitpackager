#Gitpackager

Gitpackager helps to build our packages for `Megam Vertice` using Rakefiles.

## Dist Packages

![Trusty](https://github.com/megamsys/packager/blob/master/images/distpackages.png)

## Habitat Plans (WIP)

[Plans](https://github.com/megamsys/habitat_plans)


## Prereqs

- Ubuntu 14 or 16
- Ruby 2.3.x via [rvm](http://devcenter.megam.io/2015/03/03/megam_install_ruby/)
- OpenJDK8
- Golang [1.7](https://golang.org/dl/)
- set GOPATH like the following example


## Using Gitpackager

We build packages for the following flavors.

1. Ubuntu 14, 16
2. Debian jessie
3. CentOS 7

### Before you start

```

export GOPATH=~/.go

export GOROOT=~/software/go

PATH=$GOROOT/bin:$GOPATH/bin

sudo apt-get install mercurial

sudo apt-get install bzr

```

- sbt [0.13.11](http://devcenter.megam.io/2015/03/16/setting-up-scala-sbt-play-akka/)

- Tweak the `version.rb` global variable

- Common files are under *nix* folder

- Every flavor has a `folder` named with the distro name(`jessie, centos`).

- Tweak the `config.rb`

### Let us build our first package `verticecommon` for dist: trusty


1. Go into the directory of *verticecommon*

```

cd packager/verticecommon

rake trusty

```

### Let us build another ruby package `verticenilavu` for dist: jessie

2. Go into the directory of *verticenilavu*

```
cd verticenilavu

rake jessie

```

Similarly other packages can be built.


### sftp packages into get.megam.io server.

```

sftp xxxxxx@get.megam.io
     Password :

cd trusty

put <PACKAGE_NAME>

Push your packages in ~/trusty folder

./dist-repos.sh release=testing dist=trusty version=1.5

```

## Type the url `https://get.megam.io`  You'll see the refreshed packages

Now you are all set.

# Contribution

For [contribution] (https://github.com/megamsys/vertice/blob/master/CONTRIBUTING.md)

# Documentation

For [documentation] (http://docs.megam.io)
    [wiki] (https://github.com/megamsys/vertice/wiki)

# License

MIT


# Authors

Maintainers Megam (<info@megam.io>)
