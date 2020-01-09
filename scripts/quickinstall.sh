#!/bin/bash
# 
# Instructions:
#
# curl -sL https://raw.githubusercontent.com/sdarwin/Ansible-VNC/master/scripts/quickinstall.sh | sudo bash
#
#

if ! which ansible 
then
  if [[ -f /usr/bin/apt-get ]]
  then
    sudo apt-get update
    sudo apt-get install -y python3-pip
    sudo pip3 install ansible
  fi
  if [[ -f /bin/yum ]]
  then
    sudo yum install epel-release
    sudo yum install python34-pip
    sudo pip install ansible
  fi
fi

sudo ansible-pull -U https://github.com/sdarwin/Ansible-VNC -d /tmp/Ansible-VNC -i scripts/localinventory default.yml

