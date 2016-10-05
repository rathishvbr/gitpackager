# Why

2 problems.

- Lots of packages to build (Ubuntu, Debian, CentOS, Docker, Habitat)
- Enterprise version activated using licensed key similar to `gitlab`, `puppet`

## Best practices

[Gitlab release mgmt](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/doc/release/README.md)
[Puppet release mgmt](https://github.com/puppetlabs/packaging/blob/master/README.md)


# Packaging

This is a repository for packaging automation of Vertice software. We are glad to see our approach followed in `gitlab` or `puppet` hence we decided to extend the `gitpackager` to the next level.

##Tree

![Packages tree](https://github.com/megamsys/packager/blob/master/images/autopackages.png)

1. Ubuntu 14.04, 16.04
2. Debian jessie
3. CentOS 7
4. Habitat [WIP](https://github.com/megamsys/habitat_plans)

## Prereqs

- 16.04
- Ruby 2.3.x via [rvm]
- OpenJDK8
- Golang [1.7.x](https://golang.org/dl/)


## Using the Packaging Repo

Several Vertice projects are using the packaging repo. They are:

* vertice
* verticegateway
* verticegulpd
* verticevnc
* verticecadvisor

as well as closed-source projects, including
* verticenilavu

Generally speaking, the packaging repo should be compatible with ruby 2.3.x,
and rake latest.

The tasks are generally grouped into two categories
- `package:`
- `ve:` namespaced tasks.

## `package` tasks

`package` tasks are general purpose tasks that are set up to use the most minimal tool
chain possible for creating packages. These tasks will create rpms and debs, but any
build dependencies will need to be satisifed by the building host, and any dynamically
generated dependencies may result in packages that are only suitable for the
OS/version of the build host.

- To build a deb, do `rake ubuntu`.

- To build a rpm, do `rake centos`.

## `ve:` tasks

There is also a `ve:` namespace, for the building of Vertice enterprise packages that
have been converted to using this repo.

The `ve:` tasks rely heavily on megam internal infrastructure, and are not
generally useful outside of this environment.

There are `ve:deb_all` and `ve:rpm_all` tasks, which build packages against all
shipped debian/redhat targets.


# Vertice release process

Our main goal is to make it clear which version of Vertice is in the package.

# How is the official vertice package built

The official package build is fully automated by Megam Systems.

We can differentiate between two types of build:

* Packages for release to get.megam.io
* Packages for test to get.megam.io/testing

Both types are built on the same infrastructure.

## Infrastructure

Each package is built on the platform in Ubuntu Xenial using fpm.

The gitpackager projectt fully utilizes GitLab CI. This means that each push
to gitpackager repository will trigger a build in GitLab CI which will
then create a package.

This remote is located on get.megam.io.

All build servers run [gitlab runner] and all runners use a deploy key
to connect to the projects on gitlab.org/megamsys, github.com/megamsys.

The build servers also have access to a special Amazon S3 bucket which stores
the gulpd tar ball.

## Build process

Megam Systems is using the [gitpackager](https://github.com/megamsys/gitpackager) to automate
the release tasks for every release. When the release manager starts the release process, a couple
of important things for gitpackager will be done:

1. All remotes of the project will be synced
2. The versions of components will be read from Vertice ME/EE repository
3. A specific Git tag will be created and synced to gitpackager repositories

When the gitpackager repository on get.megam.io gets updated, GitLab CI
build gets triggered.

The specific steps can be seen in `.gitlab-ci.yml` file in gitpackager
repository. The builds are executed on all platforms at the same time.

During the build, gitpackager will pull external libraries from their source
locations and Vertice components like vertice, nilavu, vertice_gateway, and
so on will be pulled from get.megam.io.

Once the build completes and the .deb or .rpm packages are built, depending on
the build type package will be pushed to get.megam.io or to a S3 bucket.

## Specifying component versions manually
### On your development machine

1. Pick a tag of Vertice to package (e.g. `v1.5.0`).
2. Create a release branch in gitpackager (e.g. `1-5-0-rc0`).
4. If the release branch already exists, for instance because you are doing a
  patch release, make sure to pull the latest changes to your local machine:

    ```
    git pull https://github.com/megamsys/gitpackager 1.5.0-stable # existing release branch
    ```

1. Use `support/set-revisions` to set the revisions of files in
  `config/software/`. It will take tag names and look up the Git SHA1's, and set
  the download sources to get.megam.io. Use `set-revisions --ee` for an EE
  release:

    ```
    # usage: set-revisions [--ee] VERTICE_NILAVU_REF

    # For Vertice ME:
    support/set-revisions v1.5.0

    # For Vertice EE:
    support/set-revisions --ee v1.5.0-ee
    ```

2. Commit the new version to the release branch:

    ```shell
    git add VERSION
    git commit
    ```

3. Create an annotated tag on gitlab corresponding to the Vertice tag.
  The gitpackager tag looks like: `MAJOR.MINOR.PATCH+OTHER.GITPACKAGER_RELEASE`, where
  `MAJOR.MINOR.PATCH` is the Vertice version, `OTHER` can be something like `me`,
  `ee` or `rc1.me` (or `rc1.ee`), and `GITPACKAGER_RELEASE` is a number (starting at 0):

    ```shell
    git tag -a 1.5.0+me.0 -m 'Pin Vertice to v1.5.0'
    ```

    **WARNING:** Do NOT use a hyphen `-` anywhere in the gitpackager tag.

    Examples of converting an upstream version tag to an gitpackager tag sequence:

| upstream tag     | gitpackager tag sequence                    |
|------------------|---------------------------------------------|
| `v1.5.0.rc1`     | `1.5.0.rc1.0+me.0`, `1.5.0.rc1+me.1`, `...` |
| `v1.5.0`         | `1.5.0+me.0`, `1.5.0+ce.1`, `..  .`         |
| `v1.7-ee`        | `1.7+ee.0`, `1.7+ee.1`, `...`               |
| `v2.0.rc1-ee`    | `2.0+rc1.ee.0`, `2.0+rc1.ee.1`, `...`       |
| `v2.0.0-ee`      | `2.0+ee.0`, `2.0+ee.1`, `...`               |
| `v2.0.0-ee`      | `2.0+ee.0`, `2.0+ee.1`, `...`               |


5. Push the branch and the tag to github.com:

    ```shell
    git push git@github.com/megamsys/gitpackager.git 1-5-0-rc1 1.5.0.rc1+me.0
    ```

    Pushing an annotated tag to github.com triggers a package release.

### Publishing the packages

You can track the progress of package building on [gitlab.org/megamsys/gitpackager].
They are pushed to [get.megam.io repositories](https://get.megam.io) automatically after
successful builds.

[release-tools project]: https://github.com/megamsys/gitpackager
[gitlab runner]: https://gitlab.com/gitlab-org/gitlab-ci-multi-runner
[get.megam.io repositories]: https://get.megam.io

We have notifiers to slack channel [#releng]

### Type the url `https://get.megam.io`  You'll see the refreshed packages

[Coming  - soon : Notifiers via Android app]


# License

MIT


# Authors

Humans Megam (<info@megam.io>)
