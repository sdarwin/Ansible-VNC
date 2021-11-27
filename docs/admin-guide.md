# Admin Guide

Firstly, refer to users-guide.md in this same directory for information about how to use VNC along with this Ansible role.

Next, the file defaults/main.yml is self-documented. You should read through it carefully. Consider every variable. Set each variable as appropriate for your server environment. That said, the defaults are generally fine to keep in place. The only thing which really ought to be changed is "vnc_users".

Some VNC servers out-of-the-box will require ssh tunnels because they only listen on localhost. This is a secure configuration, since everything is over an encrypted tunnel. Notice the variable vnc_server_options: "-geometry 1280x720 -localhost". The flag -localhost will instruction VNC to only listen on localhost, if it was not already doing so.

### ASSIGNING DESKTOP AND PORT NUMBERS

In the vnc_users variable, you will assigned each user a different desktop and port number. These numbers will be provisioned into their ~/vncstart.sh file (or ~/.config/systemd/user/vncserver.service for systemd). You should inform them "Your desktop is :2, and port number is 5902."

### ANSIBLE MANAGED FILES

A choice to consider is whether or not Ansible ought to manage files such as ~/.vnc/config, ~/.vnc/xstartup, ~/vncstart.sh in such a way that every single time Ansible is run, those files will be overwritten, again and again. Thus, should the files be "ansible managed", or should the user be allowed to customize them? The settings for that choice are found in the variables vnc_ansible_managed_xstartup and vnc_ansible_managed_startup_scripts. They are currently set to False, by design.

### SYSTEMD 

The latest version of TigerVNC, 1.11.0 and later, leverages systemd to start VNC sessions.

### "LEGACY" PER-USER SYSTEMD

In the timeframe of 2018-2020, before TigerVNC adopted systemd, this ansible role implemented an experimental feature to configure per-user systemd services. However, it is optional. And going forward, not necessarily recommended, if the "standard" will be otherwise.  

In order to enable the feature, set "vnc_install_systemd_services: True".  When using this sort of per-user systemd configuration, the users should be advised: if you would like to customize VNC parameters, the files to modify are ~/.vnc/xstartup and ~/.config/systemd/user/vncserver.service . After modifying the files you should run
```
systemctl --user stop vncserver
systemctl --user daemon-reload
systemctl --user start vncserver
```

### FACTOIDS

- Combinations of things that don't work.
  - The systemd per-user strategy doesn't work with RedHat, because RedHat has disabled systemctl --user. Thefore, only use the standard ~/vncstart.sh method.
  - RedHat-8 does not support Xfce. A workaround is included for CentOS-8, so that is still possible.
  - RedHat/CentOS-8 only has tigervnc-server, not vnc4server or tightvnc.
  - The xstartup file doesn't start Gnome-Terminal with the particular combination of Ubuntu17/Tiger/Gnome. Possible solutions include removing or modifying the xstartup file. vnc4server works.

- Debian 9 vnc4server seems to depend on tigervnc-common tigervnc-standalone-server. In other words, you will get Tiger, whether you like it or not, for Debian.

- Debian 9 with Tiger will only listen on localhost, out of the box. Since that is advisable, it is not currently being changed.

- Ubuntu 16 doesn't ship with tigervnc. The Ansible Role will automatically download it for you.

- Debian, xvfce4, required uncommenting
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
from xstartup, in order for gnome-terminal to launch. Since other desktop/vnc could also have the same issue, leave those commands in place.
