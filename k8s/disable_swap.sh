#!/bin/bash

export SWAP_FILE=/swap.img

sudo swapoff -v $SWAP_FILE
sudo sed -i '/swap/d' /etc/fstab
sudo rm -f $SWAP_FILE
