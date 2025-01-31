#!/bin/bash
#
# Installs most prerequisites for testing, without running the final "ansible-playbook" command.
#
# Instructions:
#
# curl -sL https://raw.githubusercontent.com/sdarwin/Ansible-VNC/master/scripts/qa.sh | sudo bash
#
# sudo su -
# cd /etc/ansible
# ansible-playbook --extra-vars "vnc_desktop=xfce4" roles/sdarwin.vnc/default.yml

set -xe
PATH=/usr/local/bin:$PATH

if [[ -f /usr/bin/apt-get ]]
then
    sudo apt-get update
fi

if ! which git; then
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
cd /etc/ansible/roles
sudo git clone https://github.com/sdarwin/Ansible-VNC sdarwin.vnc
