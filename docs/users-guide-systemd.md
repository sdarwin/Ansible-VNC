
### Ansible VNC User's Guide - SystemD Version

It is helpful to understand that VNC has Desktop numbers and TCP/IP port numbers which exactly correspond, as in the following list.

- Port 5901, Desktop :1
- Port 5902, Desktop :2
- Port 5903, Desktop :3
- Port 5904, Desktop :4

For example, your account may be assigned "Port 5901, Desktop :1". What that means, is when connecting with a VNC Viewer, you will use TCP/IP port 5901. At the same time, when running server-side script commands the necessary syntax will be :1, not 5901. So, it just depends on the context, which of those two numbers to use.

- SSH into the target server. Run the command "cat ~/.config/systemd/user/vncserver.service", and view your Desktop Number. It will show :1, or :2, or :3, or :4, etc. After you have determined this value, close the SSH session. You will not need to repeat this step again. It was only to figure out the number. As an example, let's say the number was :4.  That means your TCP/IP Port number is 5904.

- Next, SSH into the target server again. However this time create an SSH tunnel to the destination port. Replace the values in this command.

ssh -L 5901:localhost:5901 _vncuser_@_IP_of_the_server_

-L 5901:localhost:5901 : Specifies that the given port on the local (client) host is to be forwarded to the given host and port on the remote side.
vncuser : vncuser is the user to log in as on the remote machine.
IP_of_the_server : IP address or hostname of your server.

Putty has a similar configuration for tunneling, within the GUI.

Install a VNC viewer on your local computer. Connect to localhost:5901, for example. The initial password should be provided by your administrator. Otherwise, you may reset the password from the ssh session. The command is:

vncpasswd

### SYSTEMD

This document assumes your Administrator has installed VNC as a per-user systemd service.

To manually start the service if it's not running:
systemctl --user start vncserver

To stop the service:
systemctl --user stop vncserver

To check the status of the service:
systemctl --user status vncserver

If you would like to customize VNC parameters, the files to modify are
~/.vnc/xstartup and ~/.config/systemd/user/vncserver.service
After modifying the files you should run
systemctl --user stop vncserver
systemctl --user daemon-reload
systemctl --user start vncserver
