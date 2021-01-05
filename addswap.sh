#!/bin/sh

sudo dd if=/dev/zero of=/swap1 bs=1M count=4096
sudo mkswap /swap1
sudo swapon /swap1
sudo bash -c "echo '/swap1 swap swap' >> /etc/fstab"
