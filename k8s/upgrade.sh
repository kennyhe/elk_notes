#!/bin/bash

# update the default route
route del default dev enp0s8

# update repo list and upgrade
apt update
yes |apt upgrade
yes |apt autoremove

