#!/bin/bash

## Enable needed repos
subscription-manager repos --enable rhel-7-server-ansible-2.9-rpms

## Install git
yum install -y git nano wget curl ansible bridge-utils rhel-system-roles python-netaddr

## Install linux-system-roles network role
## ansible-galaxy install linux-system-roles.network

## Reset network prior to set up

nmcli con del $(nmcli -t -f NAME con show | while read p; do echo "\"$p\""; done;)
nmcli con add type ethernet con-name em1 ifname em1
nmcli con up em1