#!/bin/bash
#
# Install VNC locally, with default settings.
#
# Instructions:
#
# curl -sL https://raw.githubusercontent.com/sdarwin/Ansible-VNC/master/scripts/quickinstall.sh | sudo bash
#
#

set -xe
PATH=/usr/local/bin:$PATH

if [[ -f /usr/bin/apt-get ]]
then
    sudo apt-get update
fi

if ! which git
then
  if [[ -f /usr/bin/apt-get ]]; then
      sudo apt-get install -y git
  fi
  if [[ -f /bin/yum ]]; then
      sudo yum install -y git
  fi
fi

if ! which ansible; then
    if [[ -f /usr/bin/apt-get ]]; then
        sudo apt-get install -y python3-pip python3-venv
    fi
    if [[ -f /bin/yum ]]; then
        . /etc/os-release
        sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-${VERSION_ID:0:1}.noarch.rpm || true
        sudo yum install -y python3-pip python3-venv
    fi
    if [ ! -d ~/venv ]; then
        python3 -m venv ~/venv
    fi
    . ~/venv/bin/activate
    pip3 install ansible ansible-lint yamllint
fi

sudo mkdir -p /etc/ansible/roles
sudo env PATH=$PATH ansible-pull --extra-vars "vnc_desktop=xfce4" -U https://github.com/sdarwin/Ansible-VNC -d /etc/ansible/roles/sdarwin.vnc -i scripts/localinventory default.yml
