#!/bin/bash

## Enable needed repos
subscription-manager repos --enable rhel-7-server-ansible-2.9-rpms

## Install git
yum install -y git nano wget curl ansible bridge-utils rhel-system-roles

## Install linux-system-roles network role
## ansible-galaxy install linux-system-roles.network