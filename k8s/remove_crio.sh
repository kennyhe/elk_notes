#!/bin/bash

sudo systemctl stop crio
sudo apt remove -y cri-o cri-o-runc
sudo apt autoremove -y
sudo rm -rf /etc/apt/sources.list.d/*cri-o*
