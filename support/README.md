# Support scripts

## gulpupd

The gulpupd script helps customers to keep the shipped images Up-to-date with the latest version of
vertice agent (gulpd)

```bash

# updates the 1.5 version, testing repo
gulpupd --version 1.5 --branch testing

# updates the 1.5 version, stable repo
gulpupd --version 1.5 --branch stable

````


## hook_vertice.rb

hook_vertice.rb triggers MegamVertice when the virtual machine hits the following states. 

`delete`, `suspend`, poweroff`, ` `

## To use the hook_vertice

1. In your OpenNebula installation, edit the `/etc/one/oned.conf` with the following

```
VM_HOOK = [
  name      = "hook_vertice",
  on        = "CUSTOM",
  state     = "ACTIVE",
  lcm_state = "SHUTDOWN_POWEROFF",
  command   = "hook_vertice.rb",
  arguments = "$ID $TEMPLATE STOPPED STOPPED" ]

```

2. Copy the `hook_vertice.rb` file into the location `/var/lib/one/remotes/hooks`

```

wget 

cp hook_vertice.rb /var/lib/one/remotes/hooks

chmod 755 hook_vertice.rb

chown oneadmin:oneadmin hook_vertice.rb

```


## letsencrypt

LetsEncrypt is a certificate authority that  provides free X.509 certificates for Transport Layer Security (TLS) encryption via an automated process designed to eliminate the current complex process of manual creation, validation, signing, installation, and renewal of certificates for secure websites.

The letsencrypt file set in /usr/bin/letsencrypt
This file has the permission in 0755 ie chmod 0755 /usr/bin/letsencrypt

```bash

# install the letsencrypt certificate
letsencrypt --install  <domainame> <domainip>
# remove the letsencrypt certificate
letsencrypt --remove <domainname>

# renewal the letsencrypt certificate
letsencrypt --autorenew <domainname>

````
