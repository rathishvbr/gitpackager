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
The Hook Manager present in OpenNebula enables the triggering of custom scripts tied to a change in state in a particular resource, being that a Host or a Virtual Machine.
Hook Manager configuration is set in /etc/one/oned.conf.

###Hooks for VirtualMachines
<ul class="simple">
<li><strong>name</strong> : for the hook, useful to track the hook (OPTIONAL)</li>
<li><strong>on</strong> : when the hook should be executed,<ul>
<li><strong>CREATE</strong>, when the VM is created (onevm create)</li>
<li><strong>RUNNING</strong>, after the VM is successfully booted</li>
<li><strong>SHUTDOWN</strong>, after the VM is shutdown</li>
<li><strong>STOP</strong>, after the VM is stopped (including VM image transfers)</li>
<li><strong>DONE</strong>, after the VM is destroyed or shutdown</li>
<li><strong>UNKNOWN</strong>, when the VM enters the unknown state</li>
<li><strong>CUSTOM</strong>, user defined specific STATE and LCM_STATE combination of states to trigger the hook.</li>
</ul>
</li>
<li><strong>command</strong> : path can be absolute or relative to <code class="docutils literal"><span class="pre">/var/lib/one/remotes/hooks</span></code></li>
<li><strong>arguments</strong> : for the hook. You can access the following VM attributes with $<ul>
<li><strong>$ID</strong>, the ID of the VM that triggered the hook execution</li>
<li><strong>$TEMPLATE</strong>, the template of the VM that triggered the hook, in xml and base64 encoded</li>
<li><strong>$PREV_STATE</strong>, the previous STATE of the Virtual Machine</li>
<li><strong>$PREV_LCM_STATE</strong>, the previous LCM STATE of the Virtual Machine</li>
</ul>
</li>
<li><strong>remote</strong> : values,<ul>
<li><strong>YES</strong>, The hook is executed in the host where the VM was allocated</li>
<li><strong>NO</strong>, The hook is executed in the OpenNebula server (default)</li>
</ul>
</li>
</ul>
<p>The following is an example of a hook tied to the POWEROFF state of a VM:</p>
<i>
&nbsp;&nbsp;VM_HOOK = [</br>
&nbsp;&nbsp;&nbsp;&nbsp;     name      = "notify_done",</br>
&nbsp;&nbsp;&nbsp;&nbsp;     on        = "DONE",</br>
&nbsp;&nbsp;&nbsp;&nbsp;     command   = "notify.rb",</br>
&nbsp;&nbsp;&nbsp;&nbsp;     arguments = "$ID $TEMPLATE remove destoryed" ]</br>
</i></br>
<p>Or an more advanced example:</p></br>
<i>
&nbsp;&nbsp; VM_HOOK = [</br>
&nbsp;&nbsp;&nbsp;&nbsp;name      = "vertice_hook", </br>
&nbsp;&nbsp;&nbsp;&nbsp;   on        = "CUSTOM",</br>
&nbsp;&nbsp;&nbsp;&nbsp;   state     = "ACTIVE",</br>
&nbsp;&nbsp;&nbsp;&nbsp;   lcm_state = "SHUTDOWN_POWEROFF",</br>
&nbsp;&nbsp;&nbsp;&nbsp;   command   = "post_vertice_sync.rb",</br>
   arguments = "$ID $TEMPLATE $PREV_STATE $PREV_LCM_STATE" ]</br>
</i>

<p>NOTE:  once you have made change in /etc/one/oned.conf, you should restart OpenNebula</p>

put your script file post_vertice_sync.rb in /var/lib/one/remotes/hooks

put your configuration file master_key in /var/lib/megam/ that contains </br></br>

&nbsp;&nbsp; &nbsp;&nbsp; <i> masterkey = 8db82e5d344740b20ed53b8eb672aa7ca0744cfb63368140b06409e1f994ee3f</i> </br>
&nbsp;&nbsp; &nbsp;&nbsp; <i> host = http://192.168.0.100:9000/v2 </i> </br>


## letsencrypt
