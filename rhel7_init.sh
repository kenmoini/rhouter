#!/bin/bash

## Enable needed repos
subscription-manager repos --enable rhel-7-server-ansible-2.9-rpms

## Install git
dnf install -y git nano wget curl ansible