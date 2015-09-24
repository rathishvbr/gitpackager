packaging
=========

This project helps in packaging megam - private datacenter.

This has rake files that auto-generates builds for Megam.


---
In the first phase we plan to provide _`debs`_.

The list of debian packages built and their dependency are shown below.

* Ubuntu Precise (12.04)
![Precise](https://github.com/megamsys/packager/blob/master/images/precise.png)

* Ubuntu Trusty (14.04)
![Trusty](https://github.com/megamsys/packager/blob/master/images/trusty.png)

`We are working on it. You can give us a hand too.`

* Debian Jessie
* _`rpm`_

How can you build it
-----------------------
Every flavor (ubuntu) has a config.rb and a the version is set in the global version.rb.

Go into one of the directories and

```
cd megamnilavu

#builds a package for trusty
rake

builds a package for precise
rake precise

```




# License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Yeshwanth (<getyesh@megam.io>)
|		       	       | Thomas Alrin (<thomasalrin@megam.io>)
|                      | Rajthilak (<rajthilak@megam.io>)
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

