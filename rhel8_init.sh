#!/bin/bash

## Enable needed repos
subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms

## Install git
dnf install -y git nano wget curl ansible