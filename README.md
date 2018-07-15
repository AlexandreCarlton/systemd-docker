# systemd-docker

[![Build Status](https://travis-ci.com/AlexandreCarlton/systemd-docker.svg?branch=master)](https://travis-ci.com/AlexandreCarlton/systemd-docker)

An example of a container using `systemd` (backed by Arch Linux).
This is useful to test out applications that require `systemd` without spawning a virtual machine.

By default, the `root` user is available. To interactively log in, run:

```sh
$ make debug
...
95b657dcf178 login: root
[root@95b657dcf178 ~]#
```
