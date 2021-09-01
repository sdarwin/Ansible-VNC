# Ansible-VNC

Installs and configures VNC Server/Desktop. By default, this will be TigerVNC and Gnome. However, you may easily select from a few others including

VNC Servers: TigerVNC, TightVNC, vnc4server
Desktops: Gnome, Xfce4
Operating Systems: Ubuntu, Debian, Redhat, Centos, Amazon Linux

## Requirements

A recent version of Linux, see meta/main.yml.

## Example Playbook

An example playbook is included at default.yml in the root directory. To run it:

ansible-playbook default.yml

## Instructions

Copy the contents of defaults/main.yml to your local groups_vars/all and modify as necessary. Review each variable carefully. This serves as the "config file", so by customizing the default variables you adjust the installation. At minimum, the vnc_users variable in that file should likely be set for your particular environment. The other settings are optional.

Review the documentation included in this repo:<br/>
docs/admin-guide.md<br/>
docs/users-guide.md<br/>
docs/users-guide-systemd.md

## Quickstart

Most of the instructions assume a standard Ansible infrastructure.

However, if you have just launched a single new remote test server, and would like to very quickly install VNC without much setup or configuration:

```
curl -sL https://raw.githubusercontent.com/sdarwin/Ansible-VNC/master/scripts/quickinstall.sh | sudo bash
```

## License

GPLv2

## Author Information

By Sam Darwin, 2018. Feedback and bug reports welcome.

[![Analytics](https://ga-beacon.appspot.com/UA-112361697-1/Ansible-VNC)](https://github.com/igrigorik/ga-beacon)
