# Admin Guide

Firstly, refer to the files users-guide.md and users-guide-systemd.md in this same directory for information about how to use VNC along with this Ansible role.

Next, the file defaults/main.yml is self-documented. You should read through it carefully. Consider every variable. Set each variable as appropriate for your server environment. That said, the defaults are generally fine to keep in place. The only thing which really ought to be changed is "vnc_users".

Some VNC servers out-of-the-box will require ssh tunnels because they only listen on localhost. This is a secure configuration, since everything is over an encrypted tunnel. Notice the variable vnc_client_options: "-geometry 1280x720 -localhost". The flag -localhost will instruction VNC to only listen on localhost, if it was not already doing so.

### TigerVNC update - 1.11.0 - Sept 2020

TigerVNC has changed the way VNC servers are administered. They have switched to using systemd service files instead of running the vncserver command manually. The role now supports that, by setting vnc_paradigm=version2.  When using a more traditional, older VNC server, set vnc_paradigm=version1.

This update is still in flux, and the way it is handled may be redesigned.  

### ASSIGNING DESKTOP AND PORT NUMBERS

In the vnc_users variable, you will assigned each user a different desktop and port number. These numbers will be provisioned into their ~/vncstart.sh file (or ~/.config/systemd/user/vncserver.service for systemd). You should inform them "Your desktop is :2, and port number is 5902."

### ANSIBLE MANAGED FILES

A choice to consider is whether or not Ansible ought to manage files such as ~/.vnc/config, ~/.vnc/xstartup, ~/vncstart.sh in such a way that every single time Ansible is run, those files will be overwritten, again and again. Thus, should the files be "ansible managed", or should the user be allowed to customize them? The settings for that choice are found in the variables vnc_ansible_managed_xstartup and vnc_ansible_managed_startup_scripts. They are currently set to False, by design.

### SYSTEMD 

The latest version of TigerVNC leverages systemd to start VNC sessions.

### "LEGACY" PER-USER SYSTEMD

In the timeframe of 2018-2020, before TigerVNC adopted systemd, this ansible role implemented an experimental feature to configure per-user systemd services. However, it is optional. In order to enable the feature, set vnc_install_systemd_services: True 

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
