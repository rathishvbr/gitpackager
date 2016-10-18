# Support scripts

## init1.5.sh

The init1.5.sh script helps to update latest version of our cloud agent(`gulpd`) and its configuration(`gulp.conf`) file in the virtual machine auto-magically. 

Replace nsqd and scylla ipaddress from localhost to server ipaddress in this file.

Put init1.5.sh script file into your OpenNebula template FILES location and change file mode to 0755. 

## To use the init1.5.sh

```bash

cd /

mkdir vertice

wget https://raw.githubusercontent.com/megamsys/gitpackager/master/support/init1.5.sh

chmod 755 init1.5.sh


```

## Use this template

```


```

## In the template update

`FILES locatio`


The `init1.5.sh` will executed when virtual machine boots.

Internally the script uses, 

### gulpupd

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

`delete`, `suspend`, `poweroff`, `boot_suspend`

## To use the hook_vertice.rb

1. In your OpenNebula installation, edit the `/etc/one/oned.conf` with the following

```
VM_HOOK = [
 name      = "poweroff_hook",
 on        = "CUSTOM",
 state     = "ACTIVE",
 lcm_state = "SHUTDOWN_POWEROFF",
 command   = "hook_vertice.rb",
 arguments = "$ID $TEMPLATE poweroff stopped" ]

VM_HOOK = [
 name      = "delete_hook",
 on        = "DONE",
 command   = "hook_vertice.rb",
 arguments = "$ID $TEMPLATE destroyed destroyed" ]

VM_HOOK = [
 name      = "suspend_hook",
 on        = "CUSTOM",
 state     = "SUSPENDED",
 lcm_state = "LCM_INIT",
 command   = "hook_vertice.rb",
 arguments = "$ID $TEMPLATE suspended suspended" ]

VM_HOOK = [
 name      = "boot_suspend_hook",
 on        = "CUSTOM",
 state     = "BOOT_SUSPENDED",
 lcm_state = "RUNNING",
 command   = "hook_vertice.rb",
 arguments = "$ID $TEMPLATE running running" ]
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
